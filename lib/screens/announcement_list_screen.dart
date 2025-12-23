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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Pengumuman',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB71C1C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: announcements.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                return _buildAnnouncementCard(context, announcements[index]);
              },
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
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, Map<String, String> data) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/announcement_detail',
            arguments: data,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
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
                    const SizedBox(height: 8),
                    Text(
                      data['date']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data['content']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
