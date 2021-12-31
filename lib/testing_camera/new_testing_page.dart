import 'package:bloc_1/testing_camera/testing_page_camera_bloc.dart';
import 'package:bloc_1/testing_camera/testing_page_camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTestingPage extends StatefulWidget {
  const NewTestingPage({Key? key}) : super(key: key);

  @override
  _NewTestingPageState createState() => _NewTestingPageState();
}

class _NewTestingPageState extends State<NewTestingPage> with WidgetsBindingObserver {
  var cameraBloc;

  @override
  void didChangeDependencies() {
    cameraBloc = BlocProvider.of<TestingPageCameraBloc>(context);
    cameraBloc.add(InitializingControllerEvent());
    WidgetsBinding.instance!.addObserver(this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    cameraBloc.add(DisposeCameraEvent());
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: kIsWeb ? _web() : _mobile());
  }

  Widget _web() {
    return LayoutBuilder(builder: (context, constraints) {
      var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      if (maxHeight > 400 && maxWidth > 500) {
        return SizedBox(
          height: maxHeight,
          width: maxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: maxHeight * 0.7,
                width:  maxWidth * 0.6,
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
      } else {
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                    height: 300,
                    width: 280,
                    child: TestingPageCameraScreen(),
                  ),
                  FittedBox(
                    child: Container(
                      width: 180,
                      height: 300,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _mainTextContent(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
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
