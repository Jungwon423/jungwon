import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, this.isMe, this.hour, this.minute, {Key? key})
      : super(key: key);

  final String message;
  final bool isMe;
  final int hour;
  final int minute;

  @override
  Widget build(BuildContext context) {
    String zeroOrNot = (minute >= 10) ? "" : "0";
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (hour > 12 && isMe == true)
          Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Text(
                "오후 ${hour - 12}:$zeroOrNot$minute",
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              )),
        if (hour <= 12 && isMe == true)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text(
              "오전 " + hour.toString() + ':' + zeroOrNot + minute.toString(),
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
        Container(
          constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xFFF2C7CC) : Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              // bottomRight:
              //     isMe ? const Radius.circular(0) : const Radius.circular(12),
              // bottomLeft: isMe
              //     ? const Radius.circular(12)
              //     : const Radius.circular(0)
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
          ),
        ),
        if (hour > 12 && isMe == false)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text(
              "오후 ${hour - 12}:$zeroOrNot$minute",
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
        if (hour <= 12 && isMe == false)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text(
              "오전 $hour:$zeroOrNot$minute",
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
      ],
    );
  }
}