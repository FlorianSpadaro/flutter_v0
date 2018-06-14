import 'package:flutter/material.dart';



class KpiMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new Image.network('https://maps.googleapis.com/maps/api/staticmap?center=45.66200389999999%2C5.0807935&zoom=18&size=600x400&markers=color:green%7Clabel:POI%7C45.66200389999999,5.0807935&AIzaSyAmw_61ROpJhvL_aRcLubMO0rlE_TBckLU'),
        ),
      );
  }
}
