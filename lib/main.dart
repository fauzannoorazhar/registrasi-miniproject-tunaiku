import 'package:flutter/material.dart';
import 'package:register_tunaiku/ui/views/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primaryColor: Color(0xFF5AB11A),
                visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: RegisterPage(),
        );
    }
}