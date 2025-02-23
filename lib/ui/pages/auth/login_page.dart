import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ColorNotifire notifire;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    emailController.text = 'juan@mail.com';
    passwordController.text = '1234567';
    getdarkmodepreviousstate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: CustomAppbar(
              centertext: "",
              ActionIcon: null,
              bgcolor: notifire.getbgcolor,
              actioniconcolor: notifire.getwhiteblackcolor,
              leadingiconcolor: notifire.getwhiteblackcolor)),
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
                    color: notifire.getwhiteblackcolor,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text("Please login to your account",
                    style: TextStyle(
                      fontSize: 14,
                      color: notifire.getgreycolor,
                      fontFamily: "Gilroy Medium",
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text("Phone Number",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Gilroy Medium",
                        color: notifire.getwhiteblackcolor)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                textfield(
                    controller: emailController,
                    feildcolor: notifire.getdarkmodecolor,
                    hintcolor: notifire.getgreycolor,
                    text: 'Enter your number',
                    prefix: Image.asset("assets/images/call.png",
                        height: 25, color: notifire.getgreycolor),
                    suffix: null),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Gilroy Medium",
                      color: notifire.getwhiteblackcolor),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                textfield(
                    controller: passwordController,
                    feildcolor: notifire.getdarkmodecolor,
                    hintcolor: notifire.getgreycolor,
                    text: 'Enter your password',
                    prefix: Image.asset("assets/images/password.png",
                        height: 25, color: notifire.getgreycolor),
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
                        color: notifire.getdarkbluecolor,
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
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: const CircularProgressIndicator());
                }
                return AppButton(
                    buttontext: "Iniciar Sesión",
                    onclick: () {
                      context.read<AuthBloc>().add(AuthLoginEvent(
                          emailController.text, passwordController.text));
                    });
              },
              listener: (context, state) {
                if (state is AuthLoginSuccess) {
                  context.push('/menu-viajero');
                } else if (state is AuthLoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            ),
            const SizedBox(height: 15),
            Center(
              child: Column(
                children: [
                  Text(
                    "Or login with",
                    style: TextStyle(
                        fontSize: 15,
                        color: notifire.getgreycolor,
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
                      color: notifire.getdarkmodecolor),
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
                                  color: notifire.getwhiteblackcolor),
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
                        color: notifire.getwhiteblackcolor)),
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const creatscreen()));
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16,
                      color: notifire.getdarkbluecolor,
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
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}
