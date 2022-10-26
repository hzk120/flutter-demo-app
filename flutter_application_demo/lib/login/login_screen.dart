import 'package:flutter/material.dart';
import 'package:flutter_application_demo/login/login_controller.dart';
import 'package:flutter_application_demo/login/login_model.dart';
import 'package:flutter_application_demo/login/login_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 8, horizontal: 40),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 500,
                  //height: 400,
                  child: Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 199, 201, 217),
                      ),
                      //borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color.fromRGBO(249, 251, 255, 1),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/settyl-black.logo.svg"),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                'Sign in to your Account',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                //textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.tight(const Size(500, 250)),
                            child: Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email",
                                        style: GoogleFonts.inter(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  5, 10.0, 5.0, 10.0),
                                          hintText: "Enter Email",
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 199, 201, 217),
                                            ),
                                          ),
                                        ),
                                        controller: loginController
                                            .userNameEditingController,
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        "Password",
                                        style: GoogleFonts.inter(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  5, 10.0, 5.0, 10.0),
                                          hintText: "Enter Password",
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 199, 201, 217),
                                            ),
                                          ),
                                        ),
                                        controller: loginController
                                            .passwordEditingController,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(120, 42)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Color.fromRGBO(32, 32, 148, 1),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState != null &&
                                            !_formKey.currentState!
                                                .validate()) {
                                          return;
                                        } else {
                                          var loginErrors = "";

                                          if (loginController
                                                  .userNameEditingController
                                                  .text
                                                  .isEmpty ||
                                              loginController
                                                  .passwordEditingController
                                                  .text
                                                  .isEmpty) {
                                            if (loginController
                                                .userNameEditingController
                                                .text
                                                .isEmpty) {
                                              loginErrors +=
                                                  "Username is Mandatory\n";
                                            }

                                            if (loginController
                                                .passwordEditingController
                                                .text
                                                .isEmpty) {
                                              loginErrors +=
                                                  "Password is Mandatory\n";
                                            }

                                            print(loginErrors);

                                            Get.defaultDialog(
                                              title: 'Alert',
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    loginErrors,
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            3, 24, 66, 1)),
                                                  )
                                                ],
                                              ),
                                              textCancel: 'OK',
                                              buttonColor: const Color.fromRGBO(
                                                  3, 24, 66, 1),
                                              backgroundColor: Colors.white,
                                              titleStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      3, 24, 66, 1)),
                                            );

                                            return;
                                          }

                                          var loginRequest = LoginRequestModel(
                                              userName: loginController
                                                  .userNameEditingController
                                                  .text,
                                              password: loginController
                                                  .passwordEditingController
                                                  .text);

                                          LoginService(loginRequest)
                                              .userLogin()
                                              .then((loginStatus) {
                                            if (loginStatus.status ==
                                                "Success") {
                                              print("Logged in Successfully");
                                              Get.toNamed('/');
                                            } else {
                                              print("Error while logged in");

                                              Get.snackbar('Login Failed!',
                                                  '${loginStatus.message}.Please Try Again',
                                                  backgroundColor: Colors.red,
                                                  icon: const Icon(
                                                      Icons.remove_circle),
                                                  maxWidth: 500,
                                                  colorText: Colors.white);
                                            }
                                          });
                                        }
                                      },
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w200,
                                          letterSpacing: 0.75,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(120, 42)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Color.fromARGB(255, 32, 32, 196),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/home');
                                      },
                                      child: const Text(
                                        'Skip Sign In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w200,
                                          letterSpacing: 0.75,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
