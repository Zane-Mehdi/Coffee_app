import 'package:firebasetut/services/auth.dart';
import 'package:firebasetut/services/loading.dart';
import 'package:firebasetut/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Brew Crew'),
        actions: [
          TextButton.icon(
              onPressed: () async{
                widget.toggleView();
              },
              style: TextButton.styleFrom(
                  primary: Colors.black
              ),
              icon: Icon(Icons.person),
              label: Text("Sign In"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                obscureText: true,
                validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long": null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if (_formKey.currentState!.validate()){
                      dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                      if (result == null){
                        setState(() {
                          error = "Please supply a valid email and password";
                          loading = false;
                        });
                      }
                    }else{
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.pink[400]
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white
                    ),)
              ),
              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );;
  }
}
