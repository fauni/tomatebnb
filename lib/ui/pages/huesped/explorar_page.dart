import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/item_list_explore.dart';
import 'package:tomatebnb/ui/widgets/search_home_widget.dart';

class ExplorarPage extends StatefulWidget {
  const ExplorarPage({super.key});

  @override
  State<ExplorarPage> createState() => _ExplorarPageState();
}

class _ExplorarPageState extends State<ExplorarPage> {
  // Índice de la categoría seleccionada
  int _selectedIndex = 0;

  // Datos de las categorías (título e icono)
  final List<Map<String, dynamic>> _categories = [
    {'title': 'Casas rurales', 'icon': Icons.home_filled},
    {'title': 'Icónicos', 'icon': Icons.star},
    {'title': 'Vistas increibles', 'icon': Icons.landscape},
    {'title': 'Islas', 'icon': Icons.beach_access},
    {'title': 'Casas rurales', 'icon': Icons.home},
    {'title': 'Icónicos', 'icon': Icons.star},
    {'title': 'Vistas increíbles', 'icon': Icons.landscape},
    {'title': 'Islas', 'icon': Icons.beach_access},
  ];

  @override
  void initState() {
    super.initState();
    obtenerAnunciosCercanos();
  }

  void obtenerAnunciosCercanos() {
    context.read<ExploreAccommodationBloc>().add(NearbyAccommodationGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          context.push('/explorar_mapa');
        },
        label: Text('Mapa'),
        icon: Icon(Icons.map),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SearchHomeWidget(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 15,
                  );
                },
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedIndex == index;
                  final color = isSelected ? Colors.black : Colors.grey;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
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
          ),
          Expanded(
            child: BlocConsumer<ExploreAccommodationBloc,
                ExploreAccommodationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is GetAccommodationNearbyLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetAccommodationNearbySuccess) {
                  
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        AccommodationResponseCompleteModel accommodation = state.accommodations[index];
                        return ItemListExplore(
                          accommodation: accommodation,
                          onTap: () {
                            context.push('/detail_ads');
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: state.accommodations.length);
                } else if (state is GetAccommodationNearbyError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: Text('Error desconocido'),
                  );
                }
              },
            ),
          )
        ],
      ),
      // body: Column(
      //   children: [
      //     // Menú horizontal
      //     SizedBox(
      //       height: 80, // Altura para íconos, texto y la barra
      //       child: ListView.separated(
      //         scrollDirection: Axis.horizontal,
      //         padding: const EdgeInsets.symmetric(horizontal: 16),
      //         itemCount: _categories.length,
      //         separatorBuilder: (context, index) => SizedBox(width: 24),
      //         itemBuilder: (context, index) {
      //           final category = _categories[index];
      //           final isSelected = _selectedIndex == index;
      //           final color = isSelected ? Colors.black : Colors.grey;

      //           return InkWell(
      //             onTap: () {
      //               setState(() {
      //                 _selectedIndex = index;
      //               });
      //               // Aquí podrías navegar a otra pantalla o actualizar contenido
      //             },
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Icon(
      //                   category['icon'],
      //                   color: color,
      //                 ),
      //                 SizedBox(height: 4),
      //                 Text(
      //                   category['title'],
      //                   style: TextStyle(color: color),
      //                 ),
      //                 SizedBox(height: 4),
      //                 // Barra negra debajo del ítem seleccionado
      //                 if (isSelected)
      //                   Container(
      //                     height: 2,
      //                     width: 20,
      //                     color: Colors.black,
      //                   ),
      //               ],
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //     // Contenido que cambia según la selección
      //     Expanded(
      //       child: Center(
      //         child: Text(
      //           'Contenido: ${_categories[_selectedIndex]['title']}',
      //           style: TextStyle(fontSize: 24),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
