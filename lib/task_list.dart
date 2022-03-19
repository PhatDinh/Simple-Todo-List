import 'package:flutter/material.dart';
import 'package:to_do_list/db_provider.dart';
import 'package:to_do_list/task_card.dart';

class TaskList extends StatelessWidget {
  var db = DBProvider();
  final Function deleteFunction;
  final Function insertFunction;
  final int checkState;
  TaskList(
      {Key? key,
      required this.deleteFunction,
      required this.insertFunction,
      this.checkState = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: db.getTask(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var data = snapshot.data;
            var len = data!.length;
            return ListView.builder(
                itemCount: len,
                itemBuilder: (context, i) {
                  if (checkState == 1) {
                    if (DateTime.now()
                            .day
                            .compareTo(data[i].creationDate.day) !=
                        0) return Container();
                  } else if (checkState == 2) {
                    if (DateTime.now().isAfter(data[i].creationDate))
                      return Container();
                  }
                  return TaskCard(
                      id: data[i].id,
                      title: data[i].title,
                      creationDate: data[i].creationDate,
                      deleteFunction: deleteFunction,
                      insertFunction: insertFunction,
                      isChecked: data[i].isChecked);
                });
          }),
    );
  }
}
