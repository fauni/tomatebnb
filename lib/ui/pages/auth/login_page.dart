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
    getMode();
    super.initState();
  }

  late bool? isAnfitrion = false;

  void getMode() async {
    final prefs = await SharedPreferences.getInstance();
    isAnfitrion = prefs.getBool("setIsAnfitrion");
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
                  "Bienvenido a TomateBnb",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text("Acceda a su cuenta",
                    style: TextStyle(
                      fontSize: 14,
                      color: notifire.getgreycolor,
                      fontFamily: "Gilroy Medium",
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text("Correo Electrónico",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Gilroy Medium",
                        color: notifire.getwhiteblackcolor)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                textfield(
                    controller: emailController,
                    feildcolor: notifire.getdarkmodecolor,
                    hintcolor: notifire.getgreycolor,
                    text: 'Ingresa tu Correo Electrónico',
                    prefix: Icon(Icons.email_outlined, color: Theme.of(context).colorScheme.primary,),
                    suffix: null),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  "Contraseña",
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
                    "Olvidaste tu contraseña?",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary,
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
                    }, context: context);
              },
              listener: (context, state) {
                if (state is AuthLoginSuccess) {
                  if(isAnfitrion == null || isAnfitrion == false){
                    context.pushReplacement('/menu-viajero');
                  } else {
                    context.pushReplacement('/menu-anfitrion');
                  }
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
                    "o inicie sesión con",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.tertiary,
                        fontFamily: "c"),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),  
                ),
                onPressed: () {
                
                }, 
                label: Text('Google'),
                icon: Image.asset("assets/images/google.png", width: 30,),
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.all(12),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: notifire.getdarkmodecolor),
            //       // margin: EdgeInsets.only(top: 12),
            //       height: 50,
            //       width: MediaQuery.of(context).size.width/1.0,
            //       child: InkWell(
            //         onTap: () {},
            //         child: ClipRRect(
            //           borderRadius: const BorderRadius.all(Radius.circular(50)),
            //           child: Center(
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Image.asset("assets/images/google.png",
            //                     fit: BoxFit.fill),
            //                 SizedBox(width: 10,),
            //                 Text(
            //                   "Google",
            //                   style: TextStyle(
            //                       fontSize: 17,
            //                       fontFamily: "Gilroy Medium",
            //                       color: Colors.black),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     // Container(
            //     //     decoration: BoxDecoration(
            //     //       borderRadius: BorderRadius.circular(50),
            //     //     ),
            //     //     // margin: EdgeInsets.only(top: 12),
            //     //     height: 50,
            //     //     width: MediaQuery.of(context).size.width / 2.3,
            //     //     child: InkWell(
            //     //       onTap: () {},
            //     //       child: ClipRRect(
            //     //         borderRadius:
            //     //             const BorderRadius.all(Radius.circular(50)),
            //     //         child: Image.asset("assets/images/facebook.png",
            //     //             fit: BoxFit.fitWidth),
            //     //       ),
            //     //     ),
            //     // ),
            //   ],
            // ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No tienes una cuenta?",
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
                    "Registrar",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
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
