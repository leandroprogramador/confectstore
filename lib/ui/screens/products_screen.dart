import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confectstore/data/product_data.dart';
import 'package:confectstore/ui/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ProductsScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("products")
              .document(snapshot.documentID)
              .collection("itens")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      ProductData data = ProductData.fromDocument(
                          snapshot.data.documents[index]);
                      data.category = this.snapshot.documentID;
                      return ProductTile("grid", data);
                    },
                    padding: EdgeInsets.all(4.0),
                  ),
                  Container(
                    child: ListView.builder(
                        padding: EdgeInsets.all(4.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          ProductData data = ProductData.fromDocument(
                              snapshot.data.documents[index]);
                          data.category = this.snapshot.documentID;
                          return ProductTile(
                              "list",
                              data);
                        }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
