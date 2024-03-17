import 'package:flutter/material.dart';
import 'package:shopping/helper/dbhelper.dart';
import 'package:shopping/model/list_items.dart';

class ItemListDialog {
  final idList = TextEditingController();
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();
  Function? onDataSaved;

  Widget buildDialog(BuildContext context, ListItem item, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = item.name!;
      txtQuantity.text = item.quantity!.toString();
      txtNote.text = item.note.toString();
    } else {
      txtName.text = '';
      txtQuantity.text = '';
      txtNote.text = '';
    }
    return AlertDialog(
      title: Text((isNew) ? 'New Shopping list' : 'Edit shopping list'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: const InputDecoration(
                hintText: 'Item Name',
              ),
            ),
            TextField(
              controller: txtQuantity,
              decoration: const InputDecoration(
                hintText: 'Quantity',
              ),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              controller: txtNote,
              decoration: const InputDecoration(
                hintText: 'Note',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: (!isNew)
                      ? ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            await helper.deleteItem(item);
                            onDataSaved!.call();
                          },
                          child: const Text('Delete'),
                        )
                      : null,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // item.idList = item.id;
                    item.name = txtName.text;
                    item.quantity = txtQuantity.text;
                    item.note = txtNote.text;
                    Navigator.pop(context);
                    await helper.insertItem(item);
                    onDataSaved!.call();
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
