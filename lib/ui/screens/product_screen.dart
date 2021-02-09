import 'package:carousel_pro/carousel_pro.dart';
import 'package:confectstore/data/cart_product.dart';
import 'package:confectstore/data/product_data.dart';
import 'package:confectstore/models/cart_model.dart';
import 'package:confectstore/models/user_model.dart';
import 'package:confectstore/ui/screens/cart_screen.dart';
import 'package:confectstore/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final ProductData productData;

  ProductScreen(this.productData);

  @override
  _ProductScreenState createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData productData;
  String size;

  _ProductScreenState(this.productData);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme
        .of(context)
        .primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: productData.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  productData.title,
                  maxLines: 3,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  "R\$ ${productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text("Tamanho",
                    style:
                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      children: productData.sizes.map((s) {
                        return GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                                border: Border.all(
                                    color: s == size ? primaryColor : Colors
                                        .grey[500], width: 3.0)),
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(s),
                          ),
                          onTap: () {
                            setState(() {
                              size = s;
                            });
                          },
                        );
                      }).toList()),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: size != null ? () {
                      if (UserModel.of(context).isLoggedIn()) {
                        CartProduct cartProduct = new CartProduct();
                          cartProduct.size = size;
                          cartProduct.quantity = 1;
                          cartProduct.productId = productData.id;
                          cartProduct.category = productData.category;
                          cartProduct.productData = productData;

                          CartModel.of(context).addCartItem(cartProduct);
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CartScreen())
                        );
                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Adicionar ao carrinho"
                          : "Entre para comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Descrição",
                    style:
                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                Text(
                  productData.description,
                  style: TextStyle(fontSize: 16.0),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
