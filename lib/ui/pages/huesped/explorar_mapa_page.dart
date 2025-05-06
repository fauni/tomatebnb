import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_filter_request.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/lista_describes_explore.dart';
import 'package:tomatebnb/ui/widgets/search_home_widget.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';

class ExplorarMapaPage extends StatefulWidget {
  const ExplorarMapaPage({super.key});

  @override
  State<ExplorarMapaPage> createState() => _ExplorarMapaPageState();
}

class _ExplorarMapaPageState extends State<ExplorarMapaPage> {
  late GoogleMapController mapController;
  final String imgsUrl = Environment.UrlImg;
  
  bool _showFloatingContainer = false;
  AccommodationResponseCompleteModel? _selectedAccommodation;
  List<AccommodationResponseCompleteModel> accommodations = [];
  final Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _loadCurrentLocation();
    _loadInitialData();
  }

  void _loadCurrentLocation() {
    context.read<LocationBloc>().add(LoadLocation());
  }

  void _loadInitialData() {
    context.read<ExploreDescribeBloc>().add(GetDescribesForExploreEvent());
    context.read<ExploreAccommodationBloc>().add(NearbyAccommodationGetEvent());
  }

  Future<void> _loadByFilter(AccommodationFilterRequest dataFilter) async {
    context.read<ExploreAccommodationBloc>().add(
      GetAccommodationByFilterEvent(dataFilter)
    );
  }

  void _getAccommodationById(int id) {
    context.read<ExploreAccommodationDetailBloc>().add(
      GetAccommodationByIdEvent(id)
    );
  }

  Future<Uint8List> _createCustomMarker(String price) async {
    const double markerWidth = 120;
    const double markerHeight = 60;
    const double borderRadius = 20;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // Draw background
    final Paint paint = Paint()..color = Colors.white;
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, markerWidth, markerHeight),
      const Radius.circular(borderRadius),
    );

    canvas.drawRRect(rrect, paint);
    canvas.drawRRect(rrect, borderPaint);

    // Draw text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '\$$price',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        (markerWidth - textPainter.width) / 2,
        (markerHeight - textPainter.height) / 2,
      ),
    );

    // Convert to image
    final image = await recorder
        .endRecording()
        .toImage(markerWidth.toInt(), markerHeight.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    return byteData!.buffer.asUint8List();
  }

  Future<void> _updateMarkers(List<AccommodationResponseCompleteModel> accommodations) async {
    markers.clear();

    if(accommodations.isNotEmpty){
      for (final anuncio in accommodations) {
        final location = LatLng(anuncio.latitude!, anuncio.longitude!);
        final markerIcon = await _createCustomMarker(anuncio.priceNight.toString());
        
        markers.add(
          Marker(
            markerId: MarkerId('marker_${anuncio.id}'),
            position: location,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () => _getAccommodationById(anuncio.id!),
          ),
        );
      }
    }

    if (mounted) setState(() {});
  }

  Widget _buildMap(LocationState state) {
    if (state.status == LocationStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final defaultLocation = const LatLng(-17.009547, -64.832168);
    final currentLocation = state.position != null 
      ? LatLng(state.position!.latitude, state.position!.longitude)
      : defaultLocation;

    return GoogleMap(
      onMapCreated: (controller) {
        _controller.complete(controller);
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: currentLocation,
        zoom: state.position != null ? 14 : 7,
      ),
      markers: markers,
    );
  }

  Widget _buildDescribesSection() {
    return BlocConsumer<ExploreDescribeBloc, ExploreDescribeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DescribesForExploreLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DescribesForExploreError) {
          return Center(child: Text(state.message));
        }
        if (state is DescribesForExploreSuccess) {
          return ListaDescribesExplore(
            listaDescribes: state.describes,
            onDescribeSelected: (describe) {
              context.read<ExploreAccommodationBloc>().add(
                GetAccommodationByDescribeEvent(describe.id!)
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildAccommodationDetail(ExploreAccommodationDetailState state) {
    if (state is! GetAccommodationDetailSuccess) return const SizedBox();

    _selectedAccommodation = state.accommodation;
    
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: _showFloatingContainer ? 20 : -300,
      left: 20,
      right: 20,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 10,
        child: Stack(
          children: [
            Column(
              children: [
                _buildImageSlider(state),
                _buildAccommodationInfo(state),
              ],
            ),
            _buildCloseButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider(GetAccommodationDetailSuccess state) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SizedBox(
        height: 200,
        child: PageView.builder(
          itemCount: state.accommodation.photos!.length,
          itemBuilder: (context, index) {
            final photoUrl = '$imgsUrl/accommodations/${state.accommodation.photos![index].photoUrl}';
            return Image.network(
              photoUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                      : null,
                  ),
                );
              },
              errorBuilder: (context, error, stack) => const Center(
                child: Text('Error al cargar la imagen'),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAccommodationInfo(GetAccommodationDetailSuccess state) {
    return InkWell(
      onTap: () => context.push('/detail_ads', extra: state.accommodation.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.accommodation.title!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Precio: ${state.accommodation.priceNight} Bs. por noche',
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      top: 10,
      right: 10,
      child: IconButton.filled(
        onPressed: () => setState(() => _showFloatingContainer = false),
        icon: const Icon(Icons.close),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              SearchHomeWidget(
                onSearch: () async {
                  final result = await context.push<AccommodationFilterRequest>(
                    '/accommodation_filter'
                  );
                  if (result != null) await _loadByFilter(result);
                },
              ),
              _buildDescribesSection(),
              Expanded(
                child: MultiBlocListener(
                listeners: [
                  BlocListener<ExploreAccommodationBloc, ExploreAccommodationState>(
                    listener: (context, state) {
                      if (state is GetAccommodationNearbySuccess) {
                        accommodations = state.accommodations;
                        _updateMarkers(accommodations);
                      } else if (state is GetAccommodationByDescribeSuccess) {
                        accommodations = state.accommodations;
                        _updateMarkers(accommodations);
                      } else if (state is AccommodationFilterSuccess) {
                        accommodations = state.accommodations;
                        _updateMarkers(accommodations);
                      } else if(state is GetAccommodationByDescribeError || state is GetAccommodationNearbyError || state is AccommodationFilterError){
                        accommodations = [];
                        _updateMarkers([]);
                      }
                    },
                  ),
                  BlocListener<ExploreAccommodationDetailBloc, ExploreAccommodationDetailState>(
                    listener: (context, state) {
                      setState(() {
                        _showFloatingContainer = state is GetAccommodationDetailSuccess;
                      });
                    },
                  ),
                ],
                child: BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) => _buildMap(state),
                ),
              ),
              ),
            ],
          ),
          BlocBuilder<ExploreAccommodationDetailBloc, ExploreAccommodationDetailState>(
            builder: (context, state) => _buildAccommodationDetail(state),
          ),
        ],
      ),
    );
  }
}