import 'package:test_login/models/poi.dart';
import 'package:test_login/data/rest_ds.dart';
import 'dart:async';

class PoiSingleton{
  static final PoiSingleton _poiSingleton = new PoiSingleton.internal();

  Poi poi;

  factory PoiSingleton(){
    return _poiSingleton;
  }
  PoiSingleton.internal();

  Future getPoiProxi() async
  {
    RestDatasource restDatasource = new RestDatasource();
    return restDatasource.listPoiProxi(poi.longitude, poi.latitude, 10);
  }
}