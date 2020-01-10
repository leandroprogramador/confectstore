import 'package:confectstore/data/product_data.dart';
import 'package:confectstore/ui/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData productData;

  ProductTile(this.type, this.productData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push( MaterialPageRoute(builder: (context) => ProductScreen(productData) ));
      },
      child: Card(
          child: type == "grid" ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(productData.images[0], fit: BoxFit.cover),

              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(productData.title, style: TextStyle(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                      Text("R\$ ${productData.price.toStringAsFixed(2)}", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              )
            ],
          ) :
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Image.network(productData.images[0], fit: BoxFit.cover, height: 150.0),

              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(productData.title, style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("R\$ ${productData.price.toStringAsFixed(2)}", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
