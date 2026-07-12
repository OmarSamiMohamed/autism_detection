import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/app_router.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  List<int?> selectedAnswers = List.filled(6, null);
  bool isLoading = false;

  final List<String> questions = [
    "هل يقوم الطفل بترديد الكلام بشكل متكرر؟",
    "هل تلاحظ أن الطفل لا يفهم كثير من الكلمات عند الحديث معه؟",
    "هل تلاحظ أن الطفل لا يستطيع فهم المغزى من الحديث أو استيعاب نوايا المتحدث؟",
    "هل يستطيع الطفل إبداء تعبيرات وجهية تعكس مشاعره؟",
    "هل تلاحظ أن الطفل لا ينتظر دوره في الحديث ويقاطع الكلام أحياناً؟",
    "هل يستطيع الطفل فهم تعبيرات الوجه لدى الأشخاص؟",
  ];

  final List<Map<String, dynamic>> answerOptions = [
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
      return;
    }

    try {
      setState(() => isLoading = true);
      await Future.delayed(const Duration(seconds: 1));

      Fluttertoast.showToast(
        msg: "✅ تم إرسال الإجابات بنجاح!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRouter.selfCare);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "⚠️ خطأ أثناء الإرسال: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int optionsCount = answerOptions.length;
    final double buttonWidth = (screenWidth - 64) / optionsCount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'التواصل اللفظي وغير لفظي',
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
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'التالي',
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
                              width: buttonWidth - 8,
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
                                  option['answer'],
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
