import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_assets.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(AppAssets.gradLogo),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.20),
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
                title:
                    Image.asset(AppAssets.gradLogo1, height: 100, width: 100),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'الأسئلة',
                        style: TextStyle(
                          fontFamily: 'Alexandria',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
                      _buildListTile(context, 'السلوكيات التكرارية أو المقيدة',
                          AppRouter.repetitiveBehaviors),
                      _buildListTile(context, 'التفاعل الاجتماعي',
                          AppRouter.socialInteraction),
                      _buildListTile(context, 'التواصل اللفظي وغير لفظي',
                          AppRouter.communication),
                      _buildListTile(
                          context, 'العناية بالذات', AppRouter.selfCare),
                      _buildListTile(context, 'الانتباه', AppRouter.attention),
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

  Widget _buildListTile(BuildContext context, String title, String route) {
    return ListTile(
      leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      title: Align(
        alignment: Alignment.topRight,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Alexandria',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
