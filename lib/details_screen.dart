import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/data_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailScreen extends StatefulWidget {
  final Data detail;

  DetailScreen({Key key, this.detail}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(widget.detail.lat, widget.detail.lon),
          infoWindow: InfoWindow(
            title: widget.detail.city,
            snippet: widget.detail.state,
          )
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details of Airport'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Container(
                height: 400,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.detail.lat, widget.detail.lon),
                    zoom: 15,
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  tileColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.detail.name}', style: TextStyle(fontSize: 14, color: Colors.blue),),
                      Text(widget.detail.icao, style: TextStyle(fontSize: 14, color: Colors.blue),),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Center(
                              child: Text('${widget.detail.city}, ',style: TextStyle(fontSize: 14, color: Colors.deepPurpleAccent),),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(widget.detail.state,style: TextStyle(fontSize: 14, color: Colors.deepPurple),),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Center(
                          child: Text(widget.detail.country,style: TextStyle(fontSize: 14, color: Colors.blue),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
