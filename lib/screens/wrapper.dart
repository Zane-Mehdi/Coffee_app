import 'package:firebasetut/models/user.dart';
import 'package:firebasetut/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Usern?>(context);
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
