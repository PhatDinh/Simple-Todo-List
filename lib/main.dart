import 'package:flutter/material.dart';
import 'package:to_do_list/home.dart';
import 'package:to_do_list/models/task.dart';
import './db_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = DBProvider();
  print(await db.getTask());
  List<Task> test = await db.getTask();
  print(test);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
