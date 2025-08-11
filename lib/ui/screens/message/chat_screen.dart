import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanae_app/core/constants/themes.dart';
import 'package:hanae_app/core/utils/responsive.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userAvatar;

  const ChatScreen({
    Key? key,
    required this.userName,
    required this.userAvatar,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // رسائل الدردشة (true = أنا، false = الطرف الآخر)
  final List<Map<String, dynamic>> messages = [
    {"fromMe": false, "text": "hey"},
    {"fromMe": true, "text": "hey"},
    {"fromMe": false, "text": "Please bring glows\ntomorrow"},
    {"fromMe": true, "text": "How are you?"},
    {"fromMe": true, "text": "What your our eamil"},
    {"fromMe": false, "text": "smith@webite.com"},
    {"fromMe": true, "text": "Good night"},
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add({"fromMe": true, "text": text});
      _controller.clear();
    });
    // يمكنك إضافة منطق إرسال الرسالة إلى السيرفر هنا
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // --- شريط أعلى الدردشة ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              r.wp(0.04),
              r.hp(0.05), // مسافة علوية لأمان notch
              r.wp(0.04),
              r.hp(0.022),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF232D3A),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white70, size: 22),
                ),
                SizedBox(width: r.wp(0.025)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    widget.userAvatar,
                    width: r.wp(0.108),
                    height: r.wp(0.108),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: r.wp(0.04)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: r.sp(0.035),
                        ),
                      ),
                      Text(
                        'online',
                        style: GoogleFonts.poppins(
                          color: AppColors.greenAccent,
                          fontWeight: FontWeight.w400,
                          fontSize: r.sp(0.026),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // --- قائمة الرسائل ---
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: r.hp(0.018),
                horizontal: r.wp(0.02),
              ),
              itemCount: messages.length,
              reverse: false,
              itemBuilder: (context, i) {
                final msg = messages[i];
                final isMe = msg["fromMe"] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: r.hp(0.013),
                      left: isMe ? r.wp(0.19) : 0,
                      right: isMe ? 0 : r.wp(0.19),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: r.wp(0.04),
                      vertical: r.hp(0.013),
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.greenAccent : const Color(0xFF232D3A),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(19),
                        topRight: Radius.circular(19),
                        bottomLeft: Radius.circular(isMe ? 19 : 5),
                        bottomRight: Radius.circular(isMe ? 5 : 19),
                      ),
                    ),
                    child: Text(
                      msg["text"],
                      style: GoogleFonts.poppins(
                        color: isMe ? Colors.black : Colors.white,
                        fontSize: r.sp(0.031),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // --- حقل إرسال الرسالة ---
          Padding(
            padding: EdgeInsets.only(
              left: r.wp(0.018),
              right: r.wp(0.018),
              bottom: r.hp(0.012) + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF232D3A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _controller,
                      style: GoogleFonts.poppins(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: r.wp(0.038),
                          vertical: r.hp(0.018),
                        ),
                        hintText: "Type a message",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white60,
                          fontSize: r.sp(0.033),
                        ),
                        border: InputBorder.none,
                      ),
                      onSubmitted: sendMessage,
                    ),
                  ),
                ),
                SizedBox(width: r.wp(0.02)),
                GestureDetector(
                  onTap: () => sendMessage(_controller.text),
                  child: Container(
                    padding: EdgeInsets.all(r.wp(0.025)),
                    decoration: BoxDecoration(
                      color: AppColors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.send, color: Colors.black, size: r.sp(0.045)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
