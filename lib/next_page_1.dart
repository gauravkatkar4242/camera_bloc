import 'package:bloc_1/camera_screen.dart';
import 'package:bloc_1/testing_page.dart';
import 'package:flutter/material.dart';

class NextPage1 extends StatelessWidget {

  const NextPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Page 1"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Next Page 1"),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => TestingPage(),)
                );
              },
              child: Text("Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}
