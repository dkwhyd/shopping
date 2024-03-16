import 'package:flutter/material.dart';
import 'package:shopping/helper/dbhelper.dart';
import 'package:shopping/model/shopping_list.dart';

// ignore: must_be_immutable
class ItemsScreen extends StatefulWidget {
  ShoppingList? shoppingList;
  ItemsScreen(this.shoppingList, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ItemsScreen> createState() => _ItemsScreenState(shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList? shoppingList;

  DbHelper? helper;
  List? items;
  _ItemsScreenState(this.shoppingList);

  @override
  void initState() {
    helper = DbHelper();
    showData(shoppingList?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList!.name.toString()),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: (items != null) ? items!.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items![index].name),
            subtitle: Text(
                'Quantity: ${items![index].quantity} - Note:${items![index].note}'),
            onTap: () {},
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }

  Future showData(var idList) async {
    await helper!.openDb();
    items = await helper!.getItems(idList);
    // print(items![0].name);
    setState(() {
      items = items;
    });
  }
}
