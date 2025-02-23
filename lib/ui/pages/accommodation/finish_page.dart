import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/utils/customwidget.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({super.key});

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {

  @override
  void initState() {
    super.initState();
    
  }
  late int _accommodationId;
  @override
  Widget build(BuildContext context) {
    _accommodationId = GoRouterState.of(context).extra! as int;
    return Scaffold(body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.5,
            child: Column(
              children: [
                 SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.02), //upar thi jagiya mukeli che
                // ignore: sized_box_for_whitespace
            
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Text(
                    '¡Felicidades!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Gilroy Bold",
                        color: Theme.of(context).colorScheme.tertiary), //heding Text
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Text(
                     'Tu anuncio se creó con éxito',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Gilroy Bold",
                        color: Theme.of(context).colorScheme.primary ), //heding Text
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Center(child: AppButton(
                  buttontext: 'Pagina Principal',
                  onclick: (){
                    // context.go('/home');
                    context.pushReplacement('/menu-anfitrion');
                  },
                  context: context
                )),
              ],
            ),
          ),
        )
        ),
      );
  }
}