import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jump_jump/firebase_options.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/screens/game_over_screen.dart';
import 'package:jump_jump/screens/main_menu_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jump_jump/screens/set_username.dart';
import 'firebase_options.dart';

void main() async {
  final game = JumpJumpGame();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GameWidget(game: game,
  initialActiveOverlays: const [MainMenuScreen.id],
  overlayBuilderMap: {
    'mainMenu':(context, _) => MainMenuScreen(game: game),
    'gameOver':(context, _) => GameOverScreen(game: game),
    'set_username': (context, _) => SetUsernameScreen(game: game),
  },));
}


Future<void> initializeFirebase()async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
