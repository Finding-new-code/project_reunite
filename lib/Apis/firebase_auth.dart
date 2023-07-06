// // ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class auth {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? get currentUser => _auth.currentUser;

//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   Future<void> PhoneSignin(
//     BuildContext context,
//     String phonenumber,
//   ) async {
//     TextEditingController CodeController = TextEditingController();
//     if (kIsWeb) {
//       ConfirmationResult result =
//           await _auth.signInWithPhoneNumber(phonenumber);

//            // ignore: use_build_context_synchronously
//            OTPdialog(
//           controller: CodeController,
//           context: context,
//           OnPressed: () async {
//             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                 verificationId: result.verificationId ,
//                 smsCode: CodeController.text.trim());

//             await _auth.signInWithCredential(credential);
//             Navigator.of(context).pop();
//           },
//         );
//     } else
//     {
//       await _auth.verifyPhoneNumber(
//       phoneNumber: phonenumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await _auth.signInWithCredential(credential);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e.message);
//       },
//       codeSent: (String? verificationID, int? resendtoken) async {
//         // String smsInt = '';

//         OTPdialog(
//           controller: CodeController,
//           context: context,
//           OnPressed: () async {
//             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                 verificationId: verificationID ?? 'some went wrong (125)',
//                 smsCode: CodeController.text.trim());

//             await _auth.signInWithCredential(credential);
//             Navigator.of(context).pop();
//           },
//         );
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         print('code auto retrieval timeout');
//       },
//       timeout: const Duration(minutes: 30),
//     );
//     }
  
//   }

//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }

// void OTPdialog(
//     {required BuildContext context,
//     required TextEditingController controller,
//     required VoidCallback OnPressed}) {
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (Context) => AlertDialog(
//             title: const Text('Enter OTP'),
//             content: Column(
//               children: <Widget>[
//                 TextField(
//                   controller: controller,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(onPressed: OnPressed, child: const Text('done'))
//             ],
//           ));
// }
