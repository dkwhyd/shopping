import 'package:flutter/material.dart';
import 'package:shopping/helper/dbhelper.dart';
import 'package:shopping/widget/items_screen.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  ShoppingState createState() => ShoppingState();
}

class ShoppingState extends State {
  DbHelper helper = DbHelper();
  List? shoppingList;

  @override
  void initState() {
    // helper.deleteListItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return ListView.builder(
        itemCount: (shoppingList != null) ? shoppingList!.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(shoppingList![index].name),
            leading: CircleAvatar(
              child: Text(shoppingList![index].priority.toString()),
            ),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemsScreen(shoppingList![index])));
            },
          );
        });
  }

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
}
