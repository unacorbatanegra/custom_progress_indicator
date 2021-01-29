import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SceneBuilderWidget(
      builder: () => SceneController(back: CustomLoadingIndicatorSprite()),
    );
  }
}

class CustomLoadingIndicatorSprite extends Sprite {
  Shape fillSquare;
  Sprite corners;

  static const expandTo = 60.0;
  static const colapseTo = 45.0;

  double lineSize = 12.5;

  final _currentSizeCorner = colapseTo.twn;
  // @override
  void addedToStage() {
    corners = Sprite();
    addChild(corners);
    List.generate(
      4,
      (index) {
        final corner = Shape();
        corner.graphics
            .lineStyle(3.0, Colors.black.value)
            .moveTo(0.0, lineSize)
            .lineTo(0.0, 0.0)
            .lineTo(lineSize, 0);

        corners.addChild(corner);
      },
    );
    x = stage.stageWidth / 2;
    y = stage.stageHeight / 2;
    positionCorners();
    getSquare();
    orientCorners();
    rotation = deg2rad(45);
    expandCorners(true);
  }

  void rotateCorners() {
    corners.tween(
      duration: .5,
      rotation: deg2rad(90).toString(),
      onComplete: () => expandCorners(false),
    );
  }

  void expandCorners(bool open) {
    _currentSizeCorner.tween(
      open ? expandTo : colapseTo,
      duration: .5,
      onUpdate: positionCorners,
      onComplete: () {
        if (open) {
          rotateCorners();
        } else {
          expandCorners(true);
        }
      },
    );
  }

  void positionCorners() {
    final size = currentSize / 2;

    corners.children[0].x = -size;
    corners.children[0].y = -size;

    corners.children[1].x = size;
    corners.children[1].y = -size;

    corners.children[2].x = size;
    corners.children[2].y = size;

    corners.children[3].x = -size;
    corners.children[3].y = size;
  }

  void orientCorners() {
    corners.children[1].scaleX = -1;

    corners.children[2].scaleX = -1;
    corners.children[2].scaleY = -1;

    corners.children[3].scaleY = -1;
  }

  void getSquare() {
    fillSquare = Shape();
    fillSquare.graphics
        .beginFill(
          Colors.black.value,
        )
        .drawRect(0.0, 0.0, 40, 40);
    fillSquare.alignPivot();
    addChild(fillSquare);
  }

  double get currentSize => _currentSizeCorner.value;
}
