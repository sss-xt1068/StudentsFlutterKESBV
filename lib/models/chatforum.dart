import 'package:flutter/material.dart';

class ChatForum extends StatefulWidget {
  @override
  _ChatForumState createState() => _ChatForumState();
}

class _ChatForumState extends State<ChatForum>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<TextStyle> chatStyles = [
    TextStyle(
      fontFamily: 'Comfortaa',
      fontWeight: FontWeight.bold,
      fontSize: 22,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Forum'),
      ),
      body: Center(
        child: Text('Welcome to the chat forum!', style: chatStyles[0]),
      ),
    );
  }
}
