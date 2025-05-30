import 'package:flutter/material.dart';

class SearchHomeWidget extends StatelessWidget {
  // Agregamos evento de entrada
  final void Function() onSearch;

  const SearchHomeWidget({required this.onSearch, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        color: Theme.of(context).colorScheme.onPrimary
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: TextField(
          textAlign: TextAlign.center,
          onTap: onSearch,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'Empieza la búsqueda',
            hintStyle: TextStyle(fontFamily: "Gilroy Medium"),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.asset(
                "assets/images/search.png",
                height: 25,
              ),
            ),
            suffixIcon: Icon(
              Icons.filter_list,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
