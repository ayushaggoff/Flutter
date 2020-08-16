import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage1 extends StatelessWidget {

final String title='Map';
Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(28.5994907, 77.3315516);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
 
  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(45.531563, -122.677433),
    tilt: 59.440,
    zoom: 11.0,
  );
 
  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }
 
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
 
  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
 
  _onMapTypeButtonPressed() {
    
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    
  }
 
  _onAddMarkerButtonPressed() {
    
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'This is a Title',
            snippet: 'This is a snippet',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    
  }
 
  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
           child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
                mapType: _currentMapType,
              //   markers: _markers,
              //   onCameraMove: _onCameraMove,
           // ),
              // Padding(
              //   padding: EdgeInsets.all(16.0),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: Column(
              //       children: <Widget>[
              //         button(_onMapTypeButtonPressed, Icons.map),
              //         SizedBox(
              //           height: 16.0,
              //         ),
              //         button(_onAddMarkerButtonPressed, Icons.add_location),
              //         SizedBox(
              //           height: 16.0,
              //         ),
              //         button(_goToPosition1, Icons.location_searching),
              //       ],
              //     ),
              //   ),
              ),
            ],
          ),
        ),

          );
  }
}