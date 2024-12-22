import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Edukasi',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const VideoListScreen(),
    );
  }
}

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final List<Map<String, String>> videos = const [
    {
      'title': 'SISTEM PERTANIAN BERKELANJUTAN : SOLUSI MASA DEPAN',
      'thumbnail': 'https://img.youtube.com/vi/0cGDOSW4W28/default.jpg',
      'videoId': '0cGDOSW4W28',
    },
    // {
    //   'title': 'Video Edukasi Tani 2',
    //   'thumbnail': 'https://via.placeholder.com/150',
    //   'videoId': 'V-_O7nl0Ii0',
    // },
    // {
    //   'title': 'Video Edukasi Tani 3',
    //   'thumbnail': 'https://via.placeholder.com/150',
    //   'videoId': 'kJQP7kiw5Fk',
    // },
    // {
    //   'title': 'Video Edukasi Tani 4',
    //   'thumbnail': 'https://via.placeholder.com/150',
    //   'videoId': '3JZ_D3ELwOQ',
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Edukasi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Tambahkan logika untuk pencarian
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: video['thumbnail']!,
                width: 100,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(video['thumbnail']!),
              subtitle: const Text('20:12'), // Bisa diubah sesuai data
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  // Tambahkan logika untuk download video
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      videoId: video['videoId']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            aspectRatio: 16 / 9, // Menyesuaikan aspek rasio video
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}