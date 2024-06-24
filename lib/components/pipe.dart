import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:jump_jump/game/assets.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/game/pipe_position.dart';

class Pipe extends SpriteComponent
    with HasGameRef<JumpJumpGame>, CollisionCallbacks {
  Pipe({required this.pipePosition, required this.height});

  @override
  final double height;
  final PipePosition pipePosition;
  bool decreaseSize = false;

  @override
  Future<void> onLoad() async {
    final pipes = [
      Assets.pipea,
      Assets.pipeb,
      Assets.pipec,
      Assets.piped,
      Assets.pipee
    ];
    final pipeIndex = Random().nextInt(4);

    final pipe = await Flame.images.load(pipes[pipeIndex]);
    size = Vector2(50, 50);
    switch (pipePosition) {
      case PipePosition.left:
        position.x = size.x / 2 + 10;
        break;
      case PipePosition.right:
        position.x = gameRef.size.x - size.x / 2 - 10;
        break;
    }

    // position.rotate(60);

    sprite = Sprite(pipe);

    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
      decreaseSize = true;
      
    
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (decreaseSize) {
      size.x = size.x - 7;
      size.y = size.y - 7;
    }
    // angle = angle +0.02;
    // print(position.x);
    super.update(dt);

    // posti
  }
}
