import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'player.dart';
import '../world.dart';
import '../../game_status.dart';


class GameObject extends SpriteComponent with HasGameRef, CollisionCallbacks {
  GameObject(position)
      : super(
          size: Vector2.all(50),
          position: position,
          anchor: Anchor.center,
        );
  late Sprite trap;
  final Vector2 _velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    trap = await gameRef.loadSprite('in_game/trap.png');
    sprite = trap;
    add(RectangleHitbox(
      size: Vector2.all(30),
      position: Vector2.all(10),
    ));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // Object 이동
    _velocity.x = -Global.gameSpeed - 240;
    position += _velocity * dt;

    // Object가 World 밖으로 나갈 시 제거
    if (position.x <= -10) {
      removeFromParent();
      GameWorld.objectList.removeAt(0);
    }

    super.update(dt);
  }

  @override
  bool onComponentTypeCheck(PositionComponent other) {
    // Object HitBox에 닿는 Component의 type을 반환
    if (other is GameObject) {
      return false;
    } else {
      return super.onComponentTypeCheck(other);
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    // Object에 무언가 닿았을 경우 처리
    if (other is GamePlayer) {
      // (1) Object에 Player가 닿았을 경우
      game.pauseEngine();
      Global.status = GameStatus.gameover;
      game.overlays.remove('PauseButton');
      game.overlays.add('GameOverOverlay');
    } else {
      // (2) 그 이외의 것이 닿았을 경우
      super.onCollisionStart(intersectionPoints, other);
    }
  }
}
