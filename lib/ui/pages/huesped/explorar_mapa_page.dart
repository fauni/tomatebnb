import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/filters_explore_widget.dart';
import 'package:tomatebnb/ui/widgets/search_home_widget.dart';

import 'dart:ui' as ui;

import '../../../bloc/export_blocs.dart';

class ExplorarMapaPage extends StatefulWidget {
  const ExplorarMapaPage({super.key});

  @override
  State<ExplorarMapaPage> createState() => _ExplorarMapaPageState();
}

class _ExplorarMapaPageState extends State<ExplorarMapaPage> {
  bool _showFloatingContainer = false;
  AccommodationResponseCompleteModel? _selectedAccommodation;

  // Completer para el controlador del mapa
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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

  List<AccommodationResponseCompleteModel> accommodations = [];
  Set<Marker> markers = {}; // Inicializa markers como un conjunto vacío
  @override
  void initState() {
    super.initState();
    getLocation();
    getAccommodationNearby();
  }

  // Obtener ubicación actual
  void getLocation() {
    context.read<LocationBloc>().add(LoadLocation());
  }

  // Obtener alojamientos cercanos
  void getAccommodationNearby() {
    context.read<ExploreAccommodationBloc>().add(NearbyAccommodationGetEvent());
  }

  void getAccommodationById(int id) {
    context
        .read<ExploreAccommodationDetailBloc>()
        .add(GetAccommodationByIdEvent(id));
  }

  Future<Uint8List> createCustomMarker(String price) async {
    const double markerWidth = 120; // Ancho del rectángulo
    const double markerHeight = 60; // Altura del rectángulo
    const double borderRadius = 20; // Radio de los bordes

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint paint = Paint()..color = Colors.white; // Fondo blanco
    final Paint borderPaint = Paint()
      ..color = Colors.black // Borde negro
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, markerWidth, markerHeight),
      Radius.circular(borderRadius),
    );

    // Dibuja el fondo
    canvas.drawRRect(rrect, paint);
    // Dibuja el borde
    canvas.drawRRect(rrect, borderPaint);

    // Configurar el texto
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '\$$price',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(minWidth: 0, maxWidth: markerWidth);

    // Pintar el texto centrado
    textPainter.paint(
      canvas,
      Offset((markerWidth - textPainter.width) / 2,
          (markerHeight - textPainter.height) / 2),
    );

    // Convertir el canvas en imagen
    final img = await pictureRecorder
        .endRecording()
        .toImage(markerWidth.toInt(), markerHeight.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  // Actualizar los marcadores
  void updateMarkers(
      List<AccommodationResponseCompleteModel> accommodations) async {
    markers.clear();

    List<Future<Marker>> markerFutures = accommodations.map((anuncio) async {
      LatLng location = LatLng(anuncio.latitude!, anuncio.longitude!);

      Uint8List markerIconBytes =
          await createCustomMarker(anuncio.priceNight.toString());
      BitmapDescriptor icon = BitmapDescriptor.fromBytes(markerIconBytes);

      return Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        icon: icon,
        onTap: () {
          // print(anuncio.id);
          getAccommodationById(anuncio.id!);
        },
        // infoWindow: InfoWindow(
        //   title: anuncio.title,
        //   snippet: 'Precio: \$${anuncio.priceNight}',
        // ),
      );
    }).toList();

    List<Marker> newMarkers = await Future.wait(markerFutures);

    setState(() {
      markers.addAll(newMarkers);
    });
  }

  @override
  Widget build(BuildContext context) {

    String imgsUrl = Environment.UrlImg;
    List<String> imageUrls = [
      '$imgsUrl/accommodations/202503111741731635.jpg',
      '$imgsUrl/accommodations/202503121741738252.jpg',
      '$imgsUrl/accommodations/202503121741743684.jpg'
      // 'assets/images/BangkokHotel.jpg',
      // 'assets/images/BoutiqueHotel.jpg',
      // 'assets/images/AnticipatedHotel.jpg',
    ];

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SearchHomeWidget(),
                  FiltersExploreWidget(
                      categories: _categories, selectedIndex: _selectedIndex),
                ],
              ),
            ),
            Expanded(
              child: BlocListener<ExploreAccommodationBloc,
                  ExploreAccommodationState>(
                listener: (context, state) {
                  if (state is GetAccommodationNearbySuccess) {
                    accommodations = state.accommodations;
                    updateMarkers(
                        accommodations); // Actualiza los markers en el mapa
                  }
                },
                child: BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state.status == LocationStatus.loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status == LocationStatus.loaded &&
                        state.position != null) {
                      LatLng currentLocation = LatLng(
                          state.position!.latitude, state.position!.longitude);
                      return GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: currentLocation,
                          zoom: 14,
                        ),
                        markers: markers, // Agregar los markers al mapa
                      );
                    } else if (state.status == LocationStatus.error) {
                      // return Center(child: Text('Error: ${state.errorMessage}'),);
                      LatLng currentLocation = LatLng(-17.009547, -64.832168);
                      return GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: currentLocation,
                          zoom: 7,
                        ),
                        markers: markers, // Agregar los markers al mapa
                      );
                    } else {
                      return Center(
                        child: Text('Cargando ubicación...'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        BlocConsumer<ExploreAccommodationDetailBloc, ExploreAccommodationDetailState>(
          listener: (context, state) {
            if(state is GetAccommodationDetailSuccess){
              _showFloatingContainer = true;
            } else {
              _showFloatingContainer = false;
            }
            setState(() {
                
              });
          },
          builder: (context, state) {
            if(state is GetAccommodationDetailLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is GetAccommodationDetailSuccess){
              _selectedAccommodation = state.accommodation;
              return Visibility(
                visible: _showFloatingContainer,
                child: Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(20)),
                              child: SizedBox(
                                height: 200,
                                child: PageView.builder(
                                  itemCount: state.accommodation.photos!.length,
                                  itemBuilder: (context, index) {
                                    final photo = '$imgsUrl/accommodations/${state.accommodation.photos![index].photoUrl}';
                                    return Image.network(
                                      photo,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Center(
                                            child:
                                                Text('Error al cargar la imagen'));
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => context.push('/detail_ads',extra: state.accommodation.id),
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      state.accommodation.title!,
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Precio: ${state.accommodation.priceNight} Bs. noche',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Row(
                            children: [
                              IconButton.filled(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border),
                                style: FilledButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black),
                              ),
                              IconButton.filled(
                                onPressed: () {
                                  setState(() {
                                    _showFloatingContainer = false;
                                  });
                                },
                                icon: Icon(Icons.close),
                                style: FilledButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else  if(state is GetAccommodationDetailError){
              return SizedBox();
            } else {
              return SizedBox();
            }
            
          },
        )
      ],
    ));
  }
}
