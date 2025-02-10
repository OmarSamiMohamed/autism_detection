import 'package:flutter/material.dart';

class SupportContentPage extends StatelessWidget {
  const SupportContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // جعل خلفية الصفحة بيضاء
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
          height: 120,
          width: 120,
          child: Image.asset("Photos/gradLogo1.png"), // استبدل بمسار الصورة الخاص بك
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildSection("العناية بالذات", 
            'قد يجد بعض ذوي الهمم صعوبة في العناية بأنفسهم، مثل تناول الطعام، ارتداء الملابس، والحفاظ على النظافة الشخصية.',
            '# التدريب التدريجي: درّب الشخص على المهارات بشكل تدريجي.',
            '# استخدام أدوات مساعدة: استخدم أدوات تسهل العملية، مثل فرشاة أسنان كهربائية.',
            '# التشجيع: قدم المكافآت أو عبارات التشجيع لتعزيز الاعتماد على النفس.'
          ),
          const SizedBox(height: 60),
          _buildSection("الانتباه", 
           "ضعف الانتباه يمثل تحديًا في القدرة على التركيز لفترات طويلة، مما يؤثر على الدراسة، العمل، أو الأنشطة اليومية.",
            'تقليل المشتتات: وفر بيئة هادئة وخالية من الملهيات أثناء أداء المهام.',
            '# تقسيم المهام: اجعل المهام الكبيرة أكثر سهولة عن طريق تقسيمها إلى أجزاء صغيرة.',
            '#استشارة مختص: إذا كانت المشكلة كبيرة، يُفضل استشارة طبيب أو أخصائي للحصول على حلول أو أدوية لتحسين التركيز.',
            
          ),
          const SizedBox(height: 60),
          _buildSection("التواصل اللفظي والغير لفظي", 
            'يعاني بعض ذوي الهمم من صعوبات في التواصل، سواء بالكلام أو باستخدام الإشارات ولغة الجسد، مما يجعل التفاعل مع الآخرين أكثر تعقيدًا.',
            '# استخدام أدوات تواصل بديلة: إذا كان الشخص غير قادر على التحدث، استخدم وسائل مثل الصور، الإشارات، أو تطبيقات الهواتف المحمولة لتسهيل التواصل.',
            '#التدريب على الكلام: بالتعاون مع أخصائي تخاطب، يمكن تطوير مهارات النطق والتواصل.',
            '#تعزيز لغة الجسد: درّب الشخص على استخدام تعبيرات الوجه والإشارات ليصبح التواصل أكثر وضوحًا.'
          ),
          const SizedBox(height: 60), // المسافة بين القوائم
          _buildSectionWithoutProblem("نصائح عامة", 
            '# التفهم والاحترام: احرص على تفهم التحديات التي يواجهها الشخص وتجنب الحكم عليه..',
            '#التشجيع: قدم الدعم المعنوي وشجعه على التعلم والتطور.   .',
            '# الصبر: التقدم قد يحتاج إلى وقت، لكن مع الدعم المناسب، يمكن تحقيق نتائج إيجابية.'
          ),
          const SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                backgroundColor: Colors.blue, // لون الزر الأزرق
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'التالي',
                style: TextStyle(fontFamily: "Alexandria", fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// دالة لإنشاء المقطع المتكرر مع تعديل النصوص لكل قسم
  Widget _buildSection(String title, String description, String solution1, String solution2, String solution3) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title, // العنوان هنا
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: TextStyle(fontFamily: "Alexandria"),
                children: [
                  TextSpan(
                    text: 'تعريف المشكلة\n\n',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  TextSpan(
                    text: description, // وصف المشكلة هنا
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                  TextSpan(
                    text: '\n\nطرق الحل والإرشادات:\n\n',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  TextSpan(
                    text: solution1, // الحل الأول هنا
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                  TextSpan(
                    text: '\n\n$solution2', // الحل الثاني هنا
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                  TextSpan(
                    text: '\n\n$solution3', // الحل الثالث هنا
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// دالة لإنشاء المقطع المتكرر بدون تعريف المشكلة وطرق الحل
  Widget _buildSectionWithoutProblem(String title, String solution1, String solution2, String solution3) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title, // العنوان هنا
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: TextStyle(fontFamily: "Alexandria"),
                children: [
                  TextSpan(
                    text: solution1, // الحل الأول هنا
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                  TextSpan(
                    text: '\n\n$solution2', // الحل الثاني هنا
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                  TextSpan(
                    text: '\n\n$solution3', // الحل الثالث هنا
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
