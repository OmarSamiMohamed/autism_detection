import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,size: 33,), // زر الرجوع
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
    
      body:const Center(
        child: Column(
        
              children: [
                SizedBox(height: 30), // مسافة بين شريط التطبيق والمحتوى
                Text(
                      "النتائج",
                  style: TextStyle(
                    
                  fontFamily: "Alexandria",
                    color: Colors.blue,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                  ),
                ),
        //هنضيف هنا النتائج بتاعت الai لما تتعمل
                ],
              ),
      ),
        );
        
      
  }
}
