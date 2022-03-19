import 'package:flutter/material.dart';
import 'package:to_do_list/db_provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/rounded_button.dart';
import 'package:to_do_list/rounded_search.dart';
import 'package:to_do_list/search.dart';
import 'package:to_do_list/task_list.dart';
import 'package:to_do_list/widgets/rounded_tab_text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = DBProvider();

  DateTime newDate = DateTime.now();
  String newText = '';
  late List<Task> names;

  void addItem(Task task) async {
    await db.insertTask(task);
    setState(() {});
  }

  void deleteItem(Task task) async {
    await db.deleteTask(task);
    setState(() {});
  }

  void showAdd() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
                height: 500,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(children: [
                  TextField(
                    onChanged: (text) {
                      newText = text;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),
                  Stack(children: [
                    Card(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select Date',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: Text("Select"),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1990, 1),
                              lastDate: DateTime(2022, 4),
                            ).then((pickedDate) {
                              setState(() {
                                newDate = pickedDate!;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                  ]),
                  ElevatedButton(
                    child: Text(
                      'Submit',
                    ),
                    onPressed: () {
                      print('Im touch this');
                      Task temp = Task(
                          title: newText,
                          creationDate: newDate,
                          isChecked: false);
                      print(temp.title);
                      db.insertTask(temp);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                ])),
          );
        });
  }

  void getDatabase() async {
    names = await db.getTask();
  }

  int stateHome = 0;
  @override
  Widget build(BuildContext context) {
    getDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple To Do App'),
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            print("im press u");
            final result = await showSearch<String>(
              context: context,
              delegate: TaskSearch(names),
            );

            print(result);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAdd,
        child: Icon(Icons.plus_one),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        stateHome = 0;
                        print(stateHome);
                      });
                    },
                    child: Text(
                      'All',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        stateHome = 1;
                        print(stateHome);
                      });
                    },
                    child: Text(
                      'Today',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        stateHome = 2;
                        print(stateHome);
                      });
                    },
                    child: Text(
                      'Upcoming',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TaskList(
            deleteFunction: deleteItem,
            insertFunction: addItem,
            checkState: stateHome,
          )
        ],
      ),
    );
  }
}
