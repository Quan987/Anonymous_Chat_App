import 'package:flutter/material.dart';
import 'package:hw4/pages/group_chat_message_page.dart';
import 'package:hw4/pages/profile_page.dart';
import 'package:hw4/pages/setting_page.dart';
import 'package:hw4/widgets/nav_icon_widget.dart';

class NavBarController extends StatelessWidget {
  const NavBarController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.amber[800]),
            accountName: const Text("Demo"),
            accountEmail: const Text("Demo"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/login-profile.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          NavIcon(
            icon: Icons.home,
            title: "Message Boards",
            onTap: () => Navigator.of(context).pop(),
          ),
          NavIcon(
            icon: Icons.mark_unread_chat_alt,
            title: "Chat Room",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const GroupChatMessagePage()),
            ),
          ),
          NavIcon(
            icon: Icons.person,
            title: "Profile",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            ),
          ),
          NavIcon(
            icon: Icons.settings,
            title: "Settings",
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingPage()),
            ),
          ),
        ],
      ),
    );
  }
}
