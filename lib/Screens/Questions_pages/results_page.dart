import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  bool isLoading = true;
  String? diagnosisResult;
  String? diagnosisDetails;
  int? totalScore;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final childId = prefs.getString('child_id');

    if (token == null || childId == null) {
      Fluttertoast.showToast(
        msg: "لا يوجد رمز توثيق، الرجاء تسجيل الدخول.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      Navigator.pushNamed(context, '/login');
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://snowboard-phones-imagine-kitchen.trycloudflare.com/api/child/diagnosis/$childId'),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          diagnosisResult = data['diagnosis'] ?? 'غير متوفر';
          diagnosisDetails = data['details'] ?? 'لا توجد تفاصيل إضافية';
          totalScore = data['total_score'];
          isLoading = false;
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
          msg: "انتهت صلاحية الجلسة، الرجاء تسجيل الدخول مجددًا.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        Navigator.pushNamed(context, '/login');
        setState(() => isLoading = false);
      } else {
        Fluttertoast.showToast(
          msg: "حدث خطأ أثناء جلب النتائج.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        setState(() => isLoading = false);
      }
    } catch (error) {
      print("Error: $error");
      Fluttertoast.showToast(
        msg: "حدث خطأ أثناء جلب النتائج.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/diagnosticbackground.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.15),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  'نتيجة التشخيص',
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
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'النتيجة: $diagnosisResult',
                                    style: const TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  if (totalScore != null)
                                    Text(
                                      'الدرجة الكلية: $totalScore',
                                      style: const TextStyle(
                                        fontFamily: 'Alexandria',
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  const SizedBox(height: 12),
                                  Text(
                                    diagnosisDetails!,
                                    style: const TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/questions',
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'العودة للصفحة الرئيسية',
                                style: TextStyle(
                                  fontFamily: 'Alexandria',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
