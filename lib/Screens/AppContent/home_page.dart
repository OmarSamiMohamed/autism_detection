import 'package:flutter/material.dart';
import 'package:autism_detection/Screens/AppContent/Diagnosis_page.dart';
import 'package:autism_detection/gemini_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 3; // الصفحة الحالية (افتراضيًا الصفحة الرئيسية)

  // تعريف الصفحات لكل زر
  final List<Widget> _pages = [
    const SettingsPage(),  // صفحة الإعدادات
    const MenuPage(),      // صفحة القائمة
    const ChatBotPage(),   // صفحة شات بوت
    const HomeContent(), // الصفحة الرئيسية
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.black),
            onPressed: () {}, // الإجراء عند الضغط
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "!..مرحبا بيك ",
                style: TextStyle(
                  fontFamily: "Alexandria",
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 24,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'ChatBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
        ],
        currentIndex: _currentIndex,
        iconSize: 39,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped, // التبديل بين الصفحات
      ),
    );
  }
}

// صفحة المحتوى الرئيسية
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return DiagnosisPage();
              }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 63, vertical: 27),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            child: const Text(
              'تشخيص',
              style: TextStyle(
                fontFamily: "Alexandria",
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // الإجراء عند الضغط على الزر الثاني
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            child: const Text(
              'دعم ونصائح',
              style: TextStyle(
                fontFamily: "Alexandria",
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// صفحة الإعدادات
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// صفحة القائمة
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Menu Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// صفحة شات بوت
 // استبدل باسم مشروعك

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<Map<String, String>> _messages = []; // قائمة الرسائل (نص + نوع المرسل)
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false; // حالة تحميل الرد

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userMessage = _controller.text;
    setState(() {
      _messages.insert(0, {"sender": "user", "text": userMessage});
      _controller.clear();
      _isLoading = true;
    });

    String botResponse = await GeminiService.sendMessage(userMessage);

    setState(() {
      _messages.insert(0, {"sender": "bot", "text": botResponse});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: SizedBox(
          height: 70,
          width: 70,
          child: Image.asset("Photos/gradLogo1.png"), // استبدل بمسار الصورة الخاص بك
        ),
      ),
      body: Container(
        color: Colors.white, // تغيير خلفية الصفحة إلى الأبيض
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message["sender"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: message["sender"] == "user"
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message["text"]!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'أرسل رسالة....',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20), // جعل الحواف دائرية
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: _sendMessage,
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
