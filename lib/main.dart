import 'package:flutter/material.dart';
import 'package:flutter_app/mvp/view/pages/MainPage.dart';

void main() => runApp(new MyApp());

/**
 * 应用程序继承了 StatelessWidget，这将会使应用本身也成为一个widget
 * This widget is the root of your application.
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
            primaryColor: Colors.white
        ),
        home: new MainPage(homePageTitle: 'Flutter APP'),
    );
  }
}
