import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/item_list_explore.dart';

class ListAnuncioExplore extends StatelessWidget {
  final List<AccommodationResponseCompleteModel> accommodations;
  
  const ListAnuncioExplore({super.key, required this.accommodations});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        AccommodationResponseCompleteModel accommodation = accommodations[index];
        return ItemListExplore( 
          accommodation: accommodation,
          onTap: () => context.push('/detail_ads', extra: accommodation.id),
        );
      },
      separatorBuilder: (context, index) { return Divider(); },
      itemCount: accommodations.length
    );
  }
}