import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confectstore/ui/screens/products_screen.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: Container(
         child:  CircleAvatar(
           radius: 20.0,
           backgroundColor: Colors.transparent,
           backgroundImage: NetworkImage(snapshot.data["icon"]),
         ),
        margin: EdgeInsets.all(8.0),
      ),
      title: Text(snapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsScreen(snapshot)));
      },
    );
  }
}
