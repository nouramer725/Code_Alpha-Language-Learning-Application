import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const QuizCard({
    Key? key,
    required this.question,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...options.map((option) {
              return ElevatedButton(
                onPressed: () => onSelected(option),
                child: Text(option),
              );
            })
          ],
        ),
      ),
    );
  }
}
