import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_reunite/Apis/firebase_auth.dart';
import 'package:project_reunite/Pages/CallView/callview.dart';
import 'package:project_reunite/common/get_it.dart';
import 'package:project_reunite/common/widgets/beta_banner.dart';
import 'package:project_reunite/constants/export.dart';
import '../../Apis/webrtc.dart';
import 'package:project_reunite/common/common.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  //final User? user = auth().currentUser;
  final signalling = GetIt.I.get<Signalling>();
  // Signalling signalling = Signalling();
  // final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  // final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  // String? roomId;
  // TextEditingController enterID = TextEditingController();
  // bool _offer = false;
  // late RTCPeerConnection _peerConnection;
  // late final MediaStream _localStream;

  @override
  void initState() {
    super.initState();
    //signalling.initialize();
    //   signalling.onAddRemoteStream = (stream) {
    //     _remoteRenderer.srcObject = stream;
    //     setState(() {});
    //   };

    //   signalling.onAddRemoteStream = (stream) {
    //     _localRenderer.srcObject = stream;
    //     setState(() {});
    //   };
  }

  @override
  void dispose() {
   // signalling.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? roomId;

    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.viewPaddingOf(context).top * 2),
        child:
          AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: 
           Image.asset(
            AssetsManeger.transIcon,
            fit: BoxFit.contain,
          ),
        ),
      
       ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          betaBanner1(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text.rich(TextSpan(
                  text: 'WELCOME,👋\n',
                  style: GoogleFonts.aBeeZee(
                    color: Colors.cyan,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  children: [
                    TextSpan(
                        text: "",
                        style: GoogleFonts.anton(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey))
                  ])),
            ),
          ),
          AnimatedStackContainer(
            width: 330,
            height: 180,
            children: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "wanna join a room with friends? then create one",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoFlex(
                      color: Colors.indigo,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      ButtonUI(
                        onpressed: () async {
                          final signalling = getIt<Signalling>();
                          await signalling.initialize();
                          roomId = await signalling.createRoom();
                          if (roomId != null) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CallRoom(
                                      roomID: roomId,
                                    )));
                          }
                        },
                        text: 'create room',
                        hsize: 10,
                        wsize: 15,
                      ),
                      ButtonUI(
                          onpressed: () async {
                            await getIt<Signalling>().initialize();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, '/call-room');
                          },
                          text: "join room")
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
