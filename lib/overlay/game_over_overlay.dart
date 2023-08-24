import 'package:flutter/material.dart';
import '../game_status.dart';
import '../bounce_game.dart';

class GameOverOverlay extends StatelessWidget {
  final BounceGame game;

  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        color: const Color.fromRGBO(10, 10, 10, 0.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/in_game/gameover_title.png',
              fit: BoxFit.contain,
              scale: 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Global.status = GameStatus.ready;
                    game.eventGameStatus();
                  },
                  child: Image.asset(
                    'assets/images/in_game/again_button.png',
                    fit: BoxFit.fill,
                    scale: 1.8,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Global.status = GameStatus.ready;
                    game.eventGameStatus();
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/in_game/go_title_button.png',
                    fit: BoxFit.fill,
                    scale: 1.8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
