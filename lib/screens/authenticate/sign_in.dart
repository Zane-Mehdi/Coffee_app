import 'package:firebasetut/services/auth.dart';
import 'package:firebasetut/services/loading.dart';
import 'package:firebasetut/shared/constants.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
        actions: [
          TextButton.icon(
              onPressed: () async{
                widget.toggleView();
              },
              style: TextButton.styleFrom(
                  primary: Colors.black
              ),
              icon: Icon(Icons.app_registration),
              label: Text("Register"))
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
                    if (_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null){
                        setState(() {
                          error = "Invalid Email or Password";
                          loading = false;
                        });
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.pink[400]
                  ),
                  child: Text(
                      "Sign In",
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
    );
  }
}
