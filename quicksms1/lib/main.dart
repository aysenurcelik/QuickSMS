import 'package:flutter/material.dart';
import 'package:quicksms1/views/message_list.dart';
import 'package:share/share.dart';
import 'inherited_widgets/message_inherited_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MessageInheritedWidget(
      MaterialApp(
        title: 'Message',
        home: MessageList(),
      ),
    );
  }
}
