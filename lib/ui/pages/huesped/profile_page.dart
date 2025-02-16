import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/utils/customwidget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:AppButton(
        buttontext:"ir a anuncios",
        onclick:(){
          context.push("/ads");
        }
      ) ,);
  }
}