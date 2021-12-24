import 'package:bloc_1/record_response/response_page_camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordResponsePage extends StatefulWidget {
  final int index;

  const RecordResponsePage({Key? key, required this.index}) : super(key: key);

  @override
  _RecordResponsePageState createState() => _RecordResponsePageState();
}

class _RecordResponsePageState extends State<RecordResponsePage> {
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
      if(kIsWeb && _questionList[widget.index].length > 300){
        firstHalf = _questionList[widget.index].substring(0, 300);
        secondHalf = _questionList[widget.index]
            .substring(300, _questionList[widget.index].length);
      }
      else {
        firstHalf = _questionList[widget.index].substring(0, 65);
        secondHalf = _questionList[widget.index]
            .substring(65, _questionList[widget.index].length);
      }
    } else {
      firstHalf = _questionList[widget.index];
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text("Response Page")),
        body: kIsWeb ? _web() : _mobile()
        // LayoutBuilder(builder: (context, constraints){
        //   if (constraints.maxWidth > constraints.maxHeight){
        //     return _web() ;
        //   }
        //   else{
        //   return _mobile();
        //   }
        // })
    );
  }

  Widget _mobile() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: _questionPart()),
              Expanded(child: ResponsePageCameraScreen()),
            ],
          ),
        );
      }
    );
  }

  Widget _web() {
    return LayoutBuilder(
      builder: (context, constraints) {
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
      }
    );
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
