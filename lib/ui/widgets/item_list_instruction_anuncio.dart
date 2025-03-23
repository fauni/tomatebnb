import 'package:flutter/material.dart';
import 'package:tomatebnb/models/accommodation/accommodation_instruction_response_model.dart';


class ItemListInstructionAnuncio extends StatelessWidget {
  final AccommodationInstructionResponseModel rule;
  
  const ItemListInstructionAnuncio({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(rule.title??"", style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontFamily: "Gilroy Medium"
      ),),
      subtitle: Text(rule.description??"" , style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontFamily: "Gilroy Medium"
      ),),
    ); 
  }
}
