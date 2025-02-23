import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  // TODO: Quitar este metodo o sutituir por otro
  // void getUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? name = prefs.getString("name");
  //   String? email = prefs.getString("email");
  //   String? token = prefs.getString("token");
  //   print("Name: $name");
  //   print("Email: $email");
  //   print("Token: $token");
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Text('¡Franz Ronald, te damos la bienvenida!'),
          Text('Los huéspedes pueden reservar tu alojamiento 24 horas después de que publiques tu anuncio. Te explicamos como prepararlo')
        ],
      ),
    );
  }
}