import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;
  final String image;
  final String? textButton;
  final IconData? iconButton;
  final Function() onPush;
  const EmptyDataWidget({
    super.key, 
    required this.message, 
    required this.image,
    this.textButton = 'Explorar Anuncios', 
    this.iconButton = Icons.search,     
    required this.onPush
  });

  @override
  Widget build(BuildContext context) {
    final styleContext = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Center(
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Image.asset(image),
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  fontFamily: "Gilroy Light",
                  color: Theme.of(context).colorScheme.primary
                ),
                // style: // Theme.of(context).textTheme.tit?.copyWith(color: styleContext.colorScheme.primary),
              ),
              SizedBox(height: 30,),
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
                icon: Icon(iconButton), 
                label: Text(textButton!)
              )
            ],
          ),
        ),
      ),
    );
  }
}