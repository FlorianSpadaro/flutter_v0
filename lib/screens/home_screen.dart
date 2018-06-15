import 'package:flutter/material.dart';
import 'package:test_login/utils/singleton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:test_login/utils/poiId_singleton.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState(){
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{
  static Singleton singleton = new Singleton();
  Future listPoiDate = singleton.getPoiByDate(new DateTime.now());

  void updateDateCalendar(DateTime date){
    setState(() {
          listPoiDate = singleton.getPoiByDate(date);
        });
  }

  final date = new DateTime.now();
  @override
  Widget build(BuildContext context){
    return new DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(icon: new Icon(Icons.location_on), text: "Etat 1",),
                new Tab(icon: new Icon(Icons.location_on), text: "Etat 5",),
                new Tab(icon: new Icon(Icons.assignment_late)),
                new Tab(icon: new Icon(Icons.calendar_today)),
              ],
            ),
            title: new Text('Tabs Demo'),
          ),
          body: new TabBarView(
            children: [
              new FutureBuilder(
                future: singleton.getPoiState1(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data != null)
                  {
                    if(snapshot.data.length > 0)
                    {
                    List<Widget> textlist = [];
                    for (var item in snapshot.data) {
                      String commune = item["ft_libelle_commune"] == null ? '' : item["ft_libelle_commune"];
                      String voie = item["ft_libelle_de_voie"] == null ? '' : item["ft_libelle_de_voie"];
                      String numVoie = item["ft_numero_de_voie"] == null ? '' : item["ft_numero_de_voie"];
                      String adresse = numVoie + " " + voie + ", " + commune + ", FRANCE";
                      textlist.add(new Card(
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new ListTile(
                                  onTap: () {
                                    PoiId_singleton poiSingleton = new PoiId_singleton();
                                    poiSingleton.id = item["id"];
                                    poiSingleton.oeie = item["ft_numero_oeie"];
                                    Navigator.of(context).pushNamed("/detailsPoi");
                                  },
                                  leading: const Icon(Icons.fiber_new,
                                  color: Colors.green,),
                                  title: new Text(item["ft_numero_oeie"]),
                                  trailing: new Text(item["domaine"]),
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
                                      ).then((DateTime value){
                                        singleton.addPlanifDateByPoiId(item["id"], value);
                                      });},
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
                    return new ListView(
                      children: textlist,
                    );
                    }
                    else{
                      return new Text("Aucune POI à l'état 5");
                    }
                  }
                  else if(snapshot.hasError){
                    return new Text("ERREUR");
                  }
                  return new Center(
                  child: new RefreshProgressIndicator(),
                );
                },
              ),

              new FutureBuilder(
                future: singleton.getPoiState5(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data != null)
                  {
                    if(snapshot.data.length > 0)
                    {
                    List<Widget> textlist = [];
                    for (var item in snapshot.data) {
                      String commune = item["ft_libelle_commune"] == null ? '' : item["ft_libelle_commune"];
                      String voie = item["ft_libelle_de_voie"] == null ? '' : item["ft_libelle_de_voie"];
                      String numVoie = item["ft_numero_de_voie"] == null ? '' : item["ft_numero_de_voie"];
                      String adresse = numVoie + " " + voie + ", " + commune + ", FRANCE";
                      textlist.add(new Card(
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new ListTile(
                                  onTap: () {
                                    PoiId_singleton poiSingleton = new PoiId_singleton();
                                    poiSingleton.id = item["id"];
                                    poiSingleton.oeie = item["ft_numero_oeie"];
                                    Navigator.of(context).pushNamed("/detailsPoi");
                                  },
                                  leading: const Icon(Icons.fiber_new,
                                  color: Colors.green,),
                                  title: new Text(item["ft_numero_oeie"]),
                                  trailing: new Text(item["domaine"]),
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
                                      ).then((DateTime value){singleton.addPlanifDateByPoiId(item["id"], value);});},
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
                    return new ListView(
                      children: textlist,
                    );
                    }
                    else{
                      return new Text("Aucune POI à l'état 5");
                    }
                  }
                  else if(snapshot.hasError){
                    return new Text("ERREUR");
                  }
                  return new Center(
                  child: new RefreshProgressIndicator(),
                );
                },
              ),

              new FutureBuilder(
                future: singleton.getPoiRetard(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.data != null)
                  {
                    if(snapshot.data.length > 0)
                    {
                    List<Widget> textlist = [];
                    for (var item in snapshot.data) {
                      String commune = item["ft_libelle_commune"] == null ? '' : item["ft_libelle_commune"];
                      String voie = item["ft_libelle_de_voie"] == null ? '' : item["ft_libelle_de_voie"];
                      String numVoie = item["ft_numero_de_voie"] == null ? '' : item["ft_numero_de_voie"];
                      String adresse = numVoie + " " + voie + ", " + commune + ", FRANCE";
                      textlist.add(new Card(
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new ListTile(
                                  onTap: () {
                                    PoiId_singleton poiSingleton = new PoiId_singleton();
                                    poiSingleton.id = item["id"];
                                    poiSingleton.oeie = item["ft_numero_oeie"];
                                    Navigator.of(context).pushNamed("/detailsPoi");
                                  },
                                  leading: const Icon(Icons.fiber_new,
                                  color: Colors.green,),
                                  title: new Text(item["ft_numero_oeie"]),
                                  trailing: new Text(item["domaine"]),
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
                                      ).then((DateTime value){singleton.addPlanifDateByPoiId(item["id"], value);});},
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
                    return new ListView(
                      children: textlist,
                    );
                    }
                    else{
                      return new Text("Aucune POI en retard");
                    }
                  }
                  else if(snapshot.hasError){
                    return new Text("ERREUR");
                  }
                  return new Center(
                  child: new RefreshProgressIndicator(),
                );
                },
              ),
              new Column(
                children: <Widget>[
                  new Calendar(
                    isExpandable: true,
                    showCalendarPickerIcon: false,
                    onDateSelected: (day){updateDateCalendar(date);},
                  ),
                  new Expanded(
                    child: new FutureBuilder(
                    future: listPoiDate,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.data != null)
                      {
                        if(snapshot.data.length > 0)
                        {
                          List<Widget> textlist = [];
                          for (var item in snapshot.data) {
                            String commune = item["ft_libelle_commune"] == null ? '' : item["ft_libelle_commune"];
                            String voie = item["ft_libelle_de_voie"] == null ? '' : item["ft_libelle_de_voie"];
                            String numVoie = item["ft_numero_de_voie"] == null ? '' : item["ft_numero_de_voie"];
                            String adresse = numVoie + " " + voie + ", " + commune + ", FRANCE";
                            textlist.add(new Card(
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new ListTile(
                                        onTap: () {
                                          PoiId_singleton poiSingleton = new PoiId_singleton();
                                          poiSingleton.id = item["id"];
                                          poiSingleton.oeie = item["ft_numero_oeie"];
                                          Navigator.of(context).pushNamed("/detailsPoi");
                                        },
                                        leading: const Icon(Icons.fiber_new,
                                        color: Colors.green,),
                                        title: new Text(item["ft_numero_oeie"]),
                                        trailing: new Text(item["domaine"]),
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
                                            ).then((DateTime value){singleton.addPlanifDateByPoiId(item["id"], value);});},
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
                          return new ListView(
                            children: textlist,
                          );
                        }
                        else{
                          return new Text("Aucune POI prévue à cette date");
                        }
                      }
                      else if(snapshot.hasError){
                        return new Text("ERREUR");
                      }
                      return new Center(
                      child: new RefreshProgressIndicator(),
                    );
                    },
                  ),
                  )
                  
                ],
              )
            ],
          ),
        ),
      );
  }
}

_launchURL(String adresse) async {
  String url = 'https://www.waze.com/ul?q={$adresse}&navigate=yes';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}