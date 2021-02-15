import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicksms1/main.dart';
import 'package:quicksms1/inherited_widgets/message_inherited_widgets.dart';
import 'package:quicksms1/providers/message_provider.dart';
import 'package:quicksms1/views/message_list.dart';

enum MessageMode { Editing, Adding }

class Message extends StatefulWidget {
  final MessageMode messageMode;
  final Map<String, dynamic> message;
  Message(this.messageMode, this.message);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  List<Map<String, String>> get _message =>
      MessageInheritedWidget.of(context).message;

  @override
  void didChangeDependencies() {//title text 2. sayfaya gel
    if (widget.messageMode == MessageMode.Editing) {
      print(_titleController.text);
      _titleController.text = widget.message['title'];
      _textController.text = widget.message['text'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.messageMode == MessageMode.Adding
              ? 'Add Message'
              : 'Edit Message')),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Message title'),
            ),
            Container(
              height: 8,
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: 'Message text'),
            ),
            Container(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _MessageButton("Save", Colors.blue, () {
                  setState(() {
                    final title = _titleController.text;
                    final text = _textController.text;
                    if (widget?.messageMode == MessageMode.Adding) {
                      MessageProvider.insertMessage(
                          {'title': title, 'text': text});
                    } else if (widget?.messageMode == MessageMode.Editing) {
                      MessageProvider.updateMessage({
                        'id': widget.message['id'],
                        'title': _titleController.text,
                        'text': _textController.text,
                      });
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MessageList()));
                  });
                }),
                Container(height: 15.0),
                _MessageButton("Discard", Colors.yellow, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MessageList()));
                }),
                widget.messageMode == MessageMode.Editing
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: _MessageButton("Delete", Colors.red, () async {
                          await MessageProvider.deleteMessage(
                              widget.message['id']);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessageList()));
                        }),
                      )
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _MessageButton extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function _onPressed;

  _MessageButton(this._text, this._color, this._onPressed);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: 100,
      height: 40,
      color: _color,
    );
  }
}
