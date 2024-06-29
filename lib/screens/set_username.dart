import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jump_jump/game/jump_jump_game.dart';
import 'package:jump_jump/models/record.dart';
import 'package:jump_jump/models/user.dart';
import 'package:jump_jump/services/points.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUsernameScreen extends StatefulWidget {
  final JumpJumpGame game;
  static const String id = 'set_username';
  const SetUsernameScreen({Key? key, required this.game}) : super(key: key);

  @override
  State<SetUsernameScreen> createState() => _SetUsernameScreenState();
}

class _SetUsernameScreenState extends State<SetUsernameScreen> {
  bool isInstagram = false;
  bool saveEnable = false;
  final TextEditingController _usernameController = TextEditingController();
  @override
  void initState() {
    print('dentro do set username');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
              child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8),
                   child: const Text(
                      'Digite seu username',
                      style: TextStyle(
                          color: Color.fromRGBO(194, 134, 209, 1),
                          fontFamily: 'Mighty',
                          fontSize: 24),
                    ),
                 ),
                  TextField(
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    onChanged: (value) => setState(() {
                      saveEnable = value.length > 2;
                    }),
                    decoration: const InputDecoration(
                        hintText: 'Crie um nome ou seu user do instagram',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.3),
                            fontSize: 14),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(194, 134, 209, 1),
                              width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(108, 72, 120, 1), width: 1),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TextField(controller: _usernameController),
                      Checkbox(
                        activeColor: Color.fromRGBO(194, 134, 209, 1),
                        checkColor: Colors.black,
                        shape: CircleBorder(),
                        value: isInstagram,
                        onChanged: (value) {
                          setState(() {
                            isInstagram = value == true;
                          });
                        },
                      ),
                      const Text('Este é o meu Instagram',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  Center(
                    child: InkWell(
                        onTap: () => saveEnable ? _back() : null,
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: saveEnable
                                    ? Color.fromRGBO(213, 159, 227, 1)
                                    : Color.fromRGBO(213, 159, 227, 0.5)),
                            child: Text(
                              'salvar',
                              style: TextStyle(
                                  fontFamily: 'Mighty',
                                  fontSize: 20,
                                  color: Colors.white),
                            ))),
                  )
                ]),
          ))
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //   const Text('Escreva seu nome de usuário', style: TextStyle(fontFamily: 'Mighty', color: Color.fromARGB(255, 10, 4, 4), fontSize: 20),),
          //   TextField(controller: _usernameController),
          // //   Row(
          // //   mainAxisAlignment: MainAxisAlignment.center,
          // //   children: [
          // //   Checkbox(
          // //     activeColor: Colors.blue,
          // //     checkColor: Colors.black,
          // //     shape: CircleBorder(),
          // //     value: isInstagram, onChanged: (value) {
          // //     setState(() {
          // //       isInstagram = value == true;
          // //     });
          // //   },),
          // //  const  Text('Este é o meu Instagram', style: TextStyle( color: Colors.white, fontSize: 16)),
          // //   ],),
          //   ElevatedButton(onPressed: ()=> _back(), child: const Text('salvar'))

          // ],),
          ),
    );
  }

  void _back() {
    GameService().setUser(
        user:
            User(username: _usernameController.text, isInstagram: isInstagram));
    widget.game.overlays.remove('set_username');
    // widget.game.resumeEngine();
  }
}
