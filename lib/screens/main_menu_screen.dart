import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/models/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuScreen extends StatefulWidget {
  final JumpJumpGame game;
  static const String id = 'mainMenu';
  const MainMenuScreen({Key? key, required this.game}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  List<PointsRecord> _listaRecords = [];

  @override
  void initState() {
    print('inistate main menu');
    _getRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.game.pauseEngine();

    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => _startGame(),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text('asdf'),
                ),
              ),
              _listaRecords.length > 0?
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 40,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            backgroundBlendMode: BlendMode.colorBurn,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                          
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_listaRecords[index].points.toString()),
                            Text(_dateToString(_listaRecords[index].date))
                          ],
                        )),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(height: 4,),
                  itemCount: 3) : const SizedBox()
            ],
          )),
    );
  }

  void _startGame() {
    widget.game.overlays.remove('mainMenu');
    widget.game.resumeEngine();
  }

  void _getRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var recordsString = prefs.getString('records');
    if (recordsString != null) {
      var recordsDecoded = jsonDecode(recordsString) as List<dynamic>;
      var parsedList =
          recordsDecoded.map((e) => PointsRecord.fromJson(e)).toList();
          parsedList.sort((a, b) => b.points.compareTo(a.points),);
      setState(() {
        _listaRecords =parsedList ;
      });
    }
  }

  String _dateToString (DateTime data){
    var string = '${data.day}/${data.month}  ${data.hour}: ${data.minute}';
    return string;
  }
}
