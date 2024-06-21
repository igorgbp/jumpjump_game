import 'package:flutter/material.dart';
import 'package:jump_jump/game/jump_jump_game.dart';

class GameOverScreen extends StatelessWidget {
  final JumpJumpGame game;
  static const String id = 'gameOver';
  const GameOverScreen({Key? key, required this.game}): super(key:key);

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
          InkWell(onTap: ()=>_restartGame(),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: Text('game over'),

          ),)

        ],)
      ),
    );
  }

  void _restartGame(){
    game.ball.reset();
    game.overlays.remove('gameOver');
    game.overlays.add('mainMenu');
    game.resumeEngine();
  }
}