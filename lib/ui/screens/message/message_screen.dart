import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/constants/images.dart';
import 'package:hanae_app/core/utils/responsive.dart';
import 'package:hanae_app/ui/screens/message/chat_screen.dart';
import 'package:hanae_app/ui/widgets/chat_widgets/chat_tile.dart';
import 'package:hanae_app/ui/widgets/chat_widgets/modern_tap_bar.dart';

// استخدم هذه الأيقونات أو بدّلها بما يناسبك
const _tabIcons = [
  Icons.fitness_center, // مدرب
  Icons.sports_tennis, // لاعب
  Icons.groups_2_rounded, // جروب
];
const _tabNames = [
  "Trainers",
  "Players",
  "Groups",
];

// نموذج الرسالة (للتجربة)
class ChatMessage {
  final String name;
  final String message;
  final String time;
  final String avatar;
  ChatMessage(this.name, this.message, this.time, this.avatar);
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int selectedTab = 0;

  final List<ChatMessage> allMessages = [
    ChatMessage(
        "Coach Michael", "Great session today!", "8:45 PM", AppImages.coach),
    ChatMessage(
        "John Doe", "Thanks for the advice!", "8:44 PM", AppImages.player),
    ChatMessage(
        "Sarah Player", "See you next week!", "Yesterday", AppImages.player),
    ChatMessage("Coach Michael", "Keep it up!", "Yesterday", AppImages.coach),
  ];

  List<ChatMessage> get filteredMessages {
    if (selectedTab == 0) {
      return allMessages
          .where((m) => m.name.toLowerCase().contains("coach"))
          .toList();
    } else if (selectedTab == 1) {
      return allMessages
          .where((m) =>
              m.name.toLowerCase().contains("player") ||
              m.name.toLowerCase().contains("john"))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: r.wp(0.045)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: r.hp(0.025)),
              Text(
                'Messages',
                style: GoogleFonts.poppins(
                  color: AppColors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: r.sp(0.053),
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: r.hp(0.017)),
              // 👇👇 التابات العلوية بتصميم احترافي
              ModernTabBar(
                selected: selectedTab,
                r: r,
                onChanged: (i) => setState(() => selectedTab = i),
              ),
              SizedBox(height: r.hp(0.025)),
              // قائمة الرسائل
              Expanded(
                child: filteredMessages.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.mark_chat_unread_rounded,
                                color: Colors.white24, size: r.wp(0.23)),
                            SizedBox(height: r.hp(0.018)),
                            Text(
                              "No messages yet.",
                              style: GoogleFonts.poppins(
                                color: Colors.white60,
                                fontSize: r.sp(0.040),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.only(
                            bottom: r.hp(0.018), top: r.hp(0.004)),
                        itemCount: filteredMessages.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: r.hp(0.013)),
                        itemBuilder: (context, i) {
                          final msg = filteredMessages[i];
                          return ChatTile(
                            key: ValueKey(msg.hashCode),
                            msg: msg,
                            r: r,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(
                                    userName: msg.name,
                                    userAvatar: msg.avatar,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
