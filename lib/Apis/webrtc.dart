// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_reunite/common/widgets/error.dart';
import 'package:project_reunite/constants/export.dart';

typedef StreamStateCallback = void Function(MediaStream stream);

class Signalling {
  /// confrigation for room or peer connection
  Map<String, dynamic> configuration = {
    "sdpSematics": "plan-b",
    'ice servers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ],
    'optional': [
      {'dtlsSrtpKeyAgreement': true}
    ],
  };

  RTCVideoRenderer? localRenderer;
  RTCVideoRenderer? remoteRenderer;
  RTCPeerConnection? peerConnection;
  List<RTCPeerConnection?> peerConnectionList = [];
  MediaStream? localStream;
  MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;

  VoidCallback? onLeaveremoteStream;

  /// initalize all the components --> initialize pharse
  initialize() async {
    localRenderer = RTCVideoRenderer();
    remoteRenderer = RTCVideoRenderer();
    await localRenderer!.initialize();
    await remoteRenderer!.initialize();
    await openUserMedia(localRenderer!, remoteRenderer!);
  }

  /// dispose method
  dispose() async {
    await localRenderer?.dispose();
    await remoteRenderer?.dispose();
    await peerConnection?.dispose();
    await remoteStream?.dispose();
  }

  /// functions for create a peer- connection or room --> 1st step
  Future<String> createRoom() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomref = db.collection('rooms').doc();
    debugPrint('Creating a peer-connection with cofiguration: $configuration');

    peerConnection = await createPeerConnection(configuration);
    //await newPeerConnection(roomref);

    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((element) {
      peerConnection?.addTrack(element, localStream!);
    });

    // code for collecting ICE candidates below
    var callerCandidatesCollection = roomref.collection('callerCandidates');

    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      debugPrint('got a ice candidates: ${candidate.toMap()}');
      callerCandidatesCollection.add(candidate.toMap());
    };
    // finish code for collecting ice candidates

    // code for creating a room
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection?.setLocalDescription(offer);
    debugPrint('created offer: $offer');

    Map<String, dynamic> roomWithOffer = {
      'offer': offer.toMap(),
      "call_status": "started"
    };

    await roomref.set(roomWithOffer);
    var roomId = roomref.id;
    debugPrint('new rooom created with offer. RoomID: $roomId');
    currentRoomText = 'Current room is $roomId - you are the caller!';
    // room created

    peerConnection?.onTrack = (RTCTrackEvent event) {
      debugPrint('Got remote track: ${event.streams[0]}');

      event.streams[0].getTracks().forEach((element) {
        debugPrint('add a track to the remoteStream $element');
        remoteStream?.addTrack(element);
      });
    };

    // Listening for remote session desicription below
    roomref.snapshots().listen((event) async {
      debugPrint('got updated room: ${event.data()}');

      Map<String, dynamic> data = event.data() as Map<String, dynamic>;
      if (peerConnection?.getRemoteDescription() != null &&
          data['answer'] != null) {
        var answer = RTCSessionDescription(
          data['answer']['spd'],
          data['answer']['type'],
        );

        print('some tried to connect');
        await peerConnectionList.last?.setRemoteDescription(answer);
        // await newPeerConnection(roomRef);
      }
    });

    // Listen for remote ICE candidates below
    roomref.collection('calleeCandidates').snapshots().listen((event) {
      for (var element in event.docChanges) {
        if (element.type == DocumentChangeType.added) {
          Map<String, dynamic> data =
              element.doc.data() as Map<String, dynamic>;
          print('Got a new remote ICE candidate : ${jsonEncode(data)}');

          peerConnectionList.last?.addCandidate(RTCIceCandidate(
              data['candidates'], data['sdpMid'], data['spdMLineIndex']));
        }
      }
    });

    return roomId;
  }

  /// function for join someone room -->  looks fine
  Future<void> joinRoom(String eroomId) async {
    roomId = eroomId;
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('rooms').doc(roomId);
    var roomsnapshot = await roomRef.get();
    print('got room ${roomsnapshot.exists}');

    if (roomsnapshot.exists) {
      print("Create PeerConnection with configuration $configuration");
      peerConnection = await createPeerConnection(configuration);

      registerPeerConnectionListeners();

      localStream?.getTracks().forEach((element) {
        peerConnection?.addTrack(element, localStream!);
      });

      //// code for collecting ICE Candidates below
      var calleeCandidatesCollection = roomRef.collection('calleeCandidates');
      peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
        // ignore: unnecessary_null_comparison
        if (candidate == null) {
          print("onICECandidates : complete!");
          return;
        }
        print("OnICEcandidates: ${candidate.toMap()}");
        calleeCandidatesCollection.add(candidate.toMap());
      };

      peerConnection!.onTrack = (RTCTrackEvent event) {
        print("Got remote track : ${event.streams[0]}");
        event.streams[0].getTracks().forEach((element) {
          print("Add a track o the remoteStream: $element");
          remoteStream?.addTrack(element);
        });
      };

      // code for creating SDP answer below
      var data = roomsnapshot.data() as Map<String, dynamic>;
      print("Got offer $data");
      var offer = data['offer'];
      try {
        await peerConnection?.setRemoteDescription(
          RTCSessionDescription(offer['spd'], offer['type']),
        );
      } on Exception catch (e) {
        print("error occuring in setRemoteDescrption :- $e");
      }
      var answer = await peerConnection!.createAnswer();
      print("Created Answer: $answer");

      await peerConnection?.setLocalDescription(answer);

      Map<String, dynamic> roomWithAnswer = {
        'answer': {'type': answer.type, 'spd': answer.sdp},
        'call-status': "started",
      };

      await roomRef.update(roomWithAnswer);
      // finishing creating sdp answer

      // listening for remote ICE candidates below

      roomRef.collection('callerCandidates').snapshots().listen((event) {
        event.docChanges.forEach((document) {
          var data = document.doc.data() as Map<String, dynamic>;
          print(data);
          print("got new remote ICE candidates: $data");
          peerConnection!.addCandidate(
            RTCIceCandidate(
                data['candidate'], data['sdpMid'], data['sdpMLineIndex']),
          );
        });
      });

      roomRef.snapshots().listen((event) {
        Map<String, dynamic> data = event.data() as Map<String, dynamic>;
        if (data['call_status'] == "ended") {
          onLeaveremoteStream!.call();
        }
      });
    }
  }

  /// functon for user media use to distribute media --> looks fine
  Future<void> openUserMedia(
    RTCVideoRenderer localVideo,
    RTCVideoRenderer remoteVideo,
  ) async {
    try {
      var stream = await navigator.mediaDevices
          .getUserMedia({'video': true, 'audio': true});

      localVideo.srcObject = stream;
      localStream = stream;

      remoteVideo.srcObject = await createLocalMediaStream('key');
    } on Exception catch (e) {
      print(e);
    }
  }

  /// fuctions for end video call -- > looks nothing
  Future<void> hangUp() async {
    List<MediaStreamTrack> tracks = localRenderer!.srcObject!.getTracks();
    for (var track in tracks) {
      track.stop();
    }

    if (remoteStream != null) {
      remoteStream!.getTracks().forEach((track) => track.stop());
    }
    if (peerConnection != null) peerConnection?.close();

    if (roomId != null) {
      var db = FirebaseFirestore.instance;
      var roomRef = db.collection('rooms').doc(roomId);
      var calleeCandidates = await roomRef.collection('calleeCandidates').get();
      calleeCandidates.docs.forEach((document) => document.reference.delete());

      var callerCandidates = await roomRef.collection('callerCandidates').get();
      callerCandidates.docs.forEach((document) => document.reference.delete());

      await roomRef.delete();
    }

    localStream?.dispose();
    remoteStream?.dispose();
  }

  void registerPeerConnectionListeners() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state change: $state');
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
    };

    peerConnection?.onAddStream = (MediaStream stream) {
      print("Add remote stream");
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };

    peerConnection?.onRemoveStream = (MediaStream stream) {
      print("remove Stream : ${stream.id}");
      if (remoteStream != null) onLeaveremoteStream?.call();
      // remoteStream = null;
    };

    peerConnection?.onSignalingState = (state) {
      print("Signaling state : ${state.toString()}");
    };
  }

  bool muteMic() {
    if (localStream != null) {
      bool enabled = localStream!.getAudioTracks()[0].enabled;
      localStream?.getAudioTracks()[0].enabled = !enabled;
      return localStream!.getAudioTracks()[0].enabled;
    }
    return true;
  }

  bool stopVideo() {
    if (localStream != null) {
      bool enabled = localStream!.getVideoTracks()[0].enabled;
      localStream!.getVideoTracks()[0].enabled = !enabled;
      return localStream!.getVideoTracks()[0].enabled;
    }
    return true;
  }
}
