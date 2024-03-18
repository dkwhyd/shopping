import 'package:flutter/material.dart';
import 'package:shopping/helper/dbhelper.dart';
import 'package:shopping/model/shopping_list.dart';
import 'package:shopping/widget/items_screen.dart';
import 'package:shopping/widget/shopping_list_dialog.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  ShoppingState createState() => ShoppingState();
}

class ShoppingState extends State {
  DbHelper helper = DbHelper();
  List? shoppingList;
  ShoppingListDialog? dialog;

  @override
  void initState() {
    showData();
    dialog = ShoppingListDialog();
    dialog!.onDataSaved = showData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: (shoppingList != null) ? shoppingList!.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(shoppingList![index].name),
            onDismissed: (direction) {
              String strName = shoppingList![index].name;
              helper.deleteList(shoppingList![index]);
              setState(() {
                shoppingList!.removeAt(index);
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$strName deleted")));
            },
            direction: DismissDirection.horizontal,
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.startToEnd) {
                // Confirm edit logic
                return showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog!
                        .buildDialog(context, shoppingList![index], false));
              } else {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Delete"),
                      content:
                          const Text("Are you sure you want to delete this list?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            background: Container(
              color: Colors.green,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            child: ListTile(
              title: Text(shoppingList![index].name),
              leading: CircleAvatar(
                child: Text(shoppingList![index].priority.toString()),
              ),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog!
                            .buildDialog(context, shoppingList![index], false));
                    showData();
                  },
                  icon: const Icon(Icons.edit)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemsScreen(shoppingList![index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog!.buildDialog(context, ShoppingList(0, '', 0), true),
          );
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
}
