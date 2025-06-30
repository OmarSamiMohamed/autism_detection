import 'package:autism_detection/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepetitiveBehaviorsPage extends StatefulWidget {
  const RepetitiveBehaviorsPage({super.key});

  @override
  _RepetitiveBehaviorsPageState createState() =>
      _RepetitiveBehaviorsPageState();
}

class _RepetitiveBehaviorsPageState extends State<RepetitiveBehaviorsPage> {
  List<int?> selectedAnswers = List.filled(6, null);
  bool isLoading = false;

  final List<String> questions = [
    "هل ينشغل الطفل بلعبة معينة ويترك باقي الألعاب؟",
    "هل يستخدم الطفل الألعاب بطريقة نمطية بصورة متكررة؟",
    "هل يصدر الطفل أصواتًا حادة؟",
    "هل يقوم الطفل بالرفرفة بيده إلى الأمام أو الجانبين؟",
    "هل يستمر الطفل بعمل سلوكيات محددة إذا ترك بمفرده؟",
    "هل يتبع الطفل سلوكيات بطقوس معينة؟",
  ];

  final List<Map<String, Object>> answerOptions = [
    {"answer": "نعم", "value": 3},
    {"answer": "أحيانًا", "value": 2},
    {"answer": "نادرًا", "value": 1},
    {"answer": "لا", "value": 0},
  ];

  void handleAnswer(int index, int value) {
    setState(() {
      selectedAnswers[index] = value;
    });
  }

  Future<void> submitAnswers() async {
    if (selectedAnswers.contains(null)) {
      Fluttertoast.showToast(
        msg: "رجاءً أجب على جميع الأسئلة قبل الإرسال.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final childId = prefs.getString('child_id');

    if (token == null || childId == null) {
      Fluttertoast.showToast(
        msg: "الرجاء تسجيل الدخول أولاً.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      Navigator.pushNamed(context, '/login');
      return;
    }

    try {
      setState(() => isLoading = true);

      final result = await ApiService.submitCategoryAnswers(
        token: token,
        childId: childId,
        categoryId: 1, // ← رقم فئة السلوكيات التكرارية
        answers: selectedAnswers.cast<int>(),
      );

      if (result != null) {
        Navigator.pushNamed(
          context,
          '/categorytwo',
          arguments: result,
        );
      } else {
        Fluttertoast.showToast(
          msg: "حدث خطأ أثناء إرسال الإجابات.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = 32;
    final double spacing = 8;
    final int optionsCount = answerOptions.length;
    final double buttonWidth =
        (screenWidth - horizontalPadding - (optionsCount - 1) * spacing) /
            optionsCount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'السلوكيات التكرارية أو المقيدة',
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: questions.length + 1,
                itemBuilder: (context, index) {
                  if (index == questions.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton(
                        onPressed: isLoading ? null : submitAnswers,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'إرسال',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          questions[index],
                          style: const TextStyle(
                            fontFamily: 'Alexandria',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: answerOptions.reversed.map((option) {
                            final isSelected =
                                selectedAnswers[index] == option['value'];
                            return SizedBox(
                              width: buttonWidth,
                              child: OutlinedButton(
                                onPressed: () {
                                  handleAnswer(index, option['value'] as int);
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  side: BorderSide(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade400,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Text(
                                  option['answer'] as String,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Alexandria',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
