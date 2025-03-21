import 'package:flutter/material.dart';

class FiltersExploreWidget extends StatefulWidget {
  FiltersExploreWidget({super.key, required this.categories, required this.selectedIndex});

  List<Map<String, dynamic>> categories;
  int selectedIndex;

  @override
  State<FiltersExploreWidget> createState() => _FiltersExploreWidgetState();
}

class _FiltersExploreWidgetState extends State<FiltersExploreWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 15,
                  );
                },
                itemBuilder: (context, index) {
                  final category = widget.categories[index];
                  final isSelected = widget.selectedIndex == index;
                  final color = isSelected ? Colors.black : Colors.grey;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        widget.selectedIndex = index;
                      });
                      // Aqui permite navegar a otra pantalla o actualizar contenido
                    },
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category['icon'],
                              color: isSelected
                                  ? Colors.black
                                  : Theme.of(context).colorScheme.primary),
                          Text(
                            category['title'],
                            style: TextStyle(
                                fontFamily: "Gilroy Thin", fontSize: 12),
                          ),
                          // Barra negra debajo del ítem seleccionado
                          if (isSelected)
                            Container(
                              height: 2,
                              width: 40,
                              color: Colors.black,
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}