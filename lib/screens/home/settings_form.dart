import 'package:firebasetut/models/user.dart';
import 'package:firebasetut/services/database.dart';
import 'package:firebasetut/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebasetut/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {


  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  late String? _currentName=null;
  late String? _currentSugars= null;
  late int? _currentStrength=100;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usern?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Update your brew settings",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration,
                    validator: (val) =>
                    val!.isEmpty
                        ? 'Please enter a name'
                        : null,
                    onChanged: (val) => setState(() => _currentName = val),
                    initialValue: userData?.name,
                  ),
                  SizedBox(height: 20,),
                  DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars == '' ? userData?.sugars : userData?.sugars,
                      onChanged: (value) {
                        setState(() => _currentSugars = value.toString());
                      },
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar,
                            child: Text("$sugar sugars"));
                      }).toList()),
                  Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                    value: (_currentStrength ?? userData!.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          await DatabaseService(uid: user?.uid).updateUserData(
                              _currentSugars ?? userData!.sugars,
                              _currentName ?? userData!.name,
                              _currentStrength ?? userData!.strength);
                          Navigator.pop(context);
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.pink[400],
                          primary: Colors.white
                      ),
                      child: Text(
                        "Update",
                      ))
                ],
              ));
        } else {
          return Loading();
        }
      }
    );
  }
}
