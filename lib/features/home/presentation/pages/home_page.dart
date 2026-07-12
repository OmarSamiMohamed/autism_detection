import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_assets.dart';
import '../../../../core/routing/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SettingsContentPage(),
    const MenuContentPage(),
    const ChatBotContentPage(),
    const HomeContentPage(),
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
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          leading: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.black),
            onPressed: () {},
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "!..أهلا بك ",
                style: TextStyle(
                  fontFamily: "Alexandria",
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 22,
                  color: Colors.white,
                ),
              )
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
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
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
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Transform.scale(
            scale: 1.45,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                AppAssets.gradLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: 'تشخيص',
                icon: Icons.zoom_in,
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.diagnosis);
                },
                backgroundColor: Colors.blue,
              ),
              const SizedBox(height: 50),
              CustomButton(
                text: 'دعم ونصائح',
                icon: Icons.contact_support,
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.support);
                },
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsContentPage extends StatelessWidget {
  const SettingsContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.settings),
            SizedBox(width: 8),
            Text(
              'الإعدادات',
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('الإشعارات',
                style: TextStyle(fontFamily: "Alexandria", fontSize: 15)),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('الخصوصية',
                style: TextStyle(fontFamily: "Alexandria", fontSize: 15)),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('المساعدة',
                style: TextStyle(fontFamily: "Alexandria", fontSize: 15)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class MenuContentPage extends StatelessWidget {
  const MenuContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_circle),
            SizedBox(width: 8),
            Text(
              "الحساب",
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.email),
            title: Text('تغيير البريد الإلكتروني',
                style: TextStyle(fontFamily: "Alexandria", fontSize: 15)),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('تغيير كلمة السر',
                style: TextStyle(fontFamily: "Alexandria", fontSize: 15)),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('التقرير',
                style: TextStyle(fontFamily: "Alexandria", fontSize: 15)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ChatBotContentPage extends StatefulWidget {
  const ChatBotContentPage({super.key});

  @override
  State<ChatBotContentPage> createState() => _ChatBotContentPageState();
}

class _ChatBotContentPageState extends State<ChatBotContentPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.insert(0, {"sender": "user", "text": _controller.text.trim()});
      _controller.clear();
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _messages.insert(
          0, {"sender": "bot", "text": "عذراً، هذه الميزة قيد التطوير"});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: SizedBox(
          height: 55,
          width: 55,
          child: Image.asset(AppAssets.gradLogo1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text(
                      "لا توجد رسائل بعد",
                      style: TextStyle(fontFamily: "Alexandria", fontSize: 13),
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessage(_messages[index]);
                    },
                  ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: "اكتب رسالتك...",
                      hintStyle: const TextStyle(
                          fontFamily: "Alexandria", fontSize: 13),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed:
                      _controller.text.trim().isEmpty ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message["sender"] == "user";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(AppAssets.gradLogo),
            ),
          if (!isUser) const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: isUser ? Radius.circular(12) : Radius.circular(0),
                  bottomRight:
                      isUser ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              child: Text(
                message["text"]!,
                style: const TextStyle(fontSize: 15, fontFamily: "Alexandria"),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
          if (isUser)
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
        ],
      ),
    );
  }
}
