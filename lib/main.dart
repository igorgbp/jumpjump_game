import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/screens/game_over_screen.dart';
import 'package:jump_jump/screens/main_menu_screen.dart';

void main() {
  final game = JumpJumpGame();
  runApp(GameWidget(game: game,
  initialActiveOverlays: const [MainMenuScreen.id],
  overlayBuilderMap: {
    'mainMenu':(context, _) => MainMenuScreen(game: game),
    'gameOver':(context, _) => GameOverScreen(game: game),

  },));
}
