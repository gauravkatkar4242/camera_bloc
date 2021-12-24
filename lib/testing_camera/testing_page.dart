import 'package:bloc_1/testing_camera/testing_page_camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({Key? key}) : super(key: key);

  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text("Testing Page")),
        body: kIsWeb ? _web() : _mobile());
  }

  Widget _web() {
    return LayoutBuilder(builder: (context, constraints) {
      var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      return Container(
        height: maxHeight,
        width: maxWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: maxHeight * 0.7,
              width: maxWidth * 0.6,
              child: TestingPageCameraScreen(),
            ),
            FittedBox(
              child: Container(
                width: maxWidth * 0.3,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _mainTextContent(),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _mobile() {
    return LayoutBuilder(builder: (context, constraints) {
      var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      return Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: maxWidth * 0.9,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: _mainTextContent(),
            ),
            Expanded(child: TestingPageCameraScreen()),
          ],
        ),
      );
    });
  }

  Widget _mainTextContent() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Test your camera & microphone",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Speak this phrase out loud while recording the practice video: 'Two blue fish swam in the tank.'",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ]),
    );
  }
}
