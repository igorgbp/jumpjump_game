import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:jump_jump/game/assets.dart';
import 'package:jump_jump/game/configuration.dart';
import 'package:jump_jump/game/jump_jump_game.dart';

class Wind extends ParallaxComponent<JumpJumpGame> with HasGameRef<JumpJumpGame> {
  Wind();

  @override
  Future<void> onLoad() async {
    final wind = await Flame.images.load(Assets.wind);
    parallax =
        Parallax([ParallaxLayer(ParallaxImage(wind, fill: LayerFill.width, repeat: ImageRepeat.repeatY))]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.y = gameRef.velocityIncreaser * Config.gameSpeed/2;
  }
}
