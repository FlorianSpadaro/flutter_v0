import 'dart:async';
import 'package:test_login/utils/network_util.dart';
import 'package:test_login/models/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();

  static final baseUrl = "http://192.168.30.218/flutter_atr/API";
  static final loginUrl = baseUrl + "/connexion.php";
  static final listePoiUserStateUrl = baseUrl + "/getPoiByCaffByState.php";
  static final poiProxi = baseUrl + "/poiProxi.php";
  static final poiRetard = baseUrl + "/getPoiRetardByCaff.php";
  static final poiById = baseUrl + "/getPoiById.php";
  static final addPlanif = baseUrl + "/addPlanifDateByPoiId.php";

  Future<User> login(String username, String password){
    return _netUtil.post(loginUrl, body: {
      "login": username,
      "mdp": password
    }).then((dynamic res){
      if(res != null)
      {
        print(res.toString());
        return new User.map(res);
      }
      else{
        return null;
      }
    });
  }

  Future listPoiUser(int caffId, int etat){ //correspond à "NOM Prenom"
    return _netUtil.post(listePoiUserStateUrl, body: {
      "caff_id": caffId.toString(),
      "state": etat.toString()
    });
  }

  Future listPoiProxi(double latitude, double longitude, int km) async {
    return _netUtil.post(poiProxi, body: {
      "latitude": longitude.toString(),
      "longitude": latitude.toString(),
      "km": km.toString()
    });
  }

  Future listPoiRetard(int caffId) async
  {
    return _netUtil.post(poiRetard, body: {
      "caff_id": caffId.toString()
    });
  }

  Future getPoiById(int id) async {
    return _netUtil.post(poiById, body: {
      "poi_id":id.toString()
    });
  }

  Future addPlanifDateByPoiId(int poiId, DateTime date) async
  {
    String myDate;
    if(date.toString().length > 0)
    {
      myDate = date.toString().substring(0, 10);
    }
    else{
      myDate = "";
    }
    return _netUtil.post(addPlanif, body:{
      "poi_id": poiId.toString(),
      "date_planif": myDate
    });
  }
}