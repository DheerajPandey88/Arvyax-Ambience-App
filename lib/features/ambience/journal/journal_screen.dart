import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arvyax_application/data/models/journal_model.dart';
import 'journal_controller.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController controller = TextEditingController();
  String mood = "Calm";

  final List<String> moods = [
    "Calm",
    "Grounded",
    "Energized",
    "Sleepy"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🧘 Reflection"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✨ TITLE
            const Text(
              "What is gently present with you right now?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            /// 📝 INPUT BOX (PREMIUM)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: controller,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Write your thoughts...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 😊 MOOD SELECT (CHIPS STYLE)
            const Text(
              "How do you feel?",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: moods.map((m) {
                return ChoiceChip(
                  label: Text(m),
                  selected: mood == m,
                  selectedColor: Colors.deepPurple,
                  onSelected: (_) {
                    setState(() {
                      mood = m;
                    });
                  },
                );
              }).toList(),
            ),

            const Spacer(),

            /// 💾 SAVE BUTTON (FULL WIDTH)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (controller.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please write something"),
                      ),
                    );
                    return;
                  }

                  context.read<JournalController>().add(
                        Journal(
                          text: controller.text.trim(),
                          mood: mood,
                          date: DateTime.now(),
                          ambience: "Session",
                        ),
                      );

                  Navigator.pop(context);
                },
                child: const Text(
                  "Save Reflection",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}