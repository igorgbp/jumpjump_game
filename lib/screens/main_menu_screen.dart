import 'package:flutter/material.dart';
import 'package:jump_jump/game/jump_jump_game.dart';

class MainMenuScreen extends StatelessWidget {
  final JumpJumpGame game;
  static const String id = 'mainMenu';
  const MainMenuScreen({Key? key, required this.game}): super(key:key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return  Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          InkWell(onTap: ()=>_startGame(),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: Text('asdf'),

          ),)

        ],)
      ),
    );
  }

  void _startGame(){
    game.overlays.remove('mainMenu');
    game.resumeEngine();
  }
}