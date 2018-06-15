class Poi{
  int _id;
  String _ftNumeroOeie;
  String _domaine;
  String _commune;
  String _voie;
  String _numVoie;
  String _address;
  double _latitide;
  double _longitude;
  Poi(this._id, this._ftNumeroOeie, this._domaine, this._commune, this._voie, this._numVoie, this._address, this._latitide, this._longitude);

  Poi.map(dynamic obj){
    this._id = obj["id"]== null ? '' : obj["id"];
    this._ftNumeroOeie = obj["ft_numero_oeie"]== null ? '' : obj["ft_numero_oeie"];
    this._domaine = obj["domaine"]== null ? '' : obj["domaine"];
    this._commune = obj["ft_libelle_commune"] == null ? '' : obj["ft_libelle_commune"];
    this._voie = obj["ft_libelle_voie"] == null ? '' : obj["ft_libelle_voie"];
    this._numVoie = obj["ft_numero_de_voie"] == null ? '' : obj["ft_numero_de_voie"];
    this._address = this._numVoie + " " + this._voie + " " + this._commune + ", FRANCE";
    try{
      this._latitide = double.parse(obj["ft_latitude"]);
    }catch(e){
      this._latitide = null;
    }
    try{
      this._longitude = double.parse(obj["ft_longitude"]);
    }catch(e){
      this._longitude = null;
    }
  }

  int get id => _id;
  String get ftNumeroOeie => _ftNumeroOeie;
  String get domaine => _domaine;
  String get commune => _commune;
  String get voie => _voie;
  String get numVoie => _numVoie;
  String get address => _address;
  double get latitude => _latitide;
  double get longitude => _longitude;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["ftNumeroOeie"] = _ftNumeroOeie;
    map["domaine"] = _domaine;
    map["commune"] = _commune;
    map["voie"] = _voie;
    map["numVoie"] = _numVoie;
    map["address"] = _numVoie + " " + _voie + ", " + _commune + ", FRANCE";
    map["latitude"] = _latitide;
    map["longitude"] = _longitude;

    return map;
  }
}