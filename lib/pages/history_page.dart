import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // these come first
    // TODO: Fix day display so it starts with 1 instead of 0
    // TODO: Make grid start on the proper day of the week instead of every month starting on sunday
    // TODO: Display the name of the day in top row
    // these two come later
    // TODO: Change box color to match selected mood that day
    // TODO: Allow user to click on day to view the activities they did that day

    const title = "History";

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body:GridView.count(
          crossAxisCount: 7, //sets the grid to be 7 boxes wide
          //padding:,
          // Generate 35 widgets that display their index in the List.
          children: List.generate(35, (index) {
            return Center(
              child: Text(
                  'Day $index',
                  // this is theme stuff, we can worry about it later
                  //style: Theme.of(context).textTheme.headline5,
                ),
            );
          }),
        ),
      ),
    );
/*
    return Scaffold(
      body: Center(
        child: Text('Your History Here!'),
      ),
    );
    */

  }

}