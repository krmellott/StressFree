import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MusicPage extends StatefulWidget {
  @override
  _MusicPage createState() => _MusicPage();
}

class _MusicPage extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Music"),
        )
    );
  }
}
