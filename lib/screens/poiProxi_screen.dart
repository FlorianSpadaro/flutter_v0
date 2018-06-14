import 'package:flutter/material.dart';
import 'dart:async';
import 'package:test_login/utils/singleton.dart';

class PoiProxi extends StatefulWidget{
  @override
  PoiProxiState createState(){
    return new PoiProxiState();
  }
}

class PoiProxiState extends State<PoiProxi>{
  Future<Null> _neverSatisfied(oeie,comment) async {
  return showDialog<Null>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return new AlertDialog(

        title: new Text(oeie),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              comment != "" ? new Text(comment):new Text("Pas de ComLab"),
            ],
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
      Singleton singleton = new Singleton();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Poi à moins de 10km"),
        ),
        body: new ListView(
          children: <Widget>[
          new FutureBuilder(
              future: singleton.getListPoiProxi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                List<Widget> textlist = [];
                for (var item in snapshot.data) {
                  textlist.add(new Card(
                   child: new ListTile(
                     leading: new Text(item['algo'] != null ? item['algo'] : "0" + "km"),
                     title: new Text(item['oeie'] != null ? item['oeie'] : ""),
                      subtitle: new Text(item['ft_libelle_commune'] != null ? item['ft_libelle_commune'] : ""),
                      dense: true,
                      trailing: new Text(item['domaine'] != null ? item['domaine'] : ""),
                      onTap:(){_neverSatisfied(item['oeie'],item['ft_commentaire_creation_oeie']);},
                   ),
                 ));
                
                }
                return new Column(
                  children:textlist,
                );
                } else if (snapshot.hasError) {
                  return new Center(
                    child: new Column(
                      children: <Widget>[
                        new Icon(Icons.location_off,size: 100.0,color: Colors.grey[300],),
                        new Text("Pas de position GPS, Activez la position")
                      ],
                    )
                  );
                }
                // By default, show a loading spinner
                return new Column(
                  children: <Widget>[new RefreshProgressIndicator()],
                );
              },
            ),
          ],
        ),
      );
  }
}
