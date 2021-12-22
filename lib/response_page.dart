import 'package:bloc_1/camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({Key? key}) : super(key: key);

  @override
  _ResponsePageState createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Response Page")),
        body: kIsWeb ? _web() : _mobile()
    );
  }

  Widget _web(){

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.redAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CameraScreen(),
            FittedBox(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _question(),
              ),
            )

          ],
        ),

      ),
    );

  }

  Widget _question(){
    return Text("Question");
  }

  Widget _mobile(){
    return Container();
  }
}
