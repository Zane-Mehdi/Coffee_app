import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetut/models/brew.dart';
import 'package:firebasetut/screens/home/settings_form.dart';
import 'package:firebasetut/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebasetut/services/database.dart';
import 'package:firebasetut/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(),
        );
      });
    }


    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: "").brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            TextButton.icon(
                onPressed: () async{
                  await _auth.signOut();
                },
                style: TextButton.styleFrom(
                    primary: Colors.black
                ),
                icon: Icon(Icons.person),
                label: Text("Log Out")),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              style: TextButton.styleFrom(
                  primary: Colors.black
              ),
              icon: Icon(Icons.settings),
              label: Text('settings'),
            )
          ],

        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
          child: BrewList(

          ),
        ),
      ),
    );
  }
}


