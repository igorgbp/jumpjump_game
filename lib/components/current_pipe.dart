import 'dart:math';

import 'package:flame/components.dart';
import 'package:jump_jump/components/pipe.dart';
import 'package:jump_jump/game/configuration.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/game/pipe_position.dart';

class CurrentPipe extends PositionComponent with HasGameRef<JumpJumpGame>{
  CurrentPipe({required this.pipePosition });
  PipePosition pipePosition;
  @override
  Future<void> onLoad() async {
    // position.y = gameRef.size.y-size.y;
    position.y = -gameRef.size.y;
    // addAll([
    //   Pipe(pipePosition: PipePosition.right, height: Random().nextInt(400)/5),
    //   Pipe(pipePosition: PipePosition.left, height:  Random().nextInt(400)/5),
    // ]);
    final heightg = Random().nextInt(100) + 50 / 2*2;
    add(Pipe(pipePosition: pipePosition, height: heightg));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= Config.gameSpeed * dt;
  }
}