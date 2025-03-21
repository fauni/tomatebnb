import 'package:flutter/material.dart';

class StaticMapImage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final int zoom;
  final String size;
  final String apiKey;

  StaticMapImage({
    required this.latitude,
    required this.longitude,
    required this.zoom,
    required this.size,
    required this.apiKey,
  });

  @override
  Widget build(BuildContext context) {
    String staticMapUrl = generateStaticMapUrl(
      latitude: latitude,
      longitude: longitude,
      zoom: zoom,
      size: size,
      apiKey: apiKey,
    );

    return Image.network(staticMapUrl);
  }

  String generateStaticMapUrl({
    required double latitude,
    required double longitude,
    required int zoom,
    required String size,
    required String apiKey,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$latitude,$longitude&'
        'zoom=$zoom&'
        'size=$size&'
        'key=$apiKey';
  }
}