import 'package:flutter/material.dart';
import '../game_status.dart';
import '../bounce_game.dart';

class ReadyOverlay extends StatelessWidget {
  final BounceGame game;

  const ReadyOverlay({super.key, required this.game});

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
              'assets/images/in_game/ready_title.png',
              fit: BoxFit.contain,
              scale: 1.5,
            ),
            InkWell(
              onTap: () {
                Global.status = GameStatus.run;
                game.eventGameStatus();
              },
              child: Image.asset(
                'assets/images/in_game/go_button.png',
                fit: BoxFit.fill,
                scale: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
