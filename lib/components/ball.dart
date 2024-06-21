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

class Ball extends SpriteGroupComponent<BallMovement> with HasGameRef<JumpJumpGame>, CollisionCallbacks{
  Ball();
  late double ballInitialPositionY;
  late double ballInitialPositionX;
  late BallHit ballHit;


  @override
  Future<void> onLoad() async {
    ballHit = BallHit.initial;
    final ballflat = await gameRef.loadSprite(Assets.ball);
    //carregar depois as outras imagens da bola com os reflexos
    size = Vector2(50, 50);
     ballInitialPositionY = gameRef.size.y - (gameRef.size.y /4);
     ballInitialPositionX = gameRef.size.x /2 -size.x /2;
    position = Vector2(ballInitialPositionX,ballInitialPositionY);

    current = BallMovement.middle;
    sprites = { 
      BallMovement.middle: ballflat,
      BallMovement.left:ballflat,
  BallMovement.right: ballflat
    };
    add(CircleHitbox());
  }
  void jump({required PipePosition pipePosition}){
    add(
      MoveByEffect(Vector2((pipePosition== PipePosition.right? 1:-1) * gameRef.size.x/2, 0), EffectController(duration:0.2, curve: Curves.ease), onComplete: ()=> onCompleteJump(pipePosition: pipePosition))
    );
    ballHit = BallHit.movingToPipe;
    print('ball moving to pipe');
    current = BallMovement.middle;
  }

  void onCompleteJump({required PipePosition pipePosition}){
     if(ballHit == BallHit.movingToPipe){
      gameOver();
      return;
    }
    add(
      MoveByEffect(Vector2((pipePosition== PipePosition.right? -1 : 1) * gameRef.size.x/2 , 0), EffectController(duration:2, curve: Curves.easeOutExpo), onComplete: ()=> current = BallMovement.left)
    ); 
   
    ballHit = BallHit.movingBack;
    print('ball moving back');
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other
  ){
    super.onCollisionStart(intersectionPoints, other);
    ballHit = BallHit.hitted;
    print('ballhitted');
    print('colisao');
  }

  void reset(){
    position = Vector2(ballInitialPositionX , ballInitialPositionY);
  }
  
  void gameOver(){
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
  }

  @override
  void update(double dt){
    super.update(dt);
    // posti
  }
}