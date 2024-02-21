import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.actionTitle,
  });

  final TextEditingController title;
  final TextEditingController description;
  final VoidCallback onTap;
  final String actionTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DInput(
            controller: title,
            title: 'Title',
          ),
          const SizedBox(height: 16),
          DInput(
            controller: description,
            title: 'Description',
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onTap,
            child: Text(actionTitle),
          )
        ],
      ),
    );
  }
}
