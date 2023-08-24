import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

import '../game/sprites/object.dart';
import '../game_status.dart';

class GameWorld extends ParallaxComponent {
  double nextSpawn = 3; // default spawn time of Object
  double sumToScore = 0; // Score
  static List<GameObject> objectList = []; // List of Objects

  @override
  Future<void> onLoad() async {
    super.onLoad();
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('in_game/sky.png'),
        ParallaxImageData('in_game/ground.png'),
      ],
      fill: LayerFill.height,
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(5, 0),
    );
  }

  @override
  void update(double dt) {
    // ready 상태일 시, Component load만 수행하고 나머지는 작동 X
    if (Global.status == GameStatus.ready) {
      return;
    }

    // dt: 시간 차
    // 시간 차를 이용한 신규 Object 생성
    nextSpawn -= dt;

    if (nextSpawn < 0) {
      GameObject obj = GameObject(Vector2(size.x + 10, 325));

      add(obj); // 게임 내에 Object 생성
      objectList.add(obj); // World 내부에 있는 Objects 목록

      nextSpawn = Random().nextDouble() * (5 - 0.3 * (Global.level-1)); // nwe object spawned at random time
    }

    // 시간 차를 이용한 점수 계산
    sumToScore += dt;
    if (sumToScore > 1) {
      Global.score += 5;
      sumToScore = 1;
    }

    super.update(dt);
  }

  void reset() {
    // 게임 내 Object 초기화
    for (var element in objectList) {
      element.removeFromParent();
    }
    objectList.clear();

    // World baseVelocity 초기화
    parallax?.baseVelocity.x = 10;
  }
}
