import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicksms1/views/message.dart';
import 'package:quicksms1/inherited_widgets/message_inherited_widgets.dart';
import 'package:share/share.dart';
import 'package:quicksms1/providers/message_provider.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    //print(_message.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickSMS"),
      ),
      body: FutureBuilder(
        future: MessageProvider.getMessageList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final messages = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                //list için bir const
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Message(MessageMode.Editing, messages[index])));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, bottom: 30.0, left: 13.0, right: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _MessageTitle(messages[index]['title']),
                          Container(height: 4),
                          _MessageText(messages[index]['text']),
                          GestureDetector(
                            child: Icon(
                              Icons.send,
                              color: Colors.red,
                            ),
                            onTap: () {
                              Share.share('${messages[index]['text']}');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: messages.length,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Message(MessageMode.Adding, null)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _MessageTitle extends StatelessWidget {
  final String _title;
  _MessageTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}

class _MessageText extends StatelessWidget {
  final String _text;
  _MessageText(this._text);
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(color: Colors.grey.shade600),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
