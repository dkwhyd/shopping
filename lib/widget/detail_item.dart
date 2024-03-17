import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    double halfScreenHeight = MediaQuery.of(context).size.height / 2;

    return Container(
      height: halfScreenHeight,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Text(
              '${data['name']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Quantity:',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          Text('${data['quantity']}'),
          const SizedBox(height: 10),
          const Text(
            'Note',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          Text('${data['note']}'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
