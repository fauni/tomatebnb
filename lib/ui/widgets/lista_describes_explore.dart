import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tomatebnb/models/explore/describe.dart';
import 'package:tomatebnb/ui/widgets/skeleton_icon_describe_widget.dart';

class ListaDescribesExplore extends StatefulWidget {
  final List<Describe> listaDescribes;
  final Function(Describe) onDescribeSelected;  
  const ListaDescribesExplore({
    super.key, 
    required this.listaDescribes,
    required this.onDescribeSelected
  });

  @override
  State<ListaDescribesExplore> createState() => _ListaDescribesExploreState();
}

class _ListaDescribesExploreState extends State<ListaDescribesExplore> {
  int _selectedIndex = -1; // Variable para contrlar el item seleccionado

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 70,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.listaDescribes.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 20,
            );
          },
          itemBuilder: (context, index) {
            final describes = widget.listaDescribes[index];
            final isSelected = _selectedIndex == index;

            return InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                // Llamar a la función proporcionada desde el padre
                widget.onDescribeSelected(describes);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.tertiary.withAlpha(50)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInImage.memoryNetwork(
                      placeholder: Uint8List(0),
                      placeholderErrorBuilder: (context, error, stackTrace) => SkeletonIconDescribeWidget(),
                      image: describes.icon!,
                      height: 30,
                      width: 30,
                      color: isSelected
                          ? Colors.black87
                          : Theme.of(context).colorScheme.secondary,
                
                    ),
                    Text(
                      describes.describe!,
                      style: TextStyle(
                          fontFamily: "Gilroy-ThinItalic", fontSize: 10),
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