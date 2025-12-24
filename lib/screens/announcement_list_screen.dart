import 'package:flutter/material.dart';

class AnnouncementListScreen extends StatelessWidget {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<Map<String, String>> announcements = [
      {
        'title': 'Perubahan Jadwal Perkuliahan Semester Ganjil',
        'date': '12 Desember 2025',
        'content': 'Diberitahukan kepada seluruh mahasiswa bahwa jadwal perkuliahan untuk semester ganjil akan mengalami perubahan efektif mulai minggu depan. Harap cek jadwal terbaru di menu Kelas Saya.',
      },
      {
        'title': 'Maintenance Server LMS',
        'date': '10 Desember 2025',
        'content': 'Server LMS akan mengalami maintenance pada hari Sabtu, 14 Desember 2025 pukul 00:00 - 04:00 WIB. Mohon maaf atas ketidaknyamanan ini.',
      },
      {
        'title': 'Pendaftaran Wisuda Periode I',
        'date': '05 Desember 2025',
        'content': 'Pendaftaran wisuda untuk periode I tahun 2026 telah dibuka. Mahasiswa tingkat akhir diharapkan segera melengkapi berkas sebelum tanggal 20 Desember 2025.',
      },
    ];

    final Color primaryDark = const Color(0xFF800000);
    final Color primaryLight = const Color(0xFFA00000);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Stack(
        children: [
          // 1. Curved Header
          // 1. Straight Header (No ClipPath)
          Container(
            height: 80, // Smaller & Straight
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryDark, primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Back Button (Left) - Beautified
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                    ),
                    
                    // Title & Subtitle (Center)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Pengumuman',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Informasi Terbaru Kampus',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. List Content
          Padding(
            padding: const EdgeInsets.only(top: 100), // Adjusted for straight header
            child: announcements.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    itemCount: announcements.length,
                    itemBuilder: (context, index) {
                      return _buildAnnouncementCard(context, announcements[index], primaryDark);
                    },
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.campaign_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Belum ada pengumuman',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, Map<String, String> data, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/announcement_detail', arguments: data);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.notifications_active_outlined, color: primaryColor, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data['date']!,
                            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  data['content']!,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.5),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'BACA SELENGKAPNYA',
                      style: TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 14, color: primaryColor)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


