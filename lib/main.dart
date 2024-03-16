import 'package:flutter/material.dart';
import 'package:shopping/widget/shopping.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Shopping',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.blue,
          ),
          body: const Shopping()),
    );
  }
}
