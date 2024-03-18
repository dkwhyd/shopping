import 'package:flutter/material.dart';
import 'package:shopping/helper/dbhelper.dart';
import 'package:shopping/model/shopping_list.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();
  void Function()? onDataSaved;

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = list.name!;
      txtPriority.text = list.priority!.toString();
    } else {
      txtName.text = '';
      txtPriority.text = '';
    }
    return AlertDialog(
      title: Text((isNew) ? 'New Shopping list' : 'Edit shopping list'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: const InputDecoration(
                hintText: 'Shopping List Name',
              ),
            ),
            TextField(
              controller: txtPriority,
              decoration: const InputDecoration(
                hintText: 'Shopping List Priority (1-3)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 ElevatedButton(
                  onPressed: () async {
                    list.name = txtName.text;
                    list.priority = int.parse(txtPriority.text);
                    Navigator.pop(context);
                    await helper.insertList(list);
                    onDataSaved?.call();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
