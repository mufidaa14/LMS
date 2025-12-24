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
                  // We remove the opaque background so the video (or placeholder) shows through.
                  // We only add a slight tint for readability.
                  if (_showOverlay) ...[
                    Container(color: Colors.black.withOpacity(0.3)), // Tint
                    
                    const Positioned(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Text(
                             'UI',
                             style: TextStyle(
                               color: Colors.white, 
                               fontSize: 48, 
                               fontWeight: FontWeight.w900, 
                               letterSpacing: 4
                             ),
                           ),
                           Text(
                             'DESIGN',
                             style: TextStyle(
                               color: Colors.white, 
                               fontSize: 36, 
                               fontWeight: FontWeight.w900, 
                               letterSpacing: 8
                             ),
                           ),
                        ],
                      ),
                    ),
                  ],

                  // 3. Play Button (Always visible if not playing)
                  if (!_isPlaying)
                    GestureDetector(
                      onTap: _togglePlay,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.9),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 50),
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
                            playedColor: Colors.red,
                            bufferedColor: Colors.white.withOpacity(0.5),
                            backgroundColor: Colors.white.withOpacity(0.3),
                          ),
                        )
                      : LinearProgressIndicator(
                          value: 0,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          color: Colors.red,
                          minHeight: 4,
                        ),
                  ),
                  
                  // Tap anywhere to toggle play when overlay is gone/playing
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
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'Video Lain Nya',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            
            // List of Videos
            // Removed Expanded, used shrinkWrap
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              children: [
                _buildVideoItem(
                  title: 'Interaction Design',
                  duration: '10:25',
                  thumbnailColor: const Color(0xFF5C6BC0), 
                  icon: Icons.person,
                  onTap: () {
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Memutar video Interaction Design...")));
                  }
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
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.grey[100], 
          borderRadius: BorderRadius.circular(0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Thumbnail
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 120,
                  height: 70,
                  color: thumbnailColor, 
                  child: isTelkomStyle 
                    ? Stack(
                        children: [
                          Positioned(
                            top: 10, right: 10,
                            child: Icon(Icons.school, color: Colors.red[900], size: 20)
                          ),
                          Positioned(
                            bottom: 10, left: 10,
                            child: Text("Telkom\nUniversity", style: TextStyle(fontSize: 8, color: Colors.black87, fontWeight: FontWeight.bold))
                          )
                        ],
                      )
                    : Center(
                        child: Icon(icon ?? Icons.play_circle_fill, color: Colors.white54, size: 30),
                      ),
                ),
                // Youtube Red Play Icon Overlay look-alike
                Positioned.fill(
                  child: Center(
                    child: Container(
                       width: 24, height: 16,
                       decoration: BoxDecoration(
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(4)
                       ),
                       child: const Icon(Icons.play_arrow, color: Colors.white, size: 12),
                    ),
                  )
                ),
              ],
            ),
            const SizedBox(width: 16),
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
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
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
