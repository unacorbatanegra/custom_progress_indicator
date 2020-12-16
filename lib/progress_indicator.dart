import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class CustomProgressIndicatorSprite extends Sprite {
  Shape fillSquare;
  Sprite corners;

  double lineSize = 12.5;

  static const expandTo = 60.0;
  static const colapseTo = 45.0;

  final _currentCornerSize = colapseTo.twn;

  double counter = 0.0;

  @override
  void addedToStage() {
    x = stage.stageWidth / 2;
    y = stage.stageHeight / 2;

    fillSquare = Shape();
    corners = Sprite();

    fillSquare.graphics
        .beginFill(Colors.black.value)
        .drawRect(0, 0, 40, 40)
        .endFill();

    fillSquare.alignPivot();

    rotation = deg2rad(45);

    addChild(fillSquare);

    addChild(corners);

    List.generate(
      4,
      (index) {
        final corner = Shape();
        corner.graphics
            .lineStyle(
              3.0,
              Colors.black.value,
            )
            .moveTo(0, lineSize)
            .lineTo(0, 0)
            .lineTo(lineSize, 0);

        corners.addChild(corner);
      },
    );
    positionCorners();
    orientCorners();
    startAnimation();
  }

  void startAnimation() {
    expandCorners(true);
  }

  void rotateCorners() {
    corners.tween(
      duration: .5,
      rotation: deg2rad(90).toString(),
      onComplete: () => expandCorners(false),
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

  void expandCorners(bool open) {
    _currentCornerSize.tween(
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

  void orientCorners() {
    corners.children[1].scaleX = -1;

    corners.children[2].scaleY = -1;
    corners.children[2].scaleX = -1;

    corners.children[3].scaleY = -1;
  }

  double get currentSize => _currentCornerSize.value;
}
