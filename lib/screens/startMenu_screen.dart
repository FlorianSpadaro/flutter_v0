import 'package:flutter/material.dart';

class StartMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text("Ambition Télécom & Réseaux"),),
      body: new Column(
        
        children: <Widget>[
        new ListTile(
        onTap: () {
          Navigator.of(context).pushNamed("/home");
        },
        leading: const Icon(Icons.location_on),
        title: new Text("Mes affaires"),
        subtitle: new Text("Liste des affaires en cours"),
      ),
      new Divider(color: Colors.grey,),
      new ListTile(
        onTap: () {
          Navigator.of(context).pushNamed("/kpi");
        },
        // enabled: false,
        leading: const Icon(Icons.trending_up,),
        title: new Text("Mes résultats"),
        subtitle: new Text("Indicateurs de production"),
      ),
      new Divider(color: Colors.grey,),
      new ListTile(
        // enabled: false,
        leading: const Icon(Icons.gps_fixed),
        title: new Text("Poi Proxi"),
        subtitle: new Text("Recherche de POI à proximité"),
        onTap: () {
          Navigator.of(context).pushNamed("/poiProxi");
        },
      ),
      new Divider(color: Colors.grey,),
      new ListTile(
        enabled: false,
        leading: const Icon(Icons.group),
        title: new Text("FAQ"),
        subtitle: new Text("Questions réponses"),
      ),
        ],
      )
    );
  }

}