import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'game/world.dart';
import 'game/sprites/player.dart';
import 'overlay/score_board_overlay.dart';
import 'game_status.dart';

class BounceGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  final _world = GameWorld();
  final _player = GamePlayer();
  final _scoreBoard = ScoreBoard();

  @override
  Future<void> onLoad() async {
    add(_world);
    add(_player);
    add(_scoreBoard);
  }

  void reset() {
    Global.level = 1;
    Global.gameSpeed = 10;
    Global.score = 0;
  }

  void eventGameStatus() {
    GameStatus status = Global.status;
    switch (status) {
      case GameStatus.ready:
        overlays.remove('GameOverOverlay');
        reset();
        _player.reset();
        _world.reset();
        overlays.add('ReadyOverlay');
        break;
      case GameStatus.run:
        overlays.removeAll(['ReadyOverlay', 'PauseOverlay']);
        overlays.add('PauseButton');
        resumeEngine();
        break;
      case GameStatus.pause:
        pauseEngine();
        overlays.remove('PauseButton');
        overlays.add('PauseOverlay');
        break;
      case GameStatus.gameover:
        overlays.remove('PauseButton');
        overlays.add('GameOverOverlay');
        break;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    if (!_player.hasJumped && _player.position.y >= 290) {
      _player.hasJumped = true;
      _player.isOnGround = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    levelUp();
  }

  void levelUp() {
    switch (Global.score) {
      case == 20000:
        Global.level++;
        Global.gameSpeed += 100;
        _world.parallax?.baseVelocity.x += 3.7;
        break;
      case == 15000:
        Global.level++;
        Global.gameSpeed += 100;
        _world.parallax?.baseVelocity.x += 3.7;
        break;
      case == 10000:
        Global.level++;
        Global.gameSpeed += 100;
        _world.parallax?.baseVelocity.x += 3.9;
        break;
      case == 5000:
        Global.level++;
        Global.gameSpeed += 100;
        _world.parallax?.baseVelocity.x += 4.1;
        break;
      case == 1000:
        Global.level++;
        Global.gameSpeed += 100;
        _world.parallax?.baseVelocity.x += 3.9;
        break;
    }
  }
}
