// ignore_for_file: prefer_const_constructors, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackmaster/quiz/constants.dart';
import 'package:hackmaster/quiz/controllers/question_controllers.dart';
import 'package:hackmaster/quiz/models/question.dart';

import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required Key key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () => _controller.checkAns(question, index),
              key: ValueKey<String>(
                  'option_$index'), // Use ValueKey with a unique identifier
            ),
          ),
        ],
      ),
    );
  }
}
