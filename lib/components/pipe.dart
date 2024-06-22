import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:jump_jump/game/assets.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/game/pipe_position.dart';

class Pipe extends SpriteComponent with HasGameRef<JumpJumpGame>{
  Pipe({
    required this.pipePosition,
    required this.height
  });

  @override
  final double height; 
  final PipePosition pipePosition;
  
  @override
  Future<void> onLoad() async{
   final pipe = await Flame.images.load(Assets.pipe);
   size = Vector2(10, height);
   switch(pipePosition){
    case PipePosition.left:
      position.x = 0;
      break;
    case PipePosition.right:
      position.x = gameRef.size.x -size.x;
      break;
 
   }
      // position.rotate(60);

   sprite = Sprite(pipe);

  add(RectangleHitbox());

  }
}