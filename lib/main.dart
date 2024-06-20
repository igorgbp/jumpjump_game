import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jump_jump/game/jump_jump_game.dart';

void main() {
  final game = JumpJumpGame();
  runApp(GameWidget(game: game));
}
