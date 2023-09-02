// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:project_reunite/Apis/webrtc.dart';
import 'package:project_reunite/common/common.dart';

import 'package:project_reunite/common/widgets/shareroom.dart';
import 'package:project_reunite/constants/export.dart';
import '../../common/get_it.dart';

class CallRoom extends StatefulWidget {
  const CallRoom({super.key, this.roomID});
  final String? roomID;
  @override
  State<CallRoom> createState() => _CallRoomState();
}

class _CallRoomState extends State<CallRoom> {
  late var signalling = GetIt.I.get<Signalling>();
  // late final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  // late final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  String? roomID;
  bool someoneJoin = false;
  bool isVideoON = true;
  bool isMicON = true;
  //final User? user = auth().currentUser;

  @override
  void initState() {
    super.initState();

    signalling = getIt<Signalling>();

    // _initializeRenderers().then((value) {
    //   signalling
    //       .openUserMedia(_localRenderer, _remoteRenderer)
    //       .then((value) => setState(() {}));
    // });

    signalling.onAddRemoteStream = (stream) {
      signalling.remoteRenderer!.srcObject = stream;
      someoneJoinRoom();
    };
    signalling.onLeaveremoteStream = (() {
      signalling.remoteRenderer!.srcObject = null;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (roomID != null) {
        showShareRoomidDialog(context, widget.roomID!);
      } else {
        showEnterRoomIDDialog(context);
      }
    });
  }

  @override
  void dispose() {
    // _localRenderer.dispose();
    // _remoteRenderer.dispose();
    signalling.dispose();
    super.dispose();
  }

  someoneJoinRoom() {
    someoneJoin = true;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('some leave to your room 🔴')));
    setState(() {});
  }

  someoneleaveRoom() {
    someoneJoin = false;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('some join to your room via room id 👋')));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width <= 600
        ? Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Expanded(
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: RTCVideoView(
                          signalling.remoteRenderer!,
                          filterQuality: FilterQuality.none,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
                          mirror: true,
                        ),
                      ),
                    ),
                  ),
                  // AnimatedPositioned(
                  //   duration: const Duration(milliseconds: 700),
                  //   top:
                  //       someoneJoin ? MediaQuery.of(context).viewPadding.top + 10 : 0,
                  //   bottom: someoneJoin ? size.height * 0.69 : 0,
                  //   left: someoneJoin ? 10 : 0,
                  //   right: 0,
                  //   child:
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    height: someoneJoin ? 250 : size.height,
                    width: someoneJoin ? 300 : double.infinity,
                    margin: someoneJoin
                        ? EdgeInsets.only(
                            top: MediaQuery.of(context).viewPadding.top + 10,
                            right: 10)
                        : EdgeInsets.zero,
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(someoneJoin ? 30 : 0))),
                    child: RTCVideoView(
                      signalling.localRenderer!,
                      mirror: true,
                      filterQuality: FilterQuality.none,
                      //objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
                      placeholderBuilder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.hub_outlined),
                      ),
                    ),
                  ),
                  // ),
                  Positioned(
                      top: 300,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: ButtonBar(context),
                      ))
                ],
              ),
            ),
          )
         : 
  Scaffold(
            appBar: AppBar(
              title: Text(
                widget.roomID.toString(),
                style: GoogleFonts.robotoFlex(color: Colors.white),
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: widget.roomID.toString()));
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Copy ot the Clipboard')));
                    },
                    icon: const Icon(Icons.copy_outlined))
              ],
            ),
            body: Stack(
              fit: StackFit.passthrough,
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Align(
                      alignment: Alignment.center,
                      child: AnimatedStackContainer(
                          width: size.width - 200,
                          height: size.height - 200,
                          children: Expanded(child: RTCVideoView(signalling.remoteRenderer!)))),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: size.height - 600, right: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: AnimatedStackContainer(
                          width: 200, height: 100, children: Expanded(child: RTCVideoView(signalling.localRenderer!,mirror: true,)))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height - 200),
                  child: ButtonBar(context),
                )
              ],
            ),
          );
  }

  Row ButtonBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 40,
          child: FilledButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade800)),
              clipBehavior: Clip.antiAlias,
              onPressed: () async {
                await getIt<Signalling>().hangUp();
                Navigator.pop(context, true);
              },
              icon: const Icon(
                Icons.call_end,
                color: Colors.white,
              ),
              label: const Text('Hang Up')),
        ),
        const SizedBox(
          width: 10,
        ),

        ///button for mic mute --->
        circularButton(() {
          isMicON = getIt<Signalling>().muteMic();
          setState(() {});
        },
            Colors.white,
            isMicON
                ? const Icon(Icons.mic_sharp)
                : const Icon(Icons.mic_off_sharp)),

        ///button for call hang up --->
        // circularButton(() async {
        //   //await getIt<Signalling>().hangUp();
        //   print("hung up bro");
        //   Navigator.pop(context, true);
        // }, const Color.fromARGB(255, 182, 40, 38),
        //     const Icon(Icons.call_end_sharp)),
        const SizedBox(
          width: 10,
        ),

        ///button for extra option-->
        circularButton(() {
          if (widget.roomID != null) {
            showShareRoomidDialog(context, widget.roomID!);
          } else {
            showEnterRoomIDDialog(context);
          }
        }, Colors.indigo.shade50, const Icon(Icons.menu_sharp)),
      ],
    );
  }
}
