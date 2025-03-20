import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tomatebnb/models/accommodation/accommodation_rule_response_model.dart';
// import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
// import 'package:tomatebnb/utils/customwidget.dart';

class ItemListRuleAnuncio extends StatelessWidget {
  final AccommodationRuleResponseModel rule;
  
  const ItemListRuleAnuncio({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(rule.title??"",),
          ],
        ),
        ReadMoreText(
                    rule.description??"",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: "Gilroy Medium"),
                    trimCollapsedText: 'Mas',
                    trimExpandedText: 'Menos',
                    lessStyle:
                    TextStyle(color: Colors.blue[900]),
                                      moreStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[900]),
                                    
          
                
        ),
        SizedBox(height: 12.0,)
      ],
    ); 
    
  }
}
