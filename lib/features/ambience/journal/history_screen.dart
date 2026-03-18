import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'journal_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  String formatTime(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  @override
  Widget build(BuildContext context) {
    final journals = context.watch<JournalController>().journals;

    return Scaffold(
      appBar: AppBar(
        title: const Text("📓 Journal History"),
        centerTitle: true,
      ),

      body: journals.isEmpty
          ? const Center(
              child: Text(
                "No reflections yet.\nStart a session to begin ✨",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: journals.length,
              itemBuilder: (_, i) {
                final j = journals[i];

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                j.ambience,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                j.text,
                                style: const TextStyle(
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },

                  /// 🎨 PREMIUM CARD
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        /// 🧠 MOOD ICON
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(Icons.self_improvement,
                              color: Colors.white),
                        ),

                        const SizedBox(width: 12),

                        /// 📄 TEXT
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                j.ambience,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "${j.mood} • ${j.text.split('\n').first}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                        ),

                        /// ⏱ TIME
                        Text(
                          formatTime(j.date),
                          style: const TextStyle(
                              color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}