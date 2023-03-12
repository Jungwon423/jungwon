import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../models/chat.dart';
import 'chat_bubble.dart';

class Messages extends StatelessWidget {
  List<Chat> chatList;

  Messages({Key? key, required this.chatList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Chat, DateTime>(
      itemComparator: (chat1, chat2) =>
          chat1.dateTime.compareTo(chat2.dateTime),
      order: GroupedListOrder.DESC,
      reverse: true,
      elements: chatList,
      groupBy: (Chat chat) =>
          DateTime(chat.dateTime.year, chat.dateTime.month, chat.dateTime.day),
      groupHeaderBuilder: (Chat chat) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Align(
          child: Container(
            width: 145,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
                child: Text(
              "${chat.dateTime.year}년 ${chat.dateTime.month}월 ${chat.dateTime.day}일 (${intToWeekday(chat.dateTime.weekday)})",
            )),
          ),
        ),
      ),
      indexedItemBuilder: (context, Chat chat, index) {
        return ChatBubble(chat.chat, chat.sender == 'me', chat.dateTime.hour,
            chat.dateTime.minute);
      },
    );
  }
}

String intToWeekday(int num) {
  if (num == 1) {
    return "월";
  }
  if (num == 2) {
    return "화";
  }
  if (num == 3) {
    return "수";
  }
  if (num == 4) {
    return "목";
  }
  if (num == 5) {
    return "금";
  }
  if (num == 6) {
    return "토";
  }
  if (num == 7) {
    return "일";
  }
  return "오류";
}
