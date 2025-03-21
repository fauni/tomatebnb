import 'package:flutter/material.dart';
import 'package:tomatebnb/models/accommodation/accommodation_rule_response_model.dart';

class ItemListRuleAnuncio extends StatelessWidget {
  final AccommodationRuleResponseModel rule;
  
  const ItemListRuleAnuncio({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(rule.title, style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontFamily: "Gilroy Medium"
      ),),
      subtitle: Text(rule.description, style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontFamily: "Gilroy Medium"
      ),),
    ); 
  }
}
