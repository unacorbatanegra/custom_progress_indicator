import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

import 'progress_indicator.dart';

void main() {
  runApp(
    MaterialApp(
      home: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress indicator'),
      ),
      body: Center(
        child: CustomProgressIndicator(),
      ),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SceneBuilderWidget(
      builder: () => SceneController(
        back: CustomProgressIndicatorSprite(),
      ),
    );
  }
}
