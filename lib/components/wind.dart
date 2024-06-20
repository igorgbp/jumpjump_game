import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:jump_jump/game/assets.dart';
import 'package:jump_jump/game/configuration.dart';
import 'package:jump_jump/game/jump_jump_game.dart';

class Wind extends ParallaxComponent<JumpJumpGame> {
  Wind();

  @override
  Future<void> onLoad() async {
    final wind = await Flame.images.load(Assets.wind);
    parallax =
        Parallax([ParallaxLayer(ParallaxImage(wind, fill: LayerFill.none))]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}
