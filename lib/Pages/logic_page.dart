import 'package:flutter/material.dart';
import 'package:project_reunite/Apis/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_reunite/common/common.dart';
import 'package:project_reunite/common/get_it.dart';
import 'package:project_reunite/common/widgets/beta_banner.dart';
import 'package:project_reunite/constants/export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final User? user = auth().currentUser;
  Future<void> signOut() async {
    await auth().signOut();
  }

  late AnimationController _controller;
  late Animation<double> _animation;
  String? error;
  bool islogin = true;
  final phonenumber = TextEditingController();
  final otp = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 2.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    otp.dispose();
    phonenumber.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return size <= 600
        ? Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  betaBanner(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 100, right: 100, top: 100, bottom: 50),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform:
                              Matrix4.identity().scaled(_animation.value),
                          child: Image.asset(AssetsManeger.appicon),
                        );
                      },
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text: 'Welcome to Project Reunite',
                        style: GoogleFonts.robotoFlex(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text:
                                  "\nIts a 3 phares beta Programe to test new feature integration\n and VAPT etc",
                              style: GoogleFonts.inter(
                                color: Colors.white60,
                                fontSize: 12,
                              ))
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                    child: TextfieldUI(
                      controller: phonenumber,
                      hintText: "Enter your phone number",
                      obscureText: false,
                    ),
                  ),
                  const Divider(
                    color: Colors.blue,
                    thickness: 0.5,
                    indent: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextfieldUI(
                      controller: otp,
                      hintText: "Enter otp",
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonUI(
                    wsize: 50,
                    hsize: 10,
                    onpressed: () async {
                      //getIt<auth>().PhoneSignin(context, phonenumber.text);
                      Navigator.pushNamed(context, '/home');
                    },
                    text: "Proceed",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "By CoderLabs",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54),
                  ),
                  
                ],
              ),
            ),
          )
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                      .scaled(_animation.value),
                                  child: Image.asset(AssetsManeger.appicon),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text.rich(
                            TextSpan(
                                text: 'Welcome to Project Reunite',
                                style: GoogleFonts.robotoFlex(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text:
                                          "\nIts a 3 phares beta Programe to test new feature integration\n and VAPT etc",
                                      style: GoogleFonts.inter(
                                        color: Colors.white60,
                                        fontSize: 12,
                                      ))
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const VerticalDivider(),
                      Column(
                        children: [
                          TextfieldUI(
                            controller: phonenumber,
                            hintText: "Enter your phone number",
                            obscureText: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
