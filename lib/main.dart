import 'package:confectstore/models/cart_model.dart';
import 'package:confectstore/models/user_model.dart';
import 'package:confectstore/ui/screens/home_screen.dart';
import 'package:confectstore/ui/screens/login_screen.dart';
import 'package:confectstore/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return ScopedModel<UserModel>(
      model: UserModel(),
      child:ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child:  MaterialApp(
              title: 'Confect Store',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Color.fromARGB(255, 4, 125, 141),
                  primarySwatch: Colors.blue),
              home: HomeScreen(),
            ),
          );
        }
      )
    );
  }
}
