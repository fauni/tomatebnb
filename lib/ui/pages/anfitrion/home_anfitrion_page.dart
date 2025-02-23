import 'package:flutter/material.dart';

class HomeAnfitrionPage extends StatelessWidget {
  const HomeAnfitrionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Inicio",
                  style: TextStyle(
                      fontSize: 18,
                      // color: notifire.getwhiteblackcolor,
                      fontFamily: "Gilroy bold"),
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey[300],
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/images/notification.png",
                      height: 25,
                      // color: notifire.getwhiteblackcolor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      '¡Franz Ronald, te damos la bienvenida!',
                      style: TextStyle(fontFamily: "Gilroy bold", fontSize: 30),
                    ),
                    Text(
                      'Los huéspedes pueden reservar tu alojamiento 24 horas después de que publiques tu anuncio. Te explicamos como prepararlo',
                      style: TextStyle(fontFamily: "Gilroy light", fontSize: 15),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     Text('¡Franz Ronald, te damos la bienvenida!'),
      //     Text('Los huéspedes pueden reservar tu alojamiento 24 horas después de que publiques tu anuncio. Te explicamos como prepararlo')
      //   ],
      // ),
    );
  }
}
