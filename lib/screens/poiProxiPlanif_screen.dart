import 'package:flutter/material.dart';
import 'package:test_login/utils/singleton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test_login/utils/poiId_singleton.dart';
import 'package:test_login/models/poi.dart';
import 'package:test_login/utils/poi_singleton.dart';

class PoiProxiPlanif extends StatefulWidget{
  @override
  PoiProxiPlanifState createState(){
    return new PoiProxiPlanifState();
  }
}

class PoiProxiPlanifState extends State<PoiProxiPlanif>{
  @override
  Widget build(BuildContext context) {
      Singleton singleton = new Singleton();
      PoiId_singleton poiIdSingleton = new PoiId_singleton();
      PoiSingleton poiSingleton = new PoiSingleton();
      final date = new DateTime.now();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Poi à moins de 10km de la POI planifiée"),
        ),
        body: new Column(
          children: <Widget>[
            new FutureBuilder(
              future: poiIdSingleton.getPoiById(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  poiSingleton.poi = Poi.map(snapshot.data);
                  return new FutureBuilder(
              future: poiSingleton.getPoiProxi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data.length > 0)
                  {
                    List<Widget> textlist = [];
                          for (var item in snapshot.data) {
                            String commune = item["ft_libelle_commune"] == null ? '' : item["ft_libelle_commune"];
                            String voie = item["ft_libelle_de_voie"] == null ? '' : item["ft_libelle_de_voie"];
                            String numVoie = item["ft_numero_de_voie"] == null ? '' : item["ft_numero_de_voie"];
                            String adresse = numVoie + " " + voie + ", " + commune + ", FRANCE";
                            String ftNumOeie = item["oeie"] == null ? '' : item["oeie"];
                            String domaine = item["domaine"] == null ? '' : item["domaine"];
                            textlist.add(new Card(
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new ListTile(
                                        onTap: () {
                                          PoiId_singleton poiSingleton = new PoiId_singleton();
                                          poiSingleton.id = item["oeie_id"];
                                          poiSingleton.oeie = item["oeie"];
                                          Navigator.of(context).pushNamed("/detailsPoi");
                                        },
                                        leading: const Icon(Icons.fiber_new,
                                        color: Colors.green,),
                                        title: new Text(ftNumOeie),
                                        trailing: new Text(domaine),
                                        subtitle: new Text(adresse),
                                      ),
                                      new ButtonTheme.bar( // make buttons use the appropriate styles for cards
                                        child: new ButtonBar(
                                          children: <Widget>[
                                            new OutlineButton(
                                              child: const Text('PLANIF.'),
                                              onPressed: (){showDatePicker(
                                              context: context,
                                              initialDate: date,
                                              firstDate: date.subtract(const Duration(days: 1)),
                                              lastDate: date.add(const Duration(days: 3000))
                                            ).then((DateTime value){singleton.addPlanifDateByPoiId(item["oeie_id"], value);});},
                                            ),
                                            new OutlineButton(
                                              child: const Text('ALLER'),
                                              onPressed: (){
                                                _launchURL(adresse);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          
                          }
                          return new Expanded(
                            child: new ListView(
                            children: textlist,
                          ),
                          );
                          
                  }
                  else{
                    return new Text("Aucune POI à moins de 10 km");
                  }
                } else if (snapshot.hasError) {
                  return new Center(
                    child: new Text("Aucune position GPS renseignée pour cette POI")
                  );
                }
                // By default, show a loading spinner
                return new Center(
                  child: new RefreshProgressIndicator(),
                );
              },
            );

                } else if (snapshot.hasError) {
                  return new Center(
                    child: new Text("Erreur")
                  );
                }
                // By default, show a loading spinner
                return new Center(
                  child:new RefreshProgressIndicator(),
                );
              },
            )

          
          ],
        ),
      );
  }

  _launchURL(String adresse) async {
  String url = 'https://www.waze.com/ul?q={$adresse}&navigate=yes';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}
