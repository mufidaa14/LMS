import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _showOverlay = true; 
  String? _errorMessage; // To store error message

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/UI Design.mp4')
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _errorMessage = null; 
        });
      }).catchError((error) {
        debugPrint("Error initializing video: $error");
        setState(() {
          _errorMessage = "Gagal memuat video: $error";
        });
      });
      
    _controller.addListener(() {
      final isPlaying = _controller.value.isPlaying;
      if (isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
          if (_isPlaying) {
            _showOverlay = false; // Hide overlay when playing starts
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (!_isInitialized) return;

    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showOverlay = true; // Show overlay again on pause if desired, or keep it off. 
                             // Let's keep it off to see the paused frame, but maybe show the big play button?
                             // User wants specific "UI DESIGN" look. Let's make the "UI DESIGN" text part of the "Cover".
      } else {
        _controller.play();
        _showOverlay = false;
      }
    });
  }

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Video Player Area
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                   // 1. The Video Player (Visible if initialized)
                  if (_isInitialized)
                    VideoPlayer(_controller)
                  else if (_errorMessage != null)
                    Container(
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    )
                  else
                    Container(
                      color: Colors.black,
                      child: const Center(child: CircularProgressIndicator(color: Colors.red)),
                    ),

                  // 2. The Custom Overlay (UI DESIGN Text)
                  if (_showOverlay) ...[
                    Container(color: Colors.black.withOpacity(0.4)), // Darker Tint for better contrast
                    
                    const Positioned(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Text(
                             'UI',
                             style: TextStyle(
                               color: Colors.white, 
                               fontSize: 60, // Larger
                               fontWeight: FontWeight.w900, 
                               letterSpacing: 4
                             ),
                           ),
                           Text(
                             'DESIGN',
                             style: TextStyle(
                               color: Colors.white, 
                               fontSize: 40, // Larger
                               fontWeight: FontWeight.w900, 
                               letterSpacing: 8
                             ),
                           ),
                        ],
                      ),
                    ),
                  ],

                  // 3. Play Button
                  if (!_isPlaying)
                    GestureDetector(
                      onTap: _togglePlay,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFB71C1C).withOpacity(0.9), // Match App Red
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
                      ),
                    ),

                   // 4. Progress Bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _isInitialized 
                      ? VideoProgressIndicator(
                          _controller, 
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: const Color(0xFFB71C1C),
                            bufferedColor: Colors.white.withOpacity(0.5),
                            backgroundColor: Colors.white.withOpacity(0.3),
                          ),
                        )
                      : LinearProgressIndicator(
                          value: 0,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          color: const Color(0xFFB71C1C),
                          minHeight: 4,
                        ),
                  ),
                  
                  if (!_showOverlay)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                               _controller.pause(); 
                            } else {
                               _controller.play();
                            }
                          });
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(),
                      ),
                    ),
                ],
              ),
            ),
            
            // "Video Lain Nya" Header
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
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
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildVideoItem(
                  title: 'Interaction Design',
                  duration: '10:25',
                  thumbnailColor: const Color(0xFF5C6BC0), 
                  icon: Icons.person,
                  onTap: () {}
                ),
                _buildVideoItem(
                  title: 'Pengantar Desain Antarmuka Pengguna',
                  duration: '15:30',
                  isSelected: true,
                  thumbnailColor: Colors.white, 
                  isTelkomStyle: true,
                ),
                _buildVideoItem(
                  title: '4 Teori Dasar Desain Antarmuka Pengguna',
                  duration: '12:45',
                  thumbnailColor: Colors.white,
                  isTelkomStyle: true,
                ),
                _buildVideoItem(
                  title: 'Tutorial Dasar Figma - UI/UX Design Software',
                  duration: '20:10',
                  thumbnailColor: const Color(0xFF2E7D32),
                  icon: Icons.design_services, 
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoItem({
    required String title,
    required String duration,
    Color thumbnailColor = Colors.grey,
    IconData? icon,
    bool isSelected = false,
    bool isTelkomStyle = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        color: Colors.white, // Ensure background is white
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Container(
              width: 140, // Wider thumbnail
              height: 80,
              decoration: BoxDecoration(
                color: thumbnailColor,
                boxShadow: [
                  if (isTelkomStyle)
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
                ]
              ), 
              child: isTelkomStyle 
                ? Stack(
                    children: [
                       // Red bar at top left for style
                       Positioned(top: 0, left: 0, child: Container(width: 40, height: 4, color: Colors.red)),
                       Center(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.school, color: Colors.red[900], size: 28),
                             const SizedBox(height: 4),
                             const Text("Universitas\nTelkom", textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.bold, height: 1.1))
                           ],
                         ),
                       ),
                       // Play icon overlay
                       Center(child: Icon(Icons.play_circle_fill, color: Colors.red.withOpacity(0.8), size: 32)),
                    ],
                  )
                : Stack(
                    children: [
                      Center(
                        child: Icon(icon ?? Icons.play_circle_fill, color: Colors.white54, size: 40),
                      ),
                      // Duration badge
                      Positioned(
                        bottom: 4, right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          color: Colors.black87,
                          child: Text(duration, style: const TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      )
                    ]
                  ),
            ),
            const SizedBox(width: 16),
            // Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.3
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
