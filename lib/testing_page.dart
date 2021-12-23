import 'package:bloc_1/record_response/response_page_camera_screen.dart';
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
      appBar: AppBar(title: const Text("Testing Page")),
      body: kIsWeb ? _web() : _mobile()
    );
  }

  Widget _web(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: ResponsePageCameraScreen(),
          ),
          FittedBox(
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _mainTextContent(),
            ),
          )
        ],
      ),
    );
  }

  Widget _mobile(){
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FittedBox(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.2,
              padding: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              child: _mainTextContent(),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ResponsePageCameraScreen()),
        ],
      ),
    );

  }

  Widget _mainTextContent() {
    return Container(
      // margin: const EdgeInsets.only(top: 40.0, bottom: 24, left: 24, right: 24),
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
              "Speak this phrase out loud while recording the practice video: Two blue fish swam in the tank",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )
          ]),
    );
  }
}
