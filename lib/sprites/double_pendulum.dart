import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class DoublePendulum extends StatelessWidget {
  const DoublePendulum({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SceneBuilderWidget(
      builder: () => SceneController(
        back: _DoublePendulumSprite(),
      ),
    );
  }
}

class _DoublePendulumSprite extends Sprite {
  final s = 6.0;

  var cx = 0.0;
  var cy = 0.0;

  var m1 = 20.0;
  var m2 = 20.0;

  var x1 = 0.0;
  var y1 = 0.0;

  var x2 = 0.0;
  var y2 = 0.0;

  var l1 = 100.0;
  var l2 = 100.0;

  var a1 = 0.0;
  var a2 = 0.0;

  var a1V = 0.0;
  var a2V = 0.0;

  var a1A = 0.0;
  var a2A = 0.0;

  static const g = 1;

  Shape dot;

  Shape pendulum;

  @override
  void update(double delta) {
    super.update(delta);

    // calculateA1A();
    // calculateA2A();

    // x1 = l1 * sin(a1);
    // y1 = l1 * cos(a1);

    // x2 = x1 + l2 * sin(a2);
    // y2 = y1 + l2 * cos(a2);

    // pendulum.graphics.clear();

    // getLine(pendulum.graphics, 0.0, 0.0, x1, y1);
    // getCircle(pendulum.graphics, x1, y1);

    // getLine(pendulum.graphics, x1, y1, x2, y2);
    // getCircle(pendulum.graphics, x2, y2);

    // a1V += a1A;
    // a2V += a2A;

    // a1 += a1V;
    // a2 += a2V;
  }

  void getDot(Graphics g, double x2, double y2) {
    g
      ..beginFill(Colors.black.value)
      ..drawCircle(x2, y2, 2.0)
      ..endFill();
  }

  void calculateA1A() {
    final num1 = -g * (2 * m1 + m2) * sin(a1);
    final num2 = -m2 * g * sin(a1 - 2 * a2);
    final num3 = -2 * sin(a1 - a2) * m2;
    final num4 = a2V * a2V * l2 + a1V * a1V * l1 * cos(a1 - a2);
    final den = l1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
    a1A = (num1 + num2 + num3 * num4) / den;
  }

  void calculateA2A() {
    final num1 = 2 * sin(a1 - a2);
    final num2 = (a1V * a1V * l1 * (m1 + m2));
    final num3 = g * (m1 + m2) * cos(a1);
    final num4 = a2V * a2V * l2 * m2 * cos(a1 - a2);
    final den = l2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));
    a2A = (num1 * (num2 + num3 + num4)) / den;
  }

  @override
  void addedToStage() async {
    cx = stage.stageWidth / 2;
    cy = stage.stageHeight / 2;

    dot = Shape();
    pendulum = Shape();

    addChild(dot);

    addChild(pendulum);

    pendulum.y = cy / 2;
    pendulum.x = cx;
    
    dot.x = pendulum.x;
    dot.y = pendulum.y;


    x1 = l1 * sin(a1);
    y1 = l1 * cos(a1);

    x2 = x1 + l2 * sin(a2);
    y2 = y1 + l2 * cos(a2);


    getLine(pendulum.graphics, 0.0, 0.0, x1, y1);
    getCircle(pendulum.graphics, x1, y1);

    getLine(pendulum.graphics, x1, y1, x2, y2);
    getCircle(pendulum.graphics, x2, y2);

  }

  void getCircle(Graphics graphics, double toX, double toY) {
    graphics.beginFill(Colors.black.value).drawCircle(toX, toY, s).endFill();
  }

  void getLine(
      Graphics graphics, double fromX, double fromY, double toX, double toY) {
    graphics
        .lineStyle(
          2.0,
          Colors.black.value,
        )
        .moveTo(fromX, fromY)
        .lineTo(toX, toY)
        .endFill();
  }
}
