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
        child: Center(child: AppButton(
          buttontext: 'Publicar',
          onclick: (){
            // context.go('/home');
            context.pushReplacement('/menu-anfitrion');
          },
          context: context
        ))
        ),
      );
  }
}