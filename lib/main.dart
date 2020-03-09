import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:alisverislistemflutter/ui/styles/text_style.dart';
import 'package:alisverislistemflutter/ui/widgets/input_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alışveriş Listem',
      theme: ThemeData(
        primaryColor: kThemePrimary,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Alışveriş Listem'),
        ),
        body: InputPage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
            }
          },
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Color(0xFFF21D81),
        ),
      ),
    );
  }
}
