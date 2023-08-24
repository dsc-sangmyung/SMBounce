import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../bounce_game.dart';
import '../game_status.dart';

class ScoreBoard extends PositionComponent with HasGameRef<BounceGame> {
  late TextComponent _scoreTextComponent;

  @override
  Future<void> onLoad() async {
    _scoreTextComponent = TextComponent(
        text: 'Score: ${Global.score}',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        position: Vector2.all(20),
    );
    add(_scoreTextComponent);
  }

  @override
  void update(double dt) {
    _scoreTextComponent.text = 'Score: ${Global.score.ceil()}';
  }
}
