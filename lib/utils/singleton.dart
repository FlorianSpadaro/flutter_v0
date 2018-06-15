import 'package:test_login/models/user.dart';
import 'package:test_login/models/poi.dart';
import 'package:test_login/data/rest_ds.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class Singleton{
  static final Singleton _singleton = new Singleton.internal();

  User user;
  List<Poi> listPoi;

  factory Singleton(){
    return _singleton;
  }
  Singleton.internal();

  // void getListPoi(){
  //   RestDatasource restDatasource = new RestDatasource();
  //   restDatasource.listPoiUser(user.id, 5).then((List<Poi> _listPoi){
  //     listPoi = _listPoi;
  //   });
  // }

  Future getListPoiProxi() async {
    var currentLocation = <String, double>{};

    var location = new Location();

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      currentLocation = await location.getLocation;
    } on PlatformException {
      currentLocation = null;
    }
    if(currentLocation != null){
      RestDatasource restDatasource = new RestDatasource();
      return restDatasource.listPoiProxi(currentLocation["latitude"], currentLocation["longitude"], 10);
    }
    else{
      return null;
    }
    // return currentLocation;
    
  }

  Future getPoiState1() async
  {
    RestDatasource restDatasource = new RestDatasource();
    return restDatasource.listPoiUser(user.employeeId, 1);
  }

  Future getPoiState5() async
  {
    RestDatasource restDatasource = new RestDatasource();
    return restDatasource.listPoiUser(user.employeeId, 5);
  }

  Future getPoiRetard() async
  {
    RestDatasource restDatasource = new RestDatasource();
    return restDatasource.listPoiRetard(user.employeeId);
  }

  Future addPlanifDateByPoiId(int poiId, DateTime date) async
  {
    RestDatasource restDatasource = new RestDatasource();
    return restDatasource.addPlanifDateByPoiId(poiId, date);
  }

  Future getPoiByDate(DateTime date) async
  {
    RestDatasource restDatasource = new RestDatasource();
    return restDatasource.getPoiByDateByCaff(date, user.employeeId);
  }
}