import 'package:test_login/models/poi.dart';

class PoiSingleton{
  static final PoiSingleton _poiSingleton = new PoiSingleton.internal();

  Poi poi;

  factory PoiSingleton(){
    return _poiSingleton;
  }
  PoiSingleton.internal();
}