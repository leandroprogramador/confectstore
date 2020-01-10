import 'package:confectstore/ui/tabs/categories_tab.dart';
import 'package:confectstore/ui/widgets/cart_button.dart';
import 'package:confectstore/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:confectstore/ui/tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {


    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
            centerTitle: true,
          ),
          body: CategoriesTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Container(color: Colors.blueGrey),
        Container(color: Colors.brown),
      ],
    );
  }
}
