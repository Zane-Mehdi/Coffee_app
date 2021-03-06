import 'package:firebasetut/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>?>(context) ?? [];

    // print(brews?.docs);

    return ListView.builder(
        itemBuilder:(context,index){
          return BrewTile(brew: brews[index]);
        },
        itemCount: brews.length);
  }
}
