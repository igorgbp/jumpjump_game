
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
  Timer interval = Timer(Config.timeBetweenPipes,repeat: true);  
  @override
  Future<void> onLoad() async {
    addAll([Background(), Wind(), ball = Ball(),]);
    interval.onTick = () { 
      pipePosition = Random().nextBool() ? PipePosition.left : PipePosition.right;
      add(CurrentPipe(pipePosition: pipePosition));};
  }




@override
void onTapDown(TapDownInfo info) {
  final screenSize = size;
  final isRightClick = info.raw.localPosition.dx > screenSize.x / 2;

  if (isRightClick) {
    // Ação para clique do lado direito
    print("Clique do lado direito");
    ball.jump(pipePosition: PipePosition.right);
  } else {
    // Ação para clique do lado esquerdo
    print("Clique do lado esquerdo");
    ball.jump(pipePosition: PipePosition.left);

  }
  super.onTapDown(info);
}


  @override
  void update(double dt){
    super.update(dt);
    interval.update(dt);
  }


}
