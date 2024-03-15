import 'package:flutter/material.dart';
import 'package:shopping/model/shopping_list.dart';

// ignore: must_be_immutable
class ItemsScreen extends StatefulWidget {
  ShoppingList? shoppingList;
  ItemsScreen(this.shoppingList, {super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList? shoppingList;
  _ItemsScreenState(this.shoppingList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList!.name.toString()),
      ),
      body: Container(),
    );
  }
}
