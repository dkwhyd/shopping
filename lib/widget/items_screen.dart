import 'package:flutter/material.dart';
import 'package:shopping/helper/dbhelper.dart';
import 'package:shopping/model/list_items.dart';
import 'package:shopping/model/shopping_list.dart';
import 'package:shopping/widget/list_item_dialog.dart';

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

  DbHelper helper = DbHelper();
  List? items;
  _ItemsScreenState(this.shoppingList);
  ItemListDialog? dialog;

  int? idList;

  @override
  void initState() {
    idList = shoppingList!.id;
    showData();
    dialog = ItemListDialog();
    dialog!.onDataSaved = showData;
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
              'Quantity: ${items![index].quantity} - Note: ${items![index].note}',
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {},
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // print(items![index].name);
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        dialog!.buildDialog(context, items![index], false));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => dialog!.buildDialog(
                  context, ListItem(0, shoppingList!.id, '', '', ''), true));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future showData() async {
    await helper.openDb();
    items = await helper.getItems(idList!);
    setState(() {
      items = items;
    });
  }
}
