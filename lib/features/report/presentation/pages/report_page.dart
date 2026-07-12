import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    double percentage = 74;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Center(
                child: Text(
                  'النتائج',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontFamily: 'Alexandria',
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'بعد تحليل الصوره ومراجعة أجوبة الأسئلة تم اكتشاف أن هذا الشخص مصاب بنسبة:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Alexandria',
                ),
              ),
              const SizedBox(height: 70),
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "%${percentage.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'التقرير',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontFamily: 'Alexandria',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '''بعد مراجعه أجوبه سيادتكم عن تصرفات وسلوك ابنكم:

# نريد اخباركم بالتالي:
يتضح أن هناك بعض الأنماط السلوكيه المميزه وهي حركات تكراريه وهذا مؤشر خطير.

# تجنب طفلكم للتفاعل مع الآخرين أو وجود صعوبة في تكوين الصداقات:
إذا وضعت بجانب المؤشرات الخطيره، يتضح أنها من سمات إضطراب التوحد.

وإذا أحطنا علماً أنه لا يقوم بتنفيذ مهامه الحياتية بشكل منفرد وأيضاً يعاني من التركيز فيها، فهو شئ مقلق.

وعليه: 
ابنكم يعاني من اضطراب حاد في التوحد، وهذا تشخيص مبدئي قمنا به بناءاً على أسئلة دولية معتمدة وعلى تحليل صورة الطفل باستخدام الذكاء الاصطناعي.

⚠️ ولكن هذا ليس كافياً في البت في أمر ابنكم. ننصح وبشدة بالذهاب للطبيب المختص وعمل تحليل شامل له. فالتدخل المبكر سيفيد في تحسين جودة حياة الطفل.''',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Alexandria',
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Download report functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'تحميل التقرير',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Alexandria',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
