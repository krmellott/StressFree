import 'package:firstapp/utils/units_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioTask extends StatefulWidget {
  const RadioTask({Key? key}) : super(key: key);

  @override
  State<RadioTask> createState() => _RadioTaskState();
}

class _RadioTaskState extends State<RadioTask> {
  TaskCompleted? _taskCompleted = TaskCompleted.NO;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: const Text('Task completed!'),
            leading: Radio<TaskCompleted>(
                groupValue: _taskCompleted,
                value: TaskCompleted.YES,
                onChanged: (TaskCompleted? value) {
                  setState(() {
                    _taskCompleted = TaskCompleted.YES;
                  });
                })),
        ListTile(
            title: const Text('Task not complete!'),
            leading: Radio<TaskCompleted>(
                groupValue: _taskCompleted,
                value: TaskCompleted.NO,
                onChanged: (TaskCompleted? value) {
                  setState(() {
                    _taskCompleted = value;
                  });
                }))
      ],
    );
  }
}

class addTask_page extends StatelessWidget {
  DateTime date = DateTime(0, 0, 0);
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Insert an Activity!"),
        ),
        body: Column(
          children: [
            _insertTextBox(context),
            _insertDate(context),
            RadioTask(),
          ],
        ));
  }

  _insertTextBox(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Tell us what you did!',
          ),
        ));
  }

  _insertDate(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
        child: Container(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              date = newDateTime;
            },
          ),
        ));
  }
}
