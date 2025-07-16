import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' show TextPainter;
import 'package:flutter/services.dart' show TextDirection;
import 'package:intl/intl.dart' show DateFormat;

import '../../../../core/user_session/user_session_app.dart';
import '../../data/models/get_all_my_meesages_model/message_model.dart';

class BuildMessageBubble extends StatefulWidget {
  const BuildMessageBubble({super.key, required this.message});
  final MessageModel message;

  @override
  State<BuildMessageBubble> createState() => _BuildMessageBubbleState();
}

class _BuildMessageBubbleState extends State<BuildMessageBubble> {
  bool isExpanded = false;
  final int maxLines = 3; // عدد الأسطر المحددة قبل إظهار "more"

  @override
  Widget build(BuildContext context) {
    final userId = AppUserSession().userId;
    bool isMe = userId == widget.message.sender;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[600] : Colors.indigo[50],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // النص مع إمكانية التوسع
              _buildExpandableText(isMe),
              SizedBox(height: 8),
              // الوقت
              Text(
                DateFormat(
                  'HH:mm',
                ).format(widget.message.createdAt!).toString(),
                style: TextStyle(
                  color: isMe ? Colors.white70 : Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableText(bool isMe) {
    final text = widget.message.text.toString();

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: maxLines,
          textDirection: TextDirection.ltr, // ✅ هذا السطر ضروري
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        final isTextOverflow = textPainter.didExceedMaxLines;

        if (!isTextOverflow) {
          // إذا كان النص لا يتجاوز الحد المسموح
          return Text(
            text,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black87,
              fontSize: 16,
            ),
          );
        }

        return Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              maxLines: isExpanded ? null : maxLines,
              overflow: isExpanded ? TextOverflow.visible : null,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'Read less....' : 'Read More....',
                style: TextStyle(
                  color: isMe ? Colors.white70 : Colors.teal[50],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
