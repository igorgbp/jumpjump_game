import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:jump_jump/game/assets.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/game/pipe_position.dart';

class ShadowPipe extends SpriteComponent with HasGameRef<JumpJumpGame>{
  ShadowPipe({
    required this.pipePosition,
    required this.height
  });

  @override
  final double height; 
  final PipePosition pipePosition;
   bool decreaseSize = false;
  
  @override
  Future<void> onLoad() async{
   final pipe = await Flame.images.load(Assets.pipeShadow);
   size = Vector2(50, 50);
   switch(pipePosition){
    case PipePosition.left:
      position.x = size.x /2 + 10;
      break;
    case PipePosition.right:
      position.x = gameRef.size.x - size.x /2 -10;
      break;
 
   }
      // position.rotate(60);
  
   sprite = Sprite(pipe);
   anchor = Anchor.center;


}}