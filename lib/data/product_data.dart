import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  String category;
  String id;
  String title;
  String description;
  double price;
  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.documentID;
    title = documentSnapshot.data["title"];
    description = documentSnapshot.data["description"];
    price = documentSnapshot.data["price"]+ 0.0;
    images = documentSnapshot.data["images"];
    sizes = documentSnapshot.data["sizes"];
  }

 Map<String, dynamic> toResumeMap() {
    return{
      "title" : title,
      "description" : description,
      "price" : price
    };
 }

}
