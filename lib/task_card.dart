import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/models/task.dart';

class TaskCard extends StatefulWidget {
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;
  final Function insertFunction;
  final Function deleteFunction;

  TaskCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.creationDate,
      required this.deleteFunction,
      required this.insertFunction,
      required this.isChecked})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    var anotherTask = Task(
        id: widget.id,
        title: widget.title,
        creationDate: widget.creationDate,
        isChecked: widget.isChecked);
    return Card(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Checkbox(
                  value: widget.isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.isChecked = value!;
                      anotherTask.isChecked = value!;
                      widget.insertFunction(anotherTask);
                    });
                  })),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  DateFormat('dd-MM-yy - hh:mm')
                      .format(widget.creationDate)
                      .toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                widget.deleteFunction(anotherTask);
              },
              icon: Icon(Icons.close)),
        ],
      ),
    );
  }
}
