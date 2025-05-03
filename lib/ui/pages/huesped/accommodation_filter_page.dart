import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_filter_request.dart';

class AccommodationFilterPage extends StatefulWidget {
  const AccommodationFilterPage({super.key});

  @override
  State<AccommodationFilterPage> createState() => _AccommodationFilterPageState();
}

class _AccommodationFilterPageState extends State<AccommodationFilterPage> {
  AccommodationFilterRequest filter = AccommodationFilterRequest();
  RangeValues _priceRange = const RangeValues(0, 1000);
  int? _selectedTypeId;
  int _rooms = 0;
  int _beds = 0;
  int _bathrooms = 0;
  @override
  void initState() {
    super.initState();

    // Ejecutar el evento de carga una vez que el widget esté montado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccommodationTypeBloc>().add(AccommodationTypeGetEvent());
      context.read<ServiceBloc>().add(ServiceGetEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colorTheme.tertiary.withAlpha(50),
        ),
        padding: EdgeInsets.all(20),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorTheme.primary,
            foregroundColor: colorTheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(double.infinity, 50)
          ),
          onPressed: () {
            context.pop(filter);
          }, 
          icon: Icon(Icons.search, color: colorTheme.onPrimary,),
          label: Text('Buscar')
        ),
      ),
      appBar: AppBar(
        title: Text('Personalizar Busqueda'),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                // filter.reset();
                _selectedTypeId = null;
                _priceRange = const RangeValues(0, 1000);
                _rooms = 0;
                _beds = 0;
                _bathrooms = 0;
              });
            }, 
            icon: const Icon(Icons.clear)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTypeFilter(colorTheme),
              const SizedBox(height: 24),
              Divider(),
              _buildPriceFilter(colorTheme),
              const SizedBox(height: 24),
              Divider(),
              _buildRoomFilters(),
              const SizedBox(height: 24),
              Divider(),
              _buildServiceFilter(colorTheme),
              const SizedBox(height: 24),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildTypeFilter(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tipo de alojamiento', style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        )),
        const SizedBox(height: 8),
        BlocBuilder<AccommodationTypeBloc, AccommodationTypeState>(
          builder: (context, state) {
            if (state is AccommodationTypeGetLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccommodationTypeGetError) {
              return Text(state.message, style: TextStyle(color: Colors.red));
            } else if (state is AccommodationTypeGetSuccess) {
              return Wrap(
                spacing: 8,
                children: state.responseAccommodationTypes.map((type) {
                  return FilterChip(
                    label: Text(type.name ?? ''),
                    selected: _selectedTypeId == type.id,
                    onSelected: (selected) {
                      setState(() {
                        _selectedTypeId = selected ? type.id : null;
                        filter.typeId = _selectedTypeId;
                      });
                    },
                  );
                }).toList(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildPriceFilter(ColorScheme colorTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rango de precios', style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colorTheme.onSurface,
        )),
        const SizedBox(height: 8),
        RangeSlider(
          activeColor: colorTheme.tertiary,
          values: _priceRange,
          min: 0,
          max: 1000,
          divisions: 20, 
          labels: RangeLabels(
            '\$${_priceRange.start.round()}',
            '\$${_priceRange.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
              filter.priceRange1 = values.start.round();
              filter.priceRange2 = values.end.round();
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${_priceRange.start.round()}'),
            Text('\$${_priceRange.end.round()}'),
          ]
        )
      ],
    );
  }

  Widget _buildRoomFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Habitaciones', style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCounter('Dormitorios', _rooms, (value) {
              setState(() {
                _rooms = value;
                filter.rooms = value;
              });
            }),
            _buildCounter('Camas', _beds, (value) {
              setState(() {
                _beds = value;
                filter.beds = value;
              });
            }),
            _buildCounter('Baños', _bathrooms, (value) {
              setState(() {
                _bathrooms = value;
                filter.bathrooms = value;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (value > 0) onChanged(value - 1);
              },
            ),
            Text('$value'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceFilter(ColorScheme colorScheme){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Servicios', style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )),
        const SizedBox(height: 8),
        BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            if(state is ServiceGetLoading){
              return const Center(child: CircularProgressIndicator());
            } else if(state is ServiceGetSuccess){
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.responseServices.map((service) {
                  final isSelected = filter.services?.contains(service.id) ?? false;
                  return FilterChip(
                    label: Text(service.name),
                    
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        filter.services ??= [];
                        if (selected) {
                          filter.services!.add(service.id);
                        } else {
                          filter.services!.remove(service.id);
                        }
                      });
                    },
                  );
                }).toList(),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}