import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageInheritedWidget extends InheritedWidget {
  final message = [
    {'title': 'ggnchhnflaiwfwnflj', 'text': 'fdfsgrwg'},
    {'title': 'vonlrsoba<oinvfvni', 'text': 'someTesbabebxt'},
    {'title': 'jvbfjwfph', 'text': 'brfsbabtenh'}
  ];
  MessageInheritedWidget(Widget child) : super(child: child);
  static MessageInheritedWidget of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<MessageInheritedWidget>());
  }

  @override
  bool updateShouldNotify(MessageInheritedWidget old) {
    return old.message != message;
  }
}
