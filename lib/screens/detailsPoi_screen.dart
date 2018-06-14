import 'package:test_login/utils/poiId_singleton.dart';
import 'package:flutter/material.dart';

class DetailsPoiScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    PoiId_singleton poi = new PoiId_singleton();
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text(poi.oeie),),
      body: new Center(
          child: new FutureBuilder(
            future: poi.getPoiById(),
            builder: (context, snapshot){
              if (snapshot.hasData) {
                return new ListView(
                  children: <Widget>[
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          _rowData("N° voie :", snapshot.data['ft_numero_de_voie'].toString(),false),
                          _rowData("Rue :", snapshot.data['ft_libelle_de_voie'].toString(),false),
                          _rowData("Commune :", snapshot.data['ft_libelle_commune'].toString(),false),
                        ],
                      ),
                    ),
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          new Text("ComLab :",style: new TextStyle( fontSize: 16.0, fontWeight: FontWeight.w500),),
                          new Padding(
                            padding: new EdgeInsets.all(10.0),
                            child:  new Text(snapshot.data['ft_commentaire_creation_oeie'],style: new TextStyle( fontSize: 12.0, color: Colors.grey),),
                          )
                         
                        ],
                      ),
                    ),
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          _rowData("Major :", snapshot.data['partner_name'],false),
                          _rowData("Etat POI :", snapshot.data['ft_etat'],false),
                          _rowData("Typologie :", snapshot.data['atr_typologie'],false),
                          _rowData("Domaine :", snapshot.data['domaine'],false),
                          _rowData("PG :", snapshot.data['ft_pg'],false),
                          _rowData("Sous-justification :", snapshot.data['ft_sous_justification_oeie'],false),
                          _rowData("OEIE Triplet :", snapshot.data['agilis_oeie_triplet'],false),
                        ],
                      ),
                    ),
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          _rowData("Date création as :", snapshot.data['ft_date_creation_as'],true),
                          _rowData("Date création oeie :", snapshot.data['ft_date_creation_oeie'],true),
                          _rowData("Date souhaitée par le client :", snapshot.data['ft_oeie_date_souhaitee_client'],true),
                          new Divider(),
                          _rowData("Date de retour étude :", snapshot.data['ft_oeie_dre'],true),
                          _rowData("Date de limite réalisation :", snapshot.data['ft_date_limite_realisation'],true),
                          new Divider(),
                          _rowData("Date demande agrément :", snapshot.data['ft_oeie_date_demande_agrement'],true),
                          _rowData("Date d'agrément", snapshot.data['ft_oeie_date_agrement'],true),
                          _rowData("Date de fin de travaux", snapshot.data['ft_oeie_date_fin_de_travaux'],true),
                        ],
                      ),
                    ),
                  ],
                );
              }else if(snapshot.hasError){
                return new Center(
                  child: new Text("NO DATA"),
                );
              }
              return new Center(
                  child: new RefreshProgressIndicator(),
                );
            },
          )
        ),
    );
  }
}

_rowData(dataName,dataVal,isDate){
if(dataVal == "" || dataVal == null){
  dataVal = "--";
}
if(isDate == true && dataVal != "--" ){
   DateTime parser = DateTime.parse(dataVal);
   dataVal = parser.day.toString() + "/" + parser.month.toString() + "/" + parser.year.toString();
}

  return new Padding(
    padding: new EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(dataName,style: new TextStyle( fontSize: 16.0, fontWeight: FontWeight.w500),),
        new Text(dataVal,style: new TextStyle( fontSize: 14.0, color: Colors.grey),),
      ],
    ),
  );
}

