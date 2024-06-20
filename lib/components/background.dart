import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:jump_jump/game/assets.dart';
import 'package:jump_jump/game/jump_jump_game.dart';

class Background extends SpriteComponent with HasGameRef<JumpJumpGame> {
  Background();
  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
