import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna Tema Utama (Sama dengan HomeScreen)
    final Color primaryDark = const Color(0xFF800000);
    final Color primaryLight = const Color(0xFFA00000);

    // Dummy Data
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Tugas Baru Tersedia',
        'description': 'Tugas UI/UX Android Mobile Game telah ditambahkan.',
        'time': '5 menit lalu',
        'isRead': false,
        'type': 'task',
      },
      {
        'title': 'Pengumuman Perkuliahan',
        'description': 'Jadwal kuliah mata kuliah Sistem Operasi mengalami perubahan.',
        'time': '1 jam lalu',
        'isRead': true,
        'type': 'announcement',
      },
      {
        'title': 'Deadline Mendekat',
        'description': 'Tugas Kewarganegaraan berakhir besok malam.',
        'time': 'Kemarin',
        'isRead': true,
        'type': 'alert',
      },
      {
         'title': 'Nilai Keluar',
         'description': 'Nilai UTS Pemrograman Mobile Lanjut telah dipublikasikan.',
         'time': '2 Hari lalu',
         'isRead': true,
         'type': 'grade',
      },
       {
         'title': 'Materi Baru',
         'description': 'Dosen mengunggah materi baru untuk pertemuan minggu depan.',
         'time': '3 Hari lalu',
         'isRead': true,
         'type': 'material',
      }
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Background abu sangat muda (Clean)
      body: Stack(
        children: [
          // ===========================
          // 1. HEADER MODERN (CURVED)
          // ===========================
          // Decoration Background
           Positioned(
             top: -60,
             right: -60,
             child: Container(
               width: 200, height: 200,
               decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
             ),
           ),
           
          ClipPath(
            clipper: NotificationHeaderClipper(),
            child: Container(
              height: 200, // Tinggi header
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryDark, primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Notifikasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Pantau aktivitas terbaru Anda',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ===========================
          // 2. KONTEN LIST
          // ===========================
          Padding(
            padding: const EdgeInsets.only(top: 140), // Offset agar list mulai agak ke atas
            child: notifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    itemCount: notifications.length + 1, // +1 for extra bottom padding
                    itemBuilder: (context, index) {
                      if (index == notifications.length) {
                        return const SizedBox(height: 80); // Spacer bawah
                      }
                      final notif = notifications[index];
                      return _buildNotificationCard(context, notif);
                    },
                  ),
          ),
        ],
      ),
      
      // ===========================
      // 3. BOTTOM NAVIGATION (CONSISTENT)
      // ===========================
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
          ]
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: primaryDark, // Maroon active
          unselectedItemColor: Colors.grey[400],
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: 2, // Index Notifikasi
          elevation: 0,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/class_list');
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.school_outlined), activeIcon: Icon(Icons.school_rounded), label: 'Kelas'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), activeIcon: Icon(Icons.notifications_rounded), label: 'Notifikasi'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Belum ada notifikasi',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, Map<String, dynamic> notif) {
    bool isRead = notif['isRead'];
    IconData icon;
    Color iconColor;
    Color iconBg;

    switch (notif['type']) {
      case 'task':
        icon = Icons.assignment_outlined;
        iconColor = Colors.orange[800]!;
        iconBg = Colors.orange[50]!;
        break;
      case 'alert':
        icon = Icons.warning_amber_rounded;
        iconColor = Colors.red[800]!;
        iconBg = Colors.red[50]!;
        break;
      case 'grade':
        icon = Icons.grade_outlined;
        iconColor = Colors.green[800]!;
        iconBg = Colors.green[50]!;
        break;
      case 'material':
        icon = Icons.book_outlined;
        iconColor = Colors.purple[800]!;
        iconBg = Colors.purple[50]!;
        break;
      case 'announcement':
      default:
        icon = Icons.campaign_outlined;
        iconColor = Colors.blue[800]!;
        iconBg = Colors.blue[50]!;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : Colors.white, // Bisa dibedakan jika mau, tapi clean white lebih bagus
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: !isRead ? Border.all(color: const Color(0xFF800000).withOpacity(0.2), width: 1.5) : null, // Border tipis untuk unread
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            if (notif['type'] == 'announcement') {
               Navigator.pushNamed(context, '/announcement_list');
            }
             // Add logic for other types if needed
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notif['title'],
                              style: TextStyle(
                                fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8, height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF800000), // Maroon dot
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notif['description'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.4
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        notif['time'],
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper untuk Header Curve
class NotificationHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    
    // Lengkungan cembung ke bawah yang lebih subtle
    var controlPoint = Offset(size.width / 2, size.height + 20);
    var endPoint = Offset(size.width, size.height - 40);
    
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
