import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Set<Marker> _markers = {};
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _searchPharmacies(const LatLng(37.323489, 127.125440)); // 초기 위치에 대한 약국 검색
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) async {
    await _searchPharmacies(position.target); // 카메라 이동 시 약국 검색
  }

  Future<void> _searchPharmacies(LatLng position) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=약국&location=${position.latitude},${position.longitude}&radius=1500&key=AIzaSyD02hCqsu2Yvux2CWAIkBZE_dmEQzzJ0L0'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _setMarkers(data['results']);
    } else {
      throw Exception('Failed to load pharmacies');
    }
  }

// 약국 마커표시하고 누르면 약국 이름보여줌
  void _setMarkers(List<dynamic> places) {
    final Set<Marker> localMarkers = {};
    for (var place in places) {
      localMarkers.add(Marker(
        markerId: MarkerId(place['place_id']),
        position: LatLng(place['geometry']['location']['lat'],
            place['geometry']['location']['lng']),
        infoWindow: InfoWindow(title: place['name']),
      ));
    }

    setState(() {
      _markers = localMarkers;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameraMove,
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.323489, 127.125440),
        zoom: 15,
      ),
      markers: _markers,
    );
  }
}
