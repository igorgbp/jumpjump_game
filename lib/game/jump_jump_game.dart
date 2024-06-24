import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jump_jump/components/background.dart';
import 'package:jump_jump/components/ball.dart';
import 'package:jump_jump/components/current_pipe.dart';
import 'package:jump_jump/components/wind.dart';
import 'package:jump_jump/components/wind_b.dart';
import 'package:jump_jump/components/wind_c.dart';
import 'package:jump_jump/game/ball_hit.dart';
import 'package:jump_jump/game/configuration.dart';
import 'package:jump_jump/game/pipe_position.dart';

class JumpJumpGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Ball ball;
  PipePosition pipePosition = PipePosition.right;
  // late bool gravityDown;
  double velocityIncreaser = 1;
  // bool aumentar = true;
  bool showPipe = true;
  double pointGravityFuture = 0;
  double pointGravityCurrent = 0;
  late TextComponent score;
  Timer interval = Timer(Config.initialTimeBetweenPipes, repeat: true);
  @override
  Future<void> onLoad() async {
    // gravityDown = true;
    addAll([Background(),
     Wind(),
      WindB(),
       WindC(),
        ball = Ball(),
         score = buildScore()]);
    interval.onTick = () {
      pipePosition =
          Random().nextBool() ? PipePosition.left : PipePosition.right;

      if (showPipe) {
        add(CurrentPipe(pipePosition: pipePosition));
        showPipe = Random().nextInt(3) == 2;
      } else {
        showPipe = Random().nextInt(2) == 1;
      }
    };
  }

  TextComponent buildScore() {
    return TextComponent(
        text: 'Score: 0',
        position: Vector2(size.x / 2, size.y * 0.2),
        anchor: Anchor.center);
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

  @override
  void update(double dt) {
    super.update(dt);
    ball.anchor = Anchor.center;
    ball.angle = ball.angle + 0.08;
    _handleVelocityIncrease();
    print('future ${pointGravityFuture}, ballhit: ${ball.ballHit} current: ${pointGravityCurrent}');
   
   if(ball.ballHit == BallHit.initial){

   
     if( pointGravityCurrent<pointGravityFuture){
      pointGravityCurrent = pointGravityCurrent +pointGravityFuture/25;
    }else{
      pointGravityFuture = 0;
      if(pointGravityCurrent < 0){
        pointGravityCurrent = 0;
      }
      if(pointGravityCurrent>0){
        pointGravityCurrent = pointGravityCurrent -pointGravityCurrent/25;
        if(pointGravityCurrent.round()<1){
          pointGravityCurrent = 0;
        }
      }
    }}
    if (ball.position.y <30){
      pointGravityCurrent = 0;
      pointGravityFuture = 0;   }
    ball.position = Vector2(ball.position.x,
        ball.position.y + Config.ballMovingTendency - pointGravityCurrent);
    if (ball.position.y.round() >= (size.y).round()) {
      // print('no final ${size.x}');
      ball.gameOver();
    }
    interval.update(dt);
  }

  void _handleVelocityIncrease() {
    if (ball.score > 3 && velocityIncreaser <= 1.5) {
      velocityIncreaser = velocityIncreaser + 0.005;
    } else if (ball.score > 10 && velocityIncreaser <= 2) {
      velocityIncreaser = velocityIncreaser + 0.005;
    } else if (ball.score > 20 && velocityIncreaser <= 3) {
      velocityIncreaser = velocityIncreaser + 0.005;
    } else if (ball.score > 30 && velocityIncreaser <= 4) {
      velocityIncreaser = velocityIncreaser + 0.01;
    } else if (ball.score > 50 && velocityIncreaser <= 5) {
      velocityIncreaser = velocityIncreaser + 0.003;
    }
  }

  void setGravityUp() {
    if(pointGravityFuture != 0){
    pointGravityFuture =(pointGravityFuture - pointGravityCurrent) +  3;

    } else {
      pointGravityFuture = 3;
    }
  }
}
