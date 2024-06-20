import 'package:flame/game.dart';
import 'package:jump_jump/components/background.dart';
import 'package:jump_jump/components/wind.dart';

class JumpJumpGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    addAll([Background(), Wind()]);
  }
}
