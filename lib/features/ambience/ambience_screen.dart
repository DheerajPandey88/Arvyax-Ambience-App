import 'package:flutter/material.dart';
import '../../data/models/ambience_model.dart';
import 'package:arvyax_application/data/models/repositories/ambience_repository.dart';
import 'package:arvyax_application/features/ambience/ambience_details_screen.dart';

class AmbienceScreen extends StatefulWidget {
  const AmbienceScreen({super.key});

  @override
  State<AmbienceScreen> createState() => _AmbienceScreenState();
}

class _AmbienceScreenState extends State<AmbienceScreen> {
  List<Ambience> ambiences = [];
  String search = '';
  String selectedTag = '';

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final data = await AmbienceRepository().loadAmbiences();
    setState(() {
      ambiences = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = ambiences.where((a) {
      return a.title.toLowerCase().contains(search.toLowerCase()) &&
          (selectedTag.isEmpty || a.tag == selectedTag);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("🎧 Discover"),
        centerTitle: true,
      ),

      /// 🎵 MINI PLAYER (BOTTOM)
      bottomNavigationBar: Container(
        height: 65,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: const [
            SizedBox(width: 10),
            Icon(Icons.music_note, color: Colors.white),
            SizedBox(width: 10),
            Text("Now Playing", style: TextStyle(color: Colors.white)),
            Spacer(),
            Icon(Icons.play_arrow, color: Colors.white),
            SizedBox(width: 10),
          ],
        ),
      ),

      body: Column(
        children: [
          /// 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (v) => setState(() => search = v),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search ambience...",
                prefixIcon:
                    const Icon(Icons.search, color: Colors.white54),
              ),
            ),
          ),

          /// 🎯 FILTER CHIPS
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ["Focus", "Calm", "Sleep", "Reset"]
                  .map((tag) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChoiceChip(
                          label: Text(tag),
                          selected: selectedTag == tag,
                          selectedColor: Colors.deepPurple,
                          onSelected: (_) {
                            setState(() {
                              selectedTag =
                                  selectedTag == tag ? '' : tag;
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),

          /// 🎧 LIST
          Expanded(
            child: filtered.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No ambiences found",
                          style: TextStyle(color: Colors.white)),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            search = '';
                            selectedTag = '';
                          });
                        },
                        child: const Text("Clear Filters"),
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final a = filtered[i];

                      /// 🎨 PREMIUM CARD
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AmbienceDetailsScreen(ambience: a),
                            ),
                          );
                        },
                        child: Container(
                          height: 160,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(a.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.end,
                              children: [
                                Text(
                                  a.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${a.tag} • ${a.duration}s",
                                  style: const TextStyle(
                                      color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}