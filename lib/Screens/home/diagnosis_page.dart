import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:autism_detection/Screens/Questions_pages/main_questions_page.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({super.key});

  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? selectedGender;
  File? selectedImage;
  bool isPickingImage = false;
  bool isSubmitting = false;
  String? nameError;
  String? ageError;

  Future<void> pickImage() async {
    setState(() => isPickingImage = true);
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          selectedImage = File(pickedImage.path);
        });
      }
    } finally {
      setState(() => isPickingImage = false);
    }
  }

  void removeImage() {
    setState(() {
      selectedImage = null;
    });
  }

  bool validateInputs() {
    setState(() {
      nameError = nameController.text.trim().isEmpty ? 'الرجاء إدخال الاسم' : null;
      ageError = ageController.text.isEmpty
          ? 'الرجاء إدخال السن'
          : (int.tryParse(ageController.text) == null || int.parse(ageController.text) <= 0)
              ? 'الرجاء إدخال سن صحيح'
              : null;
    });
    return nameError == null && ageError == null && selectedGender != null;
  }

  Future<void> submitForm() async {
    if (!validateInputs()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى ملء جميع الحقول المطلوبة بشكل صحيح',
            style: TextStyle(fontFamily: "Alexandria"),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("يرجى تسجيل الدخول أولاً")),
        );
        setState(() {
          isSubmitting = false;
        });
        return;
      }

      final uri = Uri.parse('https://raid-overseas-promo-labs.trycloudflare.com/api/child/create');
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['name'] = nameController.text.trim();

      int age = int.parse(ageController.text);
      DateTime birthDate = DateTime.now().subtract(Duration(days: age * 365));
      String formattedBirthDate = birthDate.toIso8601String().split('T').first;

      request.fields['birth_date'] = formattedBirthDate;
      request.fields['gender'] = selectedGender ?? '';

      if (selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            selectedImage!.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      print("🔵 Sending request to: $uri");
      print("🔵 Fields:");
      print("    name: ${request.fields['name']}");
      print("    birth_date: ${request.fields['birth_date']}");
      print("    gender: ${request.fields['gender']}");
      print("    image attached: ${selectedImage != null}");

      var response = await request.send();

      print("🔵 Response status code: ${response.statusCode}");

      final responseBody = await response.stream.bytesToString();
      print("🔵 Response body: $responseBody");

      // غالبًا الـ API يرجع 201 عند إنشاء ناجح
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const QuestionsPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشل في إرسال البيانات. الكود: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("❌ Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("حدث خطأ أثناء الاتصال بالخادم")),
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    ),
                  ],
                ),
                Image.asset(
                  "Photos/gradLogo1.png",
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: nameController,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: 'اسم المريض',
                    errorText: nameError,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: "Alexandria",
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: ageController,
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "السن",
                    errorText: ageError,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(
                      fontFamily: "Alexandria",
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "النوع",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: "Alexandria",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'ذكر',
                            groupValue: selectedGender,
                            onChanged: (value) => setState(() => selectedGender = value),
                            activeColor: Colors.blue,
                          ),
                          const Text('ذكر', style: TextStyle(fontFamily: "Alexandria")),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'أنثى',
                            groupValue: selectedGender,
                            onChanged: (value) => setState(() => selectedGender = value),
                            activeColor: Colors.blue,
                          ),
                          const Text('أنثى', style: TextStyle(fontFamily: "Alexandria")),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '(اختياري)',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Alexandria",
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: isPickingImage ? null : pickImage,
                      icon: isPickingImage
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.blue,
                              ),
                            )
                          : const Icon(Icons.add_a_photo_rounded, color: Colors.black),
                      label: const Text('إضافة صورة'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
                if (selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              selectedImage!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: IconButton(
                            onPressed: removeImage,
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: isSubmitting ? null : submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 3),
                        )
                      : const Text(
                          'التالي',
                          style: TextStyle(
                            fontFamily: "Alexandria",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
