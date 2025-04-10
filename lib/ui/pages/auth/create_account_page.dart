import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/models/user/user_request_model.dart';
import 'package:tomatebnb/models/user/user_request_modelp.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool isvisibal = false;
  bool obscureText = true;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  final lastnameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late ColorNotifire notifire;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenido a SAMAY",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Gilroy Bold",
                        color: notifire.getwhiteblackcolor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Vamos, crea tu cuenta primero",
                      style: TextStyle(
                          fontSize: 14,
                          color: notifire.getgreycolor,
                          fontFamily: "Gilroy Medium")),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text("Nombre",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy Medium",
                          color: notifire.getwhiteblackcolor)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  textfield(
                      controller: nameController,
                      feildcolor: notifire.getdarkmodecolor,
                      hintcolor: notifire.getgreycolor,
                      text: 'Ingrese su nombre',
                      prefix: Image.asset(
                        "assets/images/profile.png",
                        height: 25,
                        color: notifire.getgreycolor,
                      ),
                      suffix: null),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text("Apellidos",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy Medium",
                          color: notifire.getwhiteblackcolor)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  textfield(
                      controller: lastnameController,
                      feildcolor: notifire.getdarkmodecolor,
                      hintcolor: notifire.getgreycolor,
                      text: 'Ingrese sus apellidos',
                      prefix: Image.asset(
                        "assets/images/profile.png",
                        height: 25,
                        color: notifire.getgreycolor,
                      ),
                      suffix: null),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    "Email",
                    style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        fontSize: 16,
                        color: notifire.getwhiteblackcolor),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  textfield(
                      controller: emailController,
                      feildcolor: notifire.getdarkmodecolor,
                      hintcolor: notifire.getgreycolor,
                      text: 'Ingrese su correo electrónico',
                      prefix: Image.asset(
                        "assets/images/call.png",
                        height: 25,
                        color: notifire.getgreycolor,
                      ),
                      suffix: null),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text("Contraseña",
                      style: TextStyle(
                          fontFamily: "Gilroy Medium",
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthCreateSuccess) {
                          bottomsheet(state.responseAuth.email ??
                              'Correo no disponible');
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Usuario Registrado'))
                          // );
                          // context.replace('/login');
                        }
                        if (state is AuthCreateError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ));
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthCreateLoading) {
                          return CircularProgressIndicator();
                        }
                        return AppButton(
                          context: context,
                          onclick: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const verifyaccount()));
                            context.read<AuthBloc>().add(AuthCreateEvent(
                                UserRequestModelp(
                                    name: nameController.text,
                                    lastname: lastnameController.text,
                                    email: emailController.text,
                                    password: passwordController.text)));
                          },
                          buttontext: "Guardar",
                        );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿Tiene una cuenta?",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Gilroy Medium",
                                color: notifire.getwhiteblackcolor)),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => const loginscreen(),),);
                            context.replace('/login');
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 15,
                                color: Darkblue,
                                fontFamily: "Gilroy Medium"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
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

  bottomsheet(String email) {
    return showModalBottomSheet(
        isDismissible: false,
        context: context,
        backgroundColor: notifire.getbgcolor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
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
                      bottom: MediaQuery.of(context).size.height * 0.16,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Cuenta creada",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Gilroy Bold",
                                  color: notifire.getwhiteblackcolor),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              "Felicidades! Su cuenta ha sido creada.",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Gilroy Medium",
                                  color: notifire.getgreycolor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Text(
                              "Le enviaremos un correo de verificación a $email",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Gilroy Medium",
                                  color: notifire.getgreycolor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if(state is VerificationCodeCreateError){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ));
                        }
                        if(state is VerificationCodeCreateSuccess){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Código de verificación enviado"),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ));
                          
                        }
                      },
                      builder: (context, state) {
                        if (state is VerificationCodeCreateLoading) {
                          return CircularProgressIndicator();
                        }else{
                        return InkWell(
                          onTap: () {
                            context.read<AuthBloc>()
                            .add(VerificationCodeCreateEvent(email));  
                            Navigator.pop(context);
                            context.replace('/verificate_email', extra: email);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.425,
                                left: 20,
                                right: 20),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                                child: GestureDetector(
                                    child: Text("Enviar codigo de verificación",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: WhiteColor,
                                            fontFamily: "Gilroy Bold")))),
                          ),
                        );
                        }  
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    context.replace('/login');
                  },
                  child: Text(
                    "Iniciar sesión",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Gilroy Medium",
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            ),
          );
        });
  }
}
