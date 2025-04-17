import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String mensaje;
  final IconData icono;
  final Function() onPush;

  const EmptyListWidget({
    super.key,
    required this.icono,
    required this.mensaje,
    required this.onPush
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Image.asset('assets/images/no-results.png', height: 80,),
          ),
          Text(mensaje, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              foregroundColor: Theme.of(context).colorScheme.primary,
              minimumSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            onPressed: onPush, 
            icon: const Icon(Icons.refresh), 
            label: const Text('Explorar Anuncios')
          )
        ],
      ),
    );
  }
}