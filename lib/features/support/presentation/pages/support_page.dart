import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_assets.dart';
import '../../../../core/routing/app_router.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
          height: 120,
          width: 120,
          child: Image.asset(AppAssets.gradLogo1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'صفحة الدعم والإرشادات',
                style: TextStyle(
                  fontFamily: "Alexandria",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Divider(
                thickness: 2,
                color: Colors.blueAccent,
                indent: 50,
                endIndent: 50,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "مرحبًا بكم في صفحة الدعم والإرشادات التي تقدم معلومات ونصائح موجهة لذوي الهمم. سنتناول هنا بعض التحديات التي قد تواجههم، مع اقتراح طرق لمساعدتهم في التغلب عليها.",
                  style: TextStyle(
                    fontFamily: "Alexandria",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRouter.supportContent);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
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
            ],
          ),
        ],
      ),
    );
  }
}
