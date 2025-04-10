import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/auth_bloc/auth_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class VerificateEmailPage extends StatefulWidget {
  const VerificateEmailPage({super.key});

  @override
  State<VerificateEmailPage> createState() => _VerificateEmailPageState();
}

class _VerificateEmailPageState extends State<VerificateEmailPage> {
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    getdarkmodepreviousstate();
    super.initState();
  }

  formatedTime(timeInSecond) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  int _start = 30;
  String? _email;
  void startTimer() {}
  late ColorNotifire notifire;
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _email = GoRouterState.of(context).extra! as String;
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Verifique su cuenta",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Gilroy Bold",
                  color: notifire.getwhiteblackcolor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Hemos enviado un código de verificación a $_email",
                style: TextStyle(
                    fontSize: 14,
                    color: notifire.getgreycolor,
                    fontFamily: "Gilroy Medium")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Text("Verificar su código",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Gilroy Medium",
                    color: notifire.getwhiteblackcolor)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            textfield(
              controller: codeController,
              feildcolor: notifire.getdarkmodecolor,
              hintcolor: notifire.getgreycolor,
              text: 'Codigo de Verificación',
              prefix: Image.asset(
                "assets/images/verification.png",
                height: 25,
                color: notifire.getgreycolor,
              ),
              suffix: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Reeviar en  " + formatedTime(_start).toString(),
                  style: TextStyle(
                      color: notifire.getgreycolor,
                      fontFamily: "Gilroy Medium"),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.15,
            ),
          ]),
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
              listener: (context, state) {
                if (state is VerificateError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ));
                }
                if (state is VerificateSuccess) {
                  if (state.status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Código verificado"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    context.replace("/login");
                    
                  }
                }
              },
              builder: (context, state) {
                if (state is VerificateLoading) {
                  return const CircularProgressIndicator();
                } else {
                    return AppButton(
                    context: context,
                    buttontext: "Verificar cuenta",
                    onclick: () {
                      if (codeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Ingrese el código de verificación"),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        context
                            .read<AuthBloc>()
                            .add(VerificateEvent(codeController.text,_email??""));
                      }
                    },
                  );
                }
               
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.020),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿No recibiste el código? ",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Gilroy Medium",
                        color: notifire.getwhiteblackcolor)),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is VerificationCodeCreateError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ));
                    }
                    if (state is VerificationCodeCreateSuccess) {
                      if (state.status) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Código reenviado"),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is VerificationCodeCreateLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return InkWell(
                        onTap: () {
                          context
                              .read<AuthBloc>()
                              .add(VerificationCodeCreateEvent(_email!));
                        },
                        child: Text(
                          "Reenviar",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Medium",
                          ),
                        ),
                      );
                    }
                  },
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
