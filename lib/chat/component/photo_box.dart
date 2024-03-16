import 'package:flutter/material.dart';
import 'package:hackmaster/chat/models/chat_model.dart';

// ignore: must_be_immutable
class PhotoBox extends StatelessWidget {
  ChatModel chatModel;
  PhotoBox({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Column(children: [
          Container(
            child: Image.file(
              chatModel.file!,
              fit: BoxFit.cover,
              semanticLabel: 'Image',
            ),
            width: 200,
          ),
          Container(
            child: Text(chatModel.text),
          )
        ]),
      ),
    );
  }
}
