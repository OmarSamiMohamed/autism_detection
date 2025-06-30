import 'package:autism_detection/Screens/Questions_pages/attention_page.dart';
import 'package:autism_detection/Screens/Questions_pages/communication_page.dart';
import 'package:autism_detection/Screens/Questions_pages/self_care_page.dart';
import 'package:autism_detection/Screens/Questions_pages/social_interaction_page.dart';
import 'package:flutter/material.dart';
import 'repetitive_behaviors_page.dart';

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
                image: const AssetImage("Photos/gradLogo.png"),
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
                title: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("Photos/gradLogo1.png"),
                ),
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
                      _buildListTile(context, 'السلوكيات التكرارية أو المقيدة', const RepetitiveBehaviorsPage()),
                       _buildListTile(context, 'التفاعل الاجتماعي', const SocialInteractionPage()),
                      _buildListTile(context, 'التواصل اللفظي وغير لفظي', const CommunicationPage()),
                      _buildListTile(context, 'العناية بالذات', const SelfCarePage()),
                      _buildListTile(context, 'الانتباه', const AttentionPage()),
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

  Widget _buildListTile(BuildContext context, String title, Widget nextPage) {
    return ListTile(
      leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
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