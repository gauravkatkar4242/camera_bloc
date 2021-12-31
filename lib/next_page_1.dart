import 'package:bloc_1/record_response/record_response_page.dart';
import 'package:bloc_1/testing_camera/testing_page.dart';
import 'package:flutter/material.dart';

class NextPage1 extends StatefulWidget {
  const NextPage1({Key? key}) : super(key: key);

  @override
  State<NextPage1> createState() => _NextPage1State();
}

class _NextPage1State extends State<NextPage1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page 1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Next Page 1"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecordResponsePage(index: 1),
                    ));
              },
              child: Text("Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}
