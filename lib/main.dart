import 'package:bloc_1/record_response/response_page_camera_screen.dart';
import 'package:bloc_1/record_response/record_response_page.dart';
import 'package:bloc_1/testing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'record_response/response_page_camera_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ResponsePageCameraBloc>(
          create: (BuildContext context) => ResponsePageCameraBloc(),
        ),
      ],
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecordResponsePage(index: 0),
      //   home: TestingPage(),
      ),
    );
  }
}
