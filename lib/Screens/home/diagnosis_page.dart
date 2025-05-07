import 'package:flutter/material.dart';
import 'package:autism_detection/Screens/home/photo_upload_page.dart';
import 'package:autism_detection/Screens/Questions_pages/main_questions_page.dart';

class DiagnosisPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  DiagnosisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SingleChildScrollView( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                Image.asset(
                  "Photos/gradLogo1.png",
                  width: 400, 
                  height: 400,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(
                    hintText: 'اسم المريض',
                    hintStyle: TextStyle(
                      fontFamily: "Alexandria",
                      color: Color.fromARGB(255, 96, 96, 96),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: ageController,
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(
                    hintText: "السن",
                    hintStyle: TextStyle(
                      fontFamily: "Alexandria",
                      color: Color.fromARGB(255, 96, 96, 96),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 50), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '(اختياري)',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Alexandria",
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ImageUploadPage(); 
                          }),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 16), // تصغير حجم الزر
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'إضافة صورة',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Alexandria",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 30), // 🔹 استبدال Spacer بـ SizedBox
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return QuestionsPage(); // 🔹 إزالة الـ const
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue, // لون الزر الأزرق
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'التالي',
                    style: TextStyle(
                      fontFamily: "Alexandria",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
