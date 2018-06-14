import 'package:flutter/material.dart';
import 'package:test_login/data/rest_ds.dart';
import 'package:test_login/models/user.dart';
import 'package:test_login/utils/singleton.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class MyForm extends StatefulWidget{
  @override
  MyFormState createState(){
    return new MyFormState();
  }
}

// Define a corresponding State class. This class will hold the data related to 
// the form.
class MyFormState extends State<MyForm> {
  RestDatasource _dtSource = new RestDatasource();
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final loginController = new TextEditingController();
  final passwordController = new TextEditingController();
  var loadingLoader;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return new Scaffold(
      body: 
      new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/test.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: new Padding(
          padding: new EdgeInsets.symmetric(vertical:0.0,horizontal: 35.0),
          child: new Form(
            key: _formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextFormField(
                  autocorrect: false,
                  decoration: new InputDecoration(
                    suffixIcon: new Icon(Icons.person),
                    labelText: "Nom d'utilisateur"
                  ),
                  controller: loginController,
                ),
                new TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                    suffixIcon: new Icon(Icons.lock),
                    labelText: "Mot de passe"
                  ),
                  controller: passwordController,
                ),
                new Container(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: new OutlineButton(
                    borderSide: BorderSide(color: Colors.grey,width: 2.0),
                    highlightColor: Colors.green,
                    color: Colors.greenAccent,
                    splashColor: Colors.green,
                    highlightedBorderColor: Colors.green[800],
                    onPressed: (){
                      loadingLoader = new CircularProgressIndicator();
                      if(_formKey.currentState.validate())
                      {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        
                        // _dtSource.login(loginController.text, passwordController.text).then((User user){
                        _dtSource.login("FLOSPA", "FLOSPA").then((User user){  //Pour dev
                          if(user != null)
                          {
                            
                            sleep(const Duration(seconds:2));
                            Singleton _singleton = new Singleton();
                            _singleton.user = user;
                            Navigator.of(context).pushReplacementNamed("/startMenu");
                          }
                          else{
                            loadingLoader = new Text("Identifiants incorrects");
                          }
                        });
                      }
                    },
                    child: new Text('Se connecter'),
                  ),
                ),
                new Container(
                  child: loadingLoader,
                ),
              ],
            )
          ),
        )
         
      )
    );
  }
}