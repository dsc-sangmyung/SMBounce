import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';

import 'overlay/ready_overlay.dart';
import 'overlay/game_over_overlay.dart';
import 'overlay/pause_overlay.dart';
import 'bounce_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      // 화면 회전
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(
        // 화면 로테이션이 가능한 풀스크린
        SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]); // 화면 회전 취소
    SystemChrome.setEnabledSystemUIMode(
      // 풀스크린 해제
      SystemUiMode.edgeToEdge,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sangmyung Bounce',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_title/background_2.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/main_title/logo.png',
              fit: BoxFit.contain,
              scale: 4.2,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 45),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InGame())),
              child: Image.asset(
                'assets/images/main_title/start_button.png',
                fit: BoxFit.fill,
                scale: 4.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InGame extends StatefulWidget {
  const InGame({super.key});

  @override
  State<InGame> createState() => _InGameState();
}

class _InGameState extends State<InGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<BounceGame>(
        game: BounceGame(),
        overlayBuilderMap: {
          'ReadyOverlay': (_, game) => ReadyOverlay(game: game),
          'PauseOverlay': (_, game) => PauseOverlay(game: game),
          'PauseButton': (_, game) => PauseButton(game: game),
          'GameOverOverlay': (_, game) => GameOverOverlay(game: game),
        },
        initialActiveOverlays: const [
          'ReadyOverlay',
        ],
      ),
    );
  }
}
