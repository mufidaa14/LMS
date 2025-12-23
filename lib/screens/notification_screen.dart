import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    ];

    // Toggle this to test empty state
    // final List<Map<String, dynamic>> notifications = [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB71C1C),
        elevation: 0,
        automaticallyImplyLeading: false, // No back button on main tabs
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationCard(context, notif);
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFB71C1C),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 2, // Notification tab active
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/class_list');
          }
           // Index 2 is current
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Kelas Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Belum ada notifikasi',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, Map<String, dynamic> notif) {
    bool isRead = notif['isRead'];
    IconData icon;
    Color iconBg;

    switch (notif['type']) {
      case 'task':
        icon = Icons.assignment;
        iconBg = Colors.orange;
        break;
      case 'alert':
        icon = Icons.warning_amber_rounded;
        iconBg = Colors.redAccent;
        break;
      case 'announcement':
      default:
        icon = Icons.campaign;
        iconBg = Colors.blue;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isRead ? 0 : 2,
      color: isRead ? Colors.white : const Color(0xFFFFF8F8), // Slight tint for unread
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          if (notif['type'] == 'announcement') {
             Navigator.pushNamed(context, '/announcement_list');
          }
          // Add logic for other types if needed
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBg.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconBg, size: 24),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notif['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notif['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        notif['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
