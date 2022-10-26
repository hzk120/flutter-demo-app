import 'package:flutter/material.dart';
import 'package:flutter_application_demo/widgets/Custom_AppBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 249, 255, 1), // rgba
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Text(
                  'Low Code Visibility Platform',
                  style: GoogleFonts.inter(
                    fontSize: 42,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Advanced designer and workflow automation',
                  style: GoogleFonts.inter(
                    fontSize: 42,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Wrap(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: [
                    Container(
                      width: 300,
                      height: 250,
                      child: Card(
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 199, 201, 217),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Color.fromRGBO(246, 249, 255,
                            1), // Color.fromRGBO(246, 249, 255, 1) Color.fromRGBO(249, 251, 255, 1)
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "wand-logo.svg",
                                width: 55,
                                height: 55,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Design',
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Provision to customize or add new capabilities without any IT skills',
                                //softWrap: true,
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 30,
                    // ),
                    Container(
                      width: 300,
                      height: 250,
                      child: Card(
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 199, 201, 217),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Color.fromRGBO(246, 249, 255,
                            1), // Color.fromRGBO(246, 249, 255, 1) Color.fromRGBO(249, 251, 255, 1)
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "lock-logo.svg",
                                width: 55,
                                height: 55,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Configure',
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Multi context & multi-tenant capabilities to configure specific supply chain flows',
                                //softWrap: true,
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 30,
                    // ),
                    Container(
                      width: 300,
                      height: 250,
                      child: Card(
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 199, 201, 217),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Color.fromRGBO(246, 249, 255,
                            1), // Color.fromRGBO(246, 249, 255, 1) Color.fromRGBO(249, 251, 255, 1)
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "setting-logo.svg",
                                width: 55,
                                height: 55,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Integrate',
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Integrate anything to be an acclaimed system of record.',
                                //softWrap: true,
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
