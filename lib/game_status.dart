import 'package:flame/components.dart';

enum GameStatus { ready, pause, run, gameover }

class Global extends Component with HasGameRef {
  static double deviceWidth = 0;
  static double deviceHeight = 0;

  static GameStatus status = GameStatus.ready;
  static int level = 1;
  static double gameSpeed = 10;
  static double score = 0;
}
