import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confectstore/data/cart_product.dart';
import 'package:confectstore/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{
    List<CartProduct> products = [];
    UserModel user;
    String couponCode;
    int discountPercentage = 0;

    bool isLoading = false;

    CartModel(this.user){

      if(user.isLoggedIn()) {
        _loadCartItens();
      }
    }

    static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

    void updatePrices(){
      notifyListeners();
    }

    void addCartItem(CartProduct cartProduct){

      products.add(cartProduct);
      Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cartProduct.toMap()).then((doc){
        cartProduct.cartId = doc.documentID;
      });

      notifyListeners();

    }

    void removeCartItem(CartProduct cartProduct){
      Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cartId).delete();
      products.remove(cartProduct);
      notifyListeners();

    }
    
    void decProduct(CartProduct cartProduct){
      cartProduct.quantity--;
      Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cartId).updateData(cartProduct.toMap());
      notifyListeners();

    }

    void incProduct(CartProduct cartProduct){
      cartProduct.quantity++;
      Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cartId).updateData(cartProduct.toMap());
      notifyListeners();
    }

    void setCupon(String cuponCode, int discountPercentage){
      this.couponCode = cuponCode;
      this.discountPercentage = discountPercentage;
    }
    void _loadCartItens() async {
      QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
      products = query.documents.map((doc) => CartProduct.fromDocument( doc)).toList();
      notifyListeners();
    }

    double getProductsPrice(){
      double price = 0.0;
      for(CartProduct product in products){
        if(product != null){
          price +=  product.quantity * product.productData.price;
        }
      }

      return price;
    }

    double getShipPrice(){
      return 13.99;
    }

    double getDiscountPrice(){
      return getProductsPrice() * discountPercentage / 100;
    }

    Future<String> finishOrder() async{
      if(products.length  == 0) return null;
      isLoading = true;
      notifyListeners();

      double productsPrice = getProductsPrice();
      double shipPrice = getShipPrice();
      double discount = getDiscountPrice();
      
      DocumentReference refOrder = await Firestore.instance.collection("orders").add({
        "clientId" : user.firebaseUser.uid,
        "products" : products.map((cartProduct) => cartProduct.toMap()).toList(),
        "shipPrice" : shipPrice,
        "productsPrice" : productsPrice,
        "discount": discount,
        "totalPrice" : productsPrice + shipPrice - discount,
        "status" : 1
      });

      await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(refOrder.documentID).setData({
          "orderId" : refOrder.documentID
      });
      
      QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
      for(DocumentSnapshot doc in query.documents){
        doc.reference.delete();
      }

      products.clear();
      discountPercentage = 0;
      couponCode = null;
      isLoading = false;
      notifyListeners();

      return refOrder.documentID;



    }


}