import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/utils/buttons.dart';
import 'package:flutter/material.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  State<AddEntry> createState() => _AddEntry();
}

class _AddEntry extends State<AddEntry> {
  StressFreeController controllerRef = StressFreeController();
  DateTime date = DateTime.now();
  String body = "";
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Journal Entry"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title your entry!',
                      ),
                      onChanged: (String? aTitle) {
                        setState(() {
                          title = aTitle!;
                        });
                      },
                    ),
                  ),
                ),
                MyButton(
                  label: 'Save',
                  onTap: () {
                    controllerRef.insertJournalData(
                        body, [date.month, date.day, date.year], title);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'What did you do today?',
                ),
                onChanged: (String? aBody) {
                  setState(() {
                    body = aBody!;
                  });
                },
              ),
            ),
          ],
        ));
  }
}
