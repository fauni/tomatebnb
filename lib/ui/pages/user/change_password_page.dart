import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
 late ColorNotifire notifire;

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }
  bool obscureText = true;
  bool obscureTextConfirm = true;
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppbar(
          centertext: "",
          ActionIcon: null,
          bgcolor: notifire.getbgcolor,
          actioniconcolor: notifire.getwhiteblackcolor,
          leadingiconcolor: notifire.getwhiteblackcolor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Crear nueva contraseña",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Gilroy Bold",
                color: notifire.getwhiteblackcolor,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.016),
            // Text(
            //   "Enter the phone number, we’ll send the code",
            //   style: TextStyle(
            //     fontSize: 14,
            //     color: notifire.getgreycolor,
            //   ),
            // ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                "Contraseña",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Gilroy Medium",
                  color: notifire.getwhiteblackcolor,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
            Container(
                    height: 55.0,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: notifire.getdarkmodecolor),
                    child: TextField(
                       controller: passwordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: "Ingrese su contraseña",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: TextStyle(
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium"),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: obscureText
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
               
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                "Confirmación de contraseña",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Gilroy Medium",
                  color: notifire.getwhiteblackcolor,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
              Container(
                    height: 55.0,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: notifire.getdarkmodecolor),
                    child: TextField(
                       controller: passwordConfirmController,
                      obscureText: obscureTextConfirm,
                      decoration: InputDecoration(
                        hintText: "Ingrese su contraseña",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: TextStyle(
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium"),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureTextConfirm = !obscureTextConfirm;
                                });
                              },
                              icon: obscureTextConfirm
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
               
           // SizedBox(height: MediaQuery.of(context).size.height / 3),
            Spacer(),
            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if(state is UserPasswordUpdateError){
                  ScaffoldMessenger
                  .of(context)
                  .showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor:Theme.of(context).colorScheme.error ,));
                }
                if(state is UserPasswordUpdateSuccess){
                  bottomSheet();
                }
              },
              builder: (context, state) {
                if(state is UserPasswordUpdateLoading){
                  return Center(child:CircularProgressIndicator());
                }
                return     AppButton(
              context: context,
              buttontext: "Guardar contraseña",
              onclick: (){
                if(passwordController.text == passwordConfirmController.text){
                  context
                  .read<UserBloc>()
                  .add(UserPasswordUpdateEvent(passwordController.text));
                }else{
                  ScaffoldMessenger
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('Las contraseñas deben coincidir'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                  ));
                }
              },
            );
              },
            ),
        
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  bottomSheet() {
    return showModalBottomSheet(
 
      context: context,
      isDismissible: false,
      backgroundColor: notifire.getbgcolor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 600,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 30,
                    child: CircleAvatar(
                      radius: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.asset('assets/images/Illustration.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 55,
                    top: -18,
                    child: Image.asset(
                      'assets/images/Success.png',
                      height: 160,
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.13,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Contraseña Actualizada",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: Text(
                            "Hemos actualizado tu contraseña. Recuerda tu contraseña. ¡Gracias!",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Gilroy Medium",
                              color: notifire.getgreycolor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      context.replace('/login');
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => Settings(),
                      //   ),
                      //);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.45,
                        left: 20,
                        right: 20,
                      ),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Center(
                        child: GestureDetector(
                          child: Text(
                            "Aceptar",
                            style: TextStyle(
                              fontSize: 18,
                              color: WhiteColor,
                              fontFamily: "Gilroy Bold",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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