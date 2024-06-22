
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jump_jump/components/background.dart';
import 'package:jump_jump/components/ball.dart';
import 'package:jump_jump/components/current_pipe.dart';
import 'package:jump_jump/components/wind.dart';
import 'package:jump_jump/game/configuration.dart';
import 'package:jump_jump/game/pipe_position.dart';

class JumpJumpGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Ball ball;
  PipePosition pipePosition = PipePosition.right;
  late bool gravityDown;
  int gravityUpCount = 0;
  late TextComponent score;
  Timer interval = Timer(Config.timeBetweenPipes,repeat: true);  
  @override
  Future<void> onLoad() async {
    gravityDown = true;
    addAll([Background(), Wind(), ball = Ball(),score = buildScore()]);
    interval.onTick = () { 
      gravityUpCount = gravityUpCount + 1; 
      pipePosition = Random().nextBool() ? PipePosition.left : PipePosition.right;
      add(CurrentPipe(pipePosition: pipePosition));};
  }


  TextComponent buildScore(){
    return TextComponent(
      text:'Score: 0',
      position: Vector2(size.x /2 , size.y * 0.2),
      anchor: Anchor.center 
    );
  }

@override
void onTapDown(TapDownInfo info) {
  final screenSize = size;
  final isRightClick = info.raw.localPosition.dx > screenSize.x / 2;

  if (isRightClick) {
    ball.jump(pipePosition: PipePosition.right);
  } else {
    ball.jump(pipePosition: PipePosition.left);

  }
  super.onTapDown(info);
}


  void setGravityUp(){
    gravityDown = false;
  }

  @override
  void update(double dt){
    super.update(dt);

    if(gravityDown){
      ball.position = Vector2(ball.position.x,  ball.position.y+Config.ballMovingTendency);
    } else {
      ball.position = Vector2(ball.position.x,  ball.position.y-Config.ballMovingTendency/5);
      if(gravityUpCount>5 ){
        gravityDown = true;
        gravityUpCount = 0;
      }
    }
    if(ball.position.y.round() >= (size.y-ball.size.y).round()){
      // print('no final ${size.x}');
      ball.gameOver();
    }
    interval.update(dt);
  }
}
