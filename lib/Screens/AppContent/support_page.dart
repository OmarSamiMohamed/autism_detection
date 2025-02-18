import 'package:autism_detection/Screens/AppContent/supportcontent_page.dart';
import 'package:flutter/material.dart';


class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

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
 Column(
   children: [
     const Text(
        'صفحة الدعم والارشادات',
        style: TextStyle(
          fontFamily: "Alexandria",
          fontSize: 25, // حجم الخط الكبير
          fontWeight: FontWeight.bold, // جعل الخط عريض
          color: Colors.blue, // لون الخط أسود
        ),
        textAlign: TextAlign.center, // جعل النص في المنتصف
      ),
       const SizedBox(height: 150),
       Padding(
         padding: const EdgeInsets.all(10.0),
         child: const Text(
          "مرحبًا بكم في صفحة الدعم والإرشادات التي تقدم معلومات ونصائح موجهة لذوي الهمم. سنتناول هنا بعض التحديات التي قد تواجههم، مع اقتراح طرق لمساعدتهم في التغلب عليها.",
          style: TextStyle(
            fontFamily: "Alexandria",
            fontSize: 17, // حجم الخط الكبير
            fontWeight: FontWeight.normal, // جعل الخط عريض
            color: Colors.black, // لون الخط أسود
          ),
          textAlign: TextAlign.center, // جعل النص في المنتصف
               ),
       ),
       const SizedBox(height: 270),
               ElevatedButton(
                onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const SupportContentPage();
                          }),
                        );
             
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
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


        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context, String title, Widget nextPage) {
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


