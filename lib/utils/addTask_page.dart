import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/utils/buttons.dart';
import 'package:firstapp/utils/units_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  stressFree_Controller SFControllerRef = stressFree_Controller();
  DateTime date = DateTime.now();
  String message = "";
  int _dropdownValue = 3;
  TaskCompleted _taskCompleted = TaskCompleted.NO;

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
            _insertRadioTask(context),
            _insertDropdownMenu(context),
            _insertInsertButton(context),
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
          onSubmitted: (String? aMessage) {
            setState(() {
              message = aMessage!;
            });
          },
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

  _insertRadioTask(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: const Text('Task completed!'),
            leading: Radio<TaskCompleted>(
                groupValue: _taskCompleted,
                value: TaskCompleted.YES,
                onChanged: (TaskCompleted? value) {
                  setState(() {
                    _taskCompleted = value!;
                  });
                })),
        ListTile(
            title: const Text('Task not complete!'),
            leading: Radio<TaskCompleted>(
                groupValue: _taskCompleted,
                value: TaskCompleted.NO,
                onChanged: (TaskCompleted? value) {
                  setState(() {
                    _taskCompleted = value!;
                  });
                }))
      ],
    );
  }

  _insertDropdownMenu(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
        child: Row(
          children: [
            Text("How important is it (1 to 5)?"),
            DropdownButton<int>(
              value: _dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (int? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });
              },
              items:
                  <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            )
          ],
        ));
  }

  _insertInsertButton(BuildContext context) {
    return MyButton(
        label: "Save Task!",
        onTap: () {
          bool isCompleted;
          if (_taskCompleted == TaskCompleted.YES)
            isCompleted = true;
          else
            isCompleted = false;
          SFControllerRef.insertActivityData(message, isCompleted,
              [date.month, date.day, date.year], _dropdownValue);
          Navigator.pop(context);
        });
  }
}
