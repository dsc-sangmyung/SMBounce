import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:sm_bounce/game_status.dart';

class GamePlayer extends SpriteComponent with HasGameRef, TapCallbacks, CollisionCallbacks {
  GamePlayer()
      : super(
          size: Vector2.all(160),
          position: Vector2(250, 290),
          anchor: Anchor.center,
        );
  late Sprite run;
  late Sprite jump;

  final Vector2 _velocity = Vector2.zero();

  final double _gravity = 15;
  final double _jumpSpeed = 600;
  final double _dropSpeed = 600;

  bool hasJumped = false;
  bool isOnGround = false;

  @override
  Future<void> onLoad() async {
    run = await Sprite.load('in_game/char_run.png');
    jump = await Sprite.load('in_game/char_jump.png');

    sprite = run;
    add(RectangleHitbox(
      size: Vector2(62, 80),
      position: Vector2(40, 40),
    ));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    reloadSprite();

    // 중력 설정
    _velocity.y += _gravity;

    // 상승 속도 조절
    if (hasJumped) {
      if (isOnGround) {
        _velocity.y = -_jumpSpeed - Global.gameSpeed;
        isOnGround = false;
      }
      hasJumped = false;
    }

    // 하강 속도 조절
    _velocity.y = _velocity.y.clamp(-_jumpSpeed, _dropSpeed + Global.gameSpeed);
    position += _velocity * dt;

    // Player의 y축 제한 설정
    position.y = position.y.clamp(0, 290);

    super.update(dt);
  }

  void reloadSprite() {
    // y축 위치에 따른 Sprite 변경
    if (position.y < 290) {
      sprite = jump;
    } else {
      sprite = run;
    }
  }

  void reset() {
    // 위치 초기화
    position = Vector2(250, 290);
    hasJumped = false;
    isOnGround = false;
  }
}
