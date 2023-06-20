// ignore_for_file: avoid__addCheck



import 'package:flutter/material.dart';
import 'package:project_reunite/Pages/CallView/callview.dart';
import 'package:project_reunite/Pages/HomeView/homeview.dart';
import 'package:project_reunite/Pages/logic_page.dart';
import 'package:project_reunite/common/get_it.dart';
import 'package:project_reunite/firebase_options.dart';
import 'package:project_reunite/themedata/themedata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freerasp/freerasp.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<String> checks = [];
  @override
  void initState() {
    super.initState();
    //initTalsec();
  }

  void _addCheck(String check) {
    setState(() {
      checks.add(check);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Project reunite",
      theme: AppData.theme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomeView(),
        '/call-room': (context) => const CallRoom()
      },
    );
  }

//   void initTalsec() {
//     const hash =
//         '69:F6:2F:1B:3D:5A:A3:88:DF:4A:AF:F8:A4:08:9C:43:F0:66:5F:52:22:F3:C1';
//     String base64Hash = hashConverter.fromBase64toSha256(hash);
//     final app = TalsecApp(
//         config: TalsecConfig(
//           watcherMail: 'coderslab.satyaprakash@gmail.com',
//           androidConfig: AndroidConfig(
//               expectedPackageName: 'com.lazyowl.project_reunite.it',
//               expectedSigningCertificateHashes: [base64Hash],
//               supportedAlternativeStores: ['adb']),
//         ),
//         callback: TalsecCallback(
//             onDebuggerDetected: () => _addCheck("don't do these dubug shit bro"),
//             androidCallback: AndroidCallback(
//               onDeviceBindingDetected: () =>
//                   _addCheck("don't do these dubug shit bro"),
//               onEmulatorDetected: () => _addCheck("don't do these dubug shit bro"),
//               onHookDetected: () => _addCheck("don't do these dubug shit bro"),
//               onRootDetected: () => _addCheck("don't do these dubug shit bro"),
//               onUntrustedInstallationDetected: () =>
//                   _addCheck("don't do these dubug shit bro"),
//               onTamperDetected: () => _addCheck("don't do these dubug shit bro"),
//             )));
//     //app.start();
//   }
 }
