import 'package:expansion_list/expansion_list.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: ExpansionListExample(),
    );
  }
}

// ignore: must_be_immutable
class ExpansionListExample extends StatelessWidget {
  String month = 'Month';

  final List months = ['Jan', 'Feb', 'Mar'];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Expansion list example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Normal usage'),
            SizedBox(height: 10,),
            ExpansionList(
                onItemSelected: (selected) {
                  month = selected.toString();
                  print(month); // To get the value selected.
                },
                items: months,
                title: month,
                ),
          ],
        ),
      ),
    );
  }
}
