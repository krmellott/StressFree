import 'package:firstapp/utils/buttons.dart';
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

  getTaskCompletion() {
    return _taskCompleted;
  }

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

class DropdownTaskState extends StatefulWidget {
  const DropdownTaskState({Key? key}) : super(key: key);

  @override
  State<DropdownTaskState> createState() => _DropdownTaskStateState();
}

class _DropdownTaskStateState extends State<DropdownTaskState> {
  int dropdownValue = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
        child: Row(
          children: [
            Text("How important is it (1 to 5)?"),
            DropdownButton<int>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (int? newValue) {
                setState(() {
                  dropdownValue = newValue!;
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
}

class addTask_page extends StatelessWidget {
  DateTime date = DateTime(0, 0, 0);
  String message = "";
  int dropdownValue = 1;

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
            DropdownTaskState(),
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

  _insertInsertButton(BuildContext context) {
    return MyButton(
        label: "Save Task!",
        onTap: () {
          print("Here are the values we have so far!: ");
          print("{'date':" +
              date.toString() +
              ",\n"
                  "'task':" +
              message +
              ",\n" +
              "'status'" +
              "}");
        });
  }
}
