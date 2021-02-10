import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confectstore/ui/tiles/place_tile.dart';
import 'package:flutter/material.dart';

class PlacesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("places").getDocuments(),
      builder: (context, snaphot){
        if(!snaphot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );

        }
        else{
          return ListView(
            children: snaphot.data.documents.map((doc) => PlaceTile(doc)).toList(),
          );
        }
      },
    );
  }
}
