import 'dart:async';
import 'package:test_login/data/rest_ds.dart';

class PoiId_singleton{
  static final PoiId_singleton _poiId = new PoiId_singleton.internal();

  int id;
  String oeie;

  factory PoiId_singleton(){
    return _poiId;
  }
  PoiId_singleton.internal();

  Future getPoiById()
  {
    RestDatasource restDatasource = new RestDatasource();
    return restDatasource.getPoiById(id);
  }
}