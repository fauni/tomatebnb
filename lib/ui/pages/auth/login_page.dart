import 'package:flutter/material.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late ColorNotifire notifire;

  @override
  void initState() {
    // getdarkmodepreviousstate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: CustomAppbar(
              centertext: "",
              ActionIcon: null,
              // bgcolor: notifire.getbgcolor,
              // actioniconcolor: notifire.getwhiteblackcolor,
              // leadingiconcolor: notifire.getwhiteblackcolor
              )
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to GoHotel",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    // color: notifire.getwhiteblackcolor,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text("Please login to your account",
                    style: TextStyle(
                      fontSize: 14,
                      // color: notifire.getgreycolor,
                      fontFamily: "Gilroy Medium",
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text("Phone Number",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Gilroy Medium",
                        // color: notifire.getwhiteblackcolor
                      )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                textfield(
                    // feildcolor: notifire.getdarkmodecolor,
                    // hintcolor: notifire.getgreycolor,
                    text: 'Enter your number',
                    prefix: Image.asset("assets/images/call.png",
                        height: 25, 
                        // color: notifire.getgreycolor
                      ),
                    suffix: null),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Gilroy Medium",
                      // color: notifire.getwhiteblackcolor
                    ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                textfield(
                    // feildcolor: notifire.getdarkmodecolor,
                    // hintcolor: notifire.getgreycolor,
                    text: 'Enter your password',
                    prefix: Image.asset("assets/images/password.png",
                        height: 25, 
                        // color: notifire.getgreycolor
                    ),
                    suffix: null),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: InkWell(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const forgotpassword(),
                    //   ),
                    // );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 15,
                        // color: notifire.getdarkbluecolor,
                        fontFamily: "Gilroy Medium"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton(
                buttontext: "Login",
                onclick: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const homepage()));
                }),
            const SizedBox(height: 15),
            Center(
              child: Column(
                children: [
                  Text(
                    "Or login with",
                    style: TextStyle(
                        fontSize: 15,
                        // color: notifire.getgreycolor,
                        fontFamily: "c"),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // color: notifire.getdarkmodecolor
                    ),
                  // margin: EdgeInsets.only(top: 12),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/images/google.png",
                                fit: BoxFit.fill),
                            Text(
                              "Google",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Gilroy Medium",
                                  // color: notifire.getwhiteblackcolor
                                ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    // margin: EdgeInsets.only(top: 12),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: Image.asset("assets/images/facebook.png",
                            fit: BoxFit.fitWidth),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don’t have an account?",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Gilroy Medium",
                        // color: notifire.getwhiteblackcolor
                      )),
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const creatscreen()));
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16,
                      // color: notifire.getdarkbluecolor,
                      fontFamily: "Gilroy Medium",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      // notifire.setIsDark = false;
    } else {
      // notifire.setIsDark = previusstate;
    }
  }
}