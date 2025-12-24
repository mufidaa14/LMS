import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Video - User Interface Design For Beginner',
          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Player Placeholder
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Image
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://img.freepik.com/free-photo/programming-background-with-person-working-with-codes-computer_23-2150010125.jpg'), // Coding/UI background
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Overlay
                Container(color: Colors.black.withOpacity(0.4)),
                // Play Button
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.withOpacity(0.9),
                  ),
                  child: IconButton(
                    iconSize: 50,
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Memulai Video...')));
                    },
                  ),
                ),
                // Text Overlay
                const Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                       Text(
                         'UI',
                         style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 2),
                       ),
                       Text(
                         'DESIGN',
                         style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: 5),
                       ),
                    ],
                  ),
                ),
                 // Progress Bar Placeholder
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    value: 0.3,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    color: Colors.red,
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
          
          // "Video Lain Nya" Header
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text(
              'Video Lain Nya',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          
          // List of Videos
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                _buildVideoItem(
                  title: 'Interaction Design',
                  thumbnailUrl: 'https://img.youtube.com/vi/q1L6s1h1j_g/maxresdefault.jpg', // Placeholder
                  duration: '10:25',
                ),
                _buildVideoItem(
                  title: 'Pengantar Desain Antarmuka Pengguna',
                  thumbnailUrl: 'https://img.youtube.com/vi/5q7z4y6y_w8/maxresdefault.jpg', // Placeholder
                  duration: '15:30',
                  isSelected: true,
                ),
                _buildVideoItem(
                  title: '4 Teori Dasar Desain Antarmuka Pengguna',
                  thumbnailUrl: 'https://img.youtube.com/vi/8y_8_y8_y8/maxresdefault.jpg', // Placeholder
                  duration: '12:45',
                ),
                _buildVideoItem(
                  title: 'Tutorial Dasar Figma - UI/UX Design Software',
                  thumbnailUrl: 'https://img.youtube.com/vi/9z_9_z9_z9/maxresdefault.jpg', // Placeholder
                  duration: '20:10',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoItem({
    required String title,
    required String thumbnailUrl,
    required String duration,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 100,
                  height: 60,
                  color: Colors.grey[300], // Fallback color
                  child: Image.network(
                    thumbnailUrl,
                    width: 100,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.play_circle_outline, color: Colors.grey),
                  ),
                ),
                Container(
                   margin: const EdgeInsets.all(4),
                   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                   color: Colors.black.withOpacity(0.7),
                   child: Text(
                     duration,
                     style: const TextStyle(color: Colors.white, fontSize: 10),
                   ),
                )
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                if (isSelected) 
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Sedang diputar',
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
