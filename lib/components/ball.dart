import 'dart:convert';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:jump_jump/game/assets.dart';
import 'package:jump_jump/game/ball_hit.dart';
import 'package:jump_jump/game/ball_movement.dart';
import 'package:jump_jump/game/configuration.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/game/pipe_position.dart';
import 'package:jump_jump/models/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ball extends SpriteGroupComponent<BallMovement>
    with HasGameRef<JumpJumpGame>, CollisionCallbacks {
  Ball();
  int score = 0;
  late double ballInitialPositionY;
  late double ballInitialPositionX;
  late BallHit ballHit;
  Component? currentEffect;

  @override
  Future<void> onLoad() async {
    ballHit = BallHit.initial;
    final ballflat = await gameRef.loadSprite(Assets.ball);
    score = 0;
    print('load');
    //carregar depois as outras imagens da bola com os reflexos
    size = Vector2(50, 50);
    ballInitialPositionY = gameRef.size.x / 5;
    ballInitialPositionX = gameRef.size.x / 2;
    position = Vector2(ballInitialPositionX, ballInitialPositionY);

    current = BallMovement.middle;
    sprites = {
      BallMovement.middle: ballflat,
      BallMovement.left: ballflat,
      BallMovement.right: ballflat
    };
    add(CircleHitbox());
  }

  void jump({required PipePosition pipePosition}) {
    if (position.x.round() != ballInitialPositionX.round()) {
      print('clicou quando não estava no centro');
    } else {
      add(MoveByEffect(
          Vector2(
              (pipePosition == PipePosition.right ? 1 : -1) *
                  ballInitialPositionX,
              0),
          EffectController(duration: 0.17, curve: Curves.easeOutCubic),
          onComplete: () => onCompleteJump(pipePosition: pipePosition)));
    }

    ballHit = BallHit.movingToPipe;
    current = BallMovement.middle;
  }

  void onCompleteJump({required PipePosition pipePosition}) {
    add(MoveByEffect(
        Vector2(
            (pipePosition == PipePosition.right ? -1 : 1) *
                ballInitialPositionX,
            0),
        EffectController(duration: 0.1, curve: Curves.easeInCubic),
        onComplete: () {
      if (position.x != ballInitialPositionX) {
        position.x = ballInitialPositionX;
      }
    }));
    ballHit = BallHit.movingBack;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    ballHit = BallHit.hitted;
    score = score + 1;
    gameRef.setGravityUp();
    gameRef.score.text = 'score: ${score}';
  }

  void reset() {
    position = Vector2(ballInitialPositionX, ballInitialPositionY);
  }

  void gameOver() async {
    gameRef.overlays.add('gameOver');
    reset();
    gameRef.velocityIncreaser = 1;
    gameRef.pauseEngine();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var recordsString = prefs.getString('records');
    if (recordsString != null) {
      var recordsDecoded = jsonDecode(recordsString) as List<dynamic>;
      var parsedList =
          recordsDecoded.map((e) => PointsRecord.fromJson(e)).toList();
      parsedList.add(PointsRecord(points: score, date: DateTime.now()));
      var test = parsedList.map((e) => e.toJson(e)).toList();
      prefs.setString('records', jsonEncode(test));
    }
  }

  @override
  void update(double dt) {
    // print(position.x);
    super.update(dt);

    // posti
  }
}
