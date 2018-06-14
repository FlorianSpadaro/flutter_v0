class User{
  int _id;
  int _employeeId;
  String _nom;
  String _prenom;
  String _email;
  User(this._id, this._nom, this._prenom, this._email);

  User.map(dynamic obj){
    this._id = obj["id"];
    this._employeeId = obj["employee_id"];
    this._nom = obj["nom"];
    this._prenom = obj["prenom"];
    this._email = obj["email"];
  }

  int get id => _id;
  int get employeeId => _employeeId;
  String get nom => _nom;
  String get prenom => _prenom;
  String get email => _email;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["employee_id"] = _employeeId;
    map["nom"] = _nom;
    map["prenom"] = _prenom;
    map["email"] = _email;

    return map;
  }

}