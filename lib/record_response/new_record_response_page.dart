import 'package:bloc_1/record_response/response_page_camera_bloc.dart';
import 'package:bloc_1/record_response/response_page_camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewRecordResponsePage extends StatefulWidget {
  final int index;

  const NewRecordResponsePage({Key? key, required this.index})
      : super(key: key);

  @override
  _NewRecordResponsePageState createState() => _NewRecordResponsePageState();
}

class _NewRecordResponsePageState extends State<NewRecordResponsePage>
    with WidgetsBindingObserver {
  int totalQuestions = 5;
  String firstHalf = "";
  String secondHalf = "";
  bool flag = true;

  final List<String> _questionList = [
    "Why do you want to leave (or have left) your current job?",
    "Tell me about a time when you received criticism from your manager. How did you react to that criticism? How did you make improvements based on that criticism? Also, Tell me about a time that you naturally took on a leadership role without being asked. Did you enjoy being a leader? Were you happy with the outcome? How did you make improvements based on that criticism?"
        "What is the difference between hard work and smart work?",
  ];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    if (_questionList[widget.index].length > 65) {
      if (kIsWeb && _questionList[widget.index].length > 300) {
        firstHalf = _questionList[widget.index].substring(0, 300);
        secondHalf = _questionList[widget.index]
            .substring(300, _questionList[widget.index].length);
      } else {
        firstHalf = _questionList[widget.index].substring(0, 65);
        secondHalf = _questionList[widget.index]
            .substring(65, _questionList[widget.index].length);
      }
    } else {
      firstHalf = _questionList[widget.index];
      secondHalf = "";
    }
  }

  var cameraBloc;

  @override
  void didChangeDependencies() {
    cameraBloc = BlocProvider.of<ResponsePageCameraBloc>(context);
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
    return Scaffold(
        appBar: AppBar(title: const Text("Response Page")),
        body: kIsWeb ? _web() : _mobile());
  }

  Widget _web() {
    return LayoutBuilder(builder: (context, constraints) {
      var maxHeight = constraints.maxHeight;
      var maxWidth = constraints.maxWidth;
      if (maxHeight > 500 && maxWidth > 500) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(color: Colors.black45)
              ),
              height: constraints.maxHeight * 0.85,
              width: constraints.maxWidth * 0.65,
              child: Column(
                children: [
                  SizedBox(
                      height: constraints.maxHeight * 0.65,
                      width: constraints.maxWidth * 0.65,
                      child: ResponsePageCameraScreen()),
                  SizedBox(
                      height: constraints.maxHeight * 0.20,
                      child: _questionPart()),
                ],
              ),
            ),
          ),
        );
      } else {
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    height: 300,
                    width: 400,
                    child: ResponsePageCameraScreen(),
                  ),
                  FittedBox(
                    child: Container(
                      height: 200,
                      width: 400,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _questionPart(),
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
      return SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Column(
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: _questionPart()),
            Expanded(child: ResponsePageCameraScreen()),
          ],
        ),
      );
    });
  }

  Widget _questionPart() {
    return SingleChildScrollView(
      child: Padding(
        padding: kIsWeb
            ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30)
            : const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Question ${widget.index + 1} of $totalQuestions",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            secondHalf.isEmpty
                ? Text(
                    firstHalf,
                    style: const TextStyle(color: Colors.black45, fontSize: 16),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                        // textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.black45, fontSize: 16),
                      ),
                      FittedBox(
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                flag ? "show more" : "show less",
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              flag = !flag;
                            });
                          },
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
