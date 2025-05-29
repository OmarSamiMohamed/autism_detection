import 'package:flutter/material.dart';

class SupportContentPage extends StatelessWidget {
  const SupportContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية الصفحة بيضاء
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: SizedBox(
          height: 100,
          width: 100,
          child: Image.asset("Photos/gradLogo1.png"),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(
            "العناية بالذات",
            'قد يجد بعض ذوي الهمم صعوبة في العناية بأنفسهم، مثل تناول الطعام، ارتداء الملابس، والحفاظ على النظافة الشخصية.',
            [
              'التدريب التدريجي: درّب الشخص على المهارات بشكل تدريجي.',
              'استخدام أدوات مساعدة: استخدم أدوات تسهل العملية، مثل فرشاة أسنان كهربائية.',
              'التشجيع: قدم المكافآت أو عبارات التشجيع لتعزيز الاعتماد على النفس.',
            ],
          ),
          const SizedBox(height: 40),
          _buildSection(
            "الانتباه",
            'ضعف الانتباه يمثل تحديًا في القدرة على التركيز لفترات طويلة، مما يؤثر على الدراسة، العمل، أو الأنشطة اليومية.',
            [
              'تقليل المشتتات: وفر بيئة هادئة وخالية من الملهيات أثناء أداء المهام.',
              'تقسيم المهام: اجعل المهام الكبيرة أكثر سهولة عن طريق تقسيمها إلى أجزاء صغيرة.',
              'استشارة مختص: إذا كانت المشكلة كبيرة، يُفضل استشارة طبيب أو أخصائي للحصول على حلول أو أدوية لتحسين التركيز.',
            ],
          ),
          const SizedBox(height: 40),
          _buildSection(
            "التواصل اللفظي والغير لفظي",
            'يعاني بعض ذوي الهمم من صعوبات في التواصل، سواء بالكلام أو باستخدام الإشارات ولغة الجسد، مما يجعل التفاعل مع الآخرين أكثر تعقيدًا.',
            [
              'استخدام أدوات تواصل بديلة: مثل الصور أو التطبيقات لتسهيل التواصل.',
              'التدريب على الكلام: بالتعاون مع أخصائي تخاطب، يمكن تطوير مهارات النطق.',
              'تعزيز لغة الجسد: درّب الشخص على تعبيرات الوجه والإشارات لزيادة وضوح التواصل.',
            ],
          ),
          const SizedBox(height: 40),
          _buildTipsSection(
            "نصائح عامة",
            [
              'التفهم والاحترام: تفهم التحديات وتجنب الحكم عليهم.',
              'التشجيع: قدم الدعم المعنوي وشجعه على التعلم والتطور.',
              'الصبر: التقدم يحتاج وقت، لكن مع الدعم المناسب يمكن تحقيق نتائج إيجابية.',
            ],
          ),
          const SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                backgroundColor: Colors.blue,
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
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String description, List<String> solutions) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue.shade50.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Alexandria",
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "تعريف المشكلة:",
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontFamily: "Alexandria",
                fontSize: 20,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),
            const Text(
              "طرق الحل والإرشادات:",
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            ...solutions.map((s) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "- $s",
                    style: const TextStyle(
                      fontFamily: "Alexandria",
                      fontSize: 19,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection(String title, List<String> tips) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.green.shade50.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Alexandria",
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...tips.map((tip) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "- $tip",
                    style: const TextStyle(
                      fontFamily: "Alexandria",
                      fontSize: 19,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
