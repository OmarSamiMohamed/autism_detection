import 'package:flutter/material.dart';


class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // جعل خلفية الصفحة بيضاء
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
         title: SizedBox(
          height: 100,
          width: 100,
          child: Image.asset("Photos/gradLogo1.png"), // استبدل بمسار الصورة الخاص بك
        ),
     
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          
   Container(
  decoration: BoxDecoration( // لون الخلفية اللبني
    border: Border.all(
      color: Colors.blue, // لون الحواف الزرقاء
      width: 2.0, // سمك الحواف
    ),
    borderRadius: BorderRadius.circular(8), // جعل الحواف مستديرة إذا كنت تريد
  ),
  padding: const EdgeInsets.all(10), // مسافة بين النص والحواف
  child: const Text(
    'الأسئلة',
    style: TextStyle(
      fontFamily: "Alexandria",
      fontSize: 17, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      color: Colors.blue, // لون الخط أسود
    ),
    textAlign: TextAlign.center, // جعل النص في المنتصف
  ),
),

          const SizedBox(height: 40), // مسافة بين النص والقائمة
          _buildListTile(context, 'السلوكيات التكرارية أو المقيدة' ,  const RepetitiveBehaviorsPage()),
          _buildListTile(context, 'التفاعل الاجتماعي',  const SocialInteractionPage()),
          _buildListTile(context, 'التواصل اللفظي وغير لفظي', const CommunicationPage()),
          _buildListTile(context, 'العناية بالذات', const SelfCarePage()),
          _buildListTile(context, 'الانتباه',  const AttentionPage()),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, Widget nextPage) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontFamily: "Alexandria",fontSize: 15, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.arrow_back_ios, color: Colors.black), // سهم باتجاه اليمين
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
    );
  }
}

// Placeholder pages


class ChoiceButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceButton({super.key, 
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 20,
            fontFamily: "Alexandria",
          ),
        ),
      ),
    );
  }
}
class RepetitiveBehaviorsPage extends StatefulWidget {
  const RepetitiveBehaviorsPage({super.key});

  @override
  _RepetitiveBehaviorsPageState createState() => _RepetitiveBehaviorsPageState();
}
class _RepetitiveBehaviorsPageState extends State<RepetitiveBehaviorsPage> {
  // تخزين الإجابات المختارة لكل سؤال
  List<int?> selectedAnswers = [null, null, null, null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('السلوكيات التكرارية أو المقيدة',style:TextStyle(
          fontFamily: "Alexandria",
      fontSize: 24.0, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      color: Colors.blue,
        ) ,),
        centerTitle: true,
      
      ),
      backgroundColor: Colors.white,
      body: 
      Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              buildQuestion(
                0,
                "هل ينشغل الطفل بلعبة معينة ويترك باقي الألعاب؟",
              ),
              const SizedBox(height: 50),
              buildQuestion(
                1,
                "هل يستخدم الطفل الألعاب بطريقة نمطية بصورة متكررة؟",
              ),
              const SizedBox(height: 50),
              buildQuestion(
                2,
                "هل يصدر الطفل أصواتًا حادة؟",
                
              ), const SizedBox(height: 50),
                 buildQuestion(
                3,
                "هل يقوم الطفل بالرفرفة بيده الى الامام او الجانبين؟",
              ),
              const SizedBox(height: 50),
              buildQuestion(
                4,
                "هل يستمر الطفل بعمل سلوكيات محددة اذا ترك بمفرده؟",
                
              ),
               const SizedBox(height: 50),
                 buildQuestion(
                5,
                "هل يتبع الطفل سلوكيات بطقوس معينة؟",
              ), const SizedBox(height: 40,),
               ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const QuestionsPage();
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
                  color: Colors.white)
                ),
              ),
       
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(int questionIndex, String questionText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: const TextStyle(
             fontFamily: "Alexandria",
      fontSize: 20, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      
          ),
        ),
        const SizedBox(height: 40),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (optionIndex) {
            return ChoiceButton(
              text: ["نعم", "أحيانًا", "نادرًا", "لا"][optionIndex],
              isSelected: selectedAnswers[questionIndex] == optionIndex,
              onTap: () {
                setState(() {
                  selectedAnswers[questionIndex] = optionIndex;
                });
              },
            );
          }),
        ),
      ],
      
    );
  }
}


class SocialInteractionPage extends StatefulWidget {
  const SocialInteractionPage({super.key});

  @override
  _SocialInteractionPageState createState() => _SocialInteractionPageState();
}
class _SocialInteractionPageState extends State<SocialInteractionPage> {
  // تخزين الإجابات المختارة لكل سؤال
  List<int?> selectedAnswers = [null, null, null, null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: const Text('التفاعل الاجتماعي',style:TextStyle(
          fontFamily: "Alexandria",
      fontSize: 24.0, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      color: Colors.blue,
        ) ,),
        centerTitle: true,
      
      ),
      backgroundColor: Colors.white,
      body: 
      Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25,),
              buildQuestion(
                0,
                "هل يعجز الطفل عن بدء الحديث مع الأخرين؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                1,
                "هل الطفل غير قادر علي تقليد الأشخاص؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                2,
                "هل يظهر الطفل سعادة محدودة عند التفاعل؟",
                
              ), const SizedBox(height: 25),
                 buildQuestion(
                3,
                "هل يفشل الطفل في تكوين صداقات أو الحفاظ عليها؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                4,
                "هل يظهر الطفل إهتمام محدود للأخرين أو يتجاهل وجود الأشخاص؟",
                
              ),
               const SizedBox(height: 25),
                 buildQuestion(
                5,
                "هل يبدي الطفل عدم إستجابة عندما يحاول الأخرين التفاعل معه؟",
              ), const SizedBox(height: 35,),
               ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const QuestionsPage();
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
                  color: Colors.white)
                ),
              ),
       
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(int questionIndex, String questionText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(
             fontFamily: "Alexandria",
      fontSize: 20, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      
          ),
        ),
        const SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (optionIndex) {
            return ChoiceButton(
              text: ["نعم", "أحيانًا", "نادرًا", "لا"][optionIndex],
              isSelected: selectedAnswers[questionIndex] == optionIndex,
              onTap: () {
                setState(() {
                  selectedAnswers[questionIndex] = optionIndex;
                });
              },
            );
          }),
        ),
      ],
      
    );
  }
}

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  _CommunicationPageState createState() => _CommunicationPageState();
}
class _CommunicationPageState extends State<CommunicationPage> {
  // تخزين الإجابات المختارة لكل سؤال
  List<int?> selectedAnswers = [null, null, null, null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('التواصل اللفظي وغير اللفظي',style:TextStyle(
          fontFamily: "Alexandria",
      fontSize: 24.0, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      color: Colors.blue,
        ) ,),
        centerTitle: true,
      
      ),
      backgroundColor: Colors.white,
      body: 
      Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25,),
              buildQuestion(
                0,
                "هل يقوم الطفل بترديد الكلام بشكل متكرر؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                1,
                "هل تلاحظ أن الطفل لا يفهم كثير من الكلمات عند الحديث معه؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                2,
                "هل تلاحظ أن الطفل لا يستطيع فهم المغزى من الحديث أو استيعاب نوايا المتحدث؟",
                
              ), const SizedBox(height: 25),
                 buildQuestion(
                3,
                "هل يستطيع الطفل إبداء تعبيرات وجهية تعكس مشاعره؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                4,
                "هل تلاحظ أن الطفل لا ينتظر دوره في الحديث ويقاطع الكلام أحياناً؟",
                
              ),
               const SizedBox(height: 25),
                 buildQuestion(
                5,
                "هل يستطيع الطفل فهم تعبيرات الوجه لدي الأشخاص؟",
              ), const SizedBox(height: 35,),
               ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const QuestionsPage();
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
                  color: Colors.white)
                ),
              ),
       
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(int questionIndex, String questionText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(
             fontFamily: "Alexandria",
      fontSize: 20, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      
          ),
        ),
        const SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (optionIndex) {
            return ChoiceButton(
              text: ["نعم", "أحيانًا", "نادرًا", "لا"][optionIndex],
              isSelected: selectedAnswers[questionIndex] == optionIndex,
              onTap: () {
                setState(() {
                  selectedAnswers[questionIndex] = optionIndex;
                });
              },
            );
          }),
        ),
      ],
      
    );
  }
}

class SelfCarePage extends StatefulWidget {
  const SelfCarePage({super.key});

  @override
  _SelfCarePageState createState() => _SelfCarePageState();
}
class _SelfCarePageState extends State<SelfCarePage> {
  // تخزين الإجابات المختارة لكل سؤال
  List<int?> selectedAnswers = [null, null, null, null, null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('العناية بالذات',style:TextStyle(
          fontFamily: "Alexandria",
      fontSize: 24.0, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      color: Colors.blue,
        ) ,),
        centerTitle: true,
      
      ),
      backgroundColor: Colors.white,
      body: 
      Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25,),
              buildQuestion(
                0,
                "هل يستطيع الطفل إرتداء ملابسه بمفرده؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                1,
                "هل يعتني الطفل بنظافته الشخصية؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                2,
                "هل الطفل غير قادر علي التنقل بمفرده؟",
                
              ), const SizedBox(height: 25),
                 buildQuestion(
                3,
                "هل تلاحظ أن الطفل معتمد علي الأخرين بشكل كلي؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                4,
                "هل الطفل قادر علي إدراك الوقت أو المال؟",
                
              ),
               const SizedBox(height: 25),
                 buildQuestion(
                5,
                "هل الطفل يقوم بغسل يديه (مثلا بعد تناول الطعام)؟",
              ), const SizedBox(height: 35,) ,
               const SizedBox(height: 25),
                 buildQuestion(
                6,
                "هل تلاحظ أن الطفل لا يستطيع الإستقلالية في أغلب الأمور؟",
              ), const SizedBox(height: 35,),
               ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const QuestionsPage();
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
                  color: Colors.white)
                ),
              ),
       
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(int questionIndex, String questionText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(
             fontFamily: "Alexandria",
      fontSize: 20, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      
          ),
        ),
        const SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (optionIndex) {
            return ChoiceButton(
              text: ["نعم", "أحيانًا", "نادرًا", "لا"][optionIndex],
              isSelected: selectedAnswers[questionIndex] == optionIndex,
              onTap: () {
                setState(() {
                  selectedAnswers[questionIndex] = optionIndex;
                });
              },
            );
          }),
        ),
      ],
      
    );
  }
}

class AttentionPage extends StatefulWidget {
  const AttentionPage({super.key});

  @override
  _AttentionPageState createState() => _AttentionPageState();
}
class _AttentionPageState extends State<AttentionPage> {
  // تخزين الإجابات المختارة لكل سؤال
  List<int?> selectedAnswers = [null, null, null, null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('الانتباه',style:TextStyle(
          fontFamily: "Alexandria",
      fontSize: 24.0, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      color: Colors.blue,
        ) ,),
        centerTitle: true,
      
      ),
      backgroundColor: Colors.white,
      body: 
      Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25,),
              buildQuestion(
                0,
                "هل تلاحظ أن الطفل لا يستطيع التنقل ببصره بين شيئين؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                1,
                "هل تلاحظ أن الطفل غير منتبه للأشياء المحيطة به؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                2,
                "هل تلاحظ أن الطفل لا يستطيع التنقل ببصره بين شخص وشئ؟",
                
              ), const SizedBox(height: 25),
                 buildQuestion(
                3,
                "هل تلاحظ أن الطفل لا يستطيع أن يتنقل ببصره بين شخص وشئين؟",
              ),
              const SizedBox(height: 25),
              buildQuestion(
                4,
                "هل تلاحظ أن الطفل لا يستطيع النظر في عينيك أثناء حديثك معه؟",
                
              ),
               const SizedBox(height: 25),
                 buildQuestion(
                5,
                "هل تلاحظ إذا حدث أي شئ بسيط قد يخرج الطفل عن تركيزه ويصيب بتشتت؟",
              ), const SizedBox(height: 35,),
               ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const QuestionsPage();
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
                  color: Colors.white)
                ),
              ),
       
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(int questionIndex, String questionText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(
             fontFamily: "Alexandria",
      fontSize: 20, // حجم الخط الكبير
      fontWeight: FontWeight.bold, // جعل الخط عريض
      
          ),
        ),
        const SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (optionIndex) {
            return ChoiceButton(
              text: ["نعم", "أحيانًا", "نادرًا", "لا"][optionIndex],
              isSelected: selectedAnswers[questionIndex] == optionIndex,
              onTap: () {
                setState(() {
                  selectedAnswers[questionIndex] = optionIndex;
                });
              },
            );
          }),
        ),
      ],
      
    );
  }
}

