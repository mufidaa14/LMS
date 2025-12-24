import 'package:flutter/material.dart';

class ClassListScreen extends StatelessWidget {
  const ClassListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Real Data from User Image
    final List<Map<String, dynamic>> classes = [
      {
        'name': 'SISTEM CERDAS',
        'lecturer': 'MIFTAHUL WALID, S.Kom., MT',
        'class_info': 'Semester 7 - C 22S',
        'progress': 0.7,
        'code': 'MKK020127',
        'schedule': 'Selasa, 10:50 - 12:30',
        'room': 'LAB-3 TI',
      },
      {
        'name': 'SEMINAR TUGAS AKHIR',
        'lecturer': 'Dr. HOZAIRI, S.ST., M.T',
        'class_info': 'Semester 7 - C 22S',
        'progress': 0.9,
        'code': 'MPB020102',
        'schedule': 'Senin, 10:50 - 12:30',
        'room': 'RUANG-3 TI',
      },
      {
        'name': 'PENGAMAN SISTEM CYBER',
        'lecturer': 'MASDUKIL MAKRUF, S.Kom., M.T',
        'class_info': 'Semester 7 - C 22S',
        'progress': 0.5,
        'code': 'MKK-020124',
        'schedule': 'Rabu, 12:30 - 14:10',
        'room': 'LAB-2 TI',
      },
      {
        'name': 'MOBILE PROGRAMING LANJUT',
        'lecturer': 'ROFIUDDIN, M. Kom',
        'class_info': 'Semester 7 - C 22S',
        'progress': 0.8,
        'code': 'MKB020122',
        'schedule': 'Selasa, 14:10 - 15:50',
        'room': 'LAB-1 TI',
      },
      {
        'name': 'APLIKASI SISTEM INFORMASI GEOGRAFIS',
        'lecturer': 'ARY ISWAHYUDI, S.Si.,M.T',
        'class_info': 'Semester 7 - C 22S',
        'progress': 0.6,
        'code': 'MKB020117',
        'schedule': 'Jumat, 12:30 - 14:10',
        'room': 'RUANG-3 TI',
      },
    ];

    final Color primaryDark = const Color(0xFF800000);
    final Color primaryLight = const Color(0xFFA00000);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Stack(
        children: [
          // 2. Class List Content
          Padding(
            padding: const EdgeInsets.only(top: 80), // Space for header
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                return _buildClassCard(context, classes[index], primaryDark);
              },
            ),
          ),

          // 1. Straight Header (80px)
          Container(
            height: 80,
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                   const Text(
                    'Kelas Saya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: primaryDark,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // 'Kelas Saya' active
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 2) {
             Navigator.pushReplacementNamed(context, '/notification');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Kelas Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
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
          Icon(Icons.school_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Belum ada kelas yang diikuti',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, Map<String, dynamic> data, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/class_detail',
              arguments: data,
            );
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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.book, color: primaryColor, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.2
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['code'],
                            style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, thickness: 1),
                const SizedBox(height: 16),
                
                // Info Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(Icons.person_outline, data['lecturer']),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Info Grid - Stacked Vertically
                _buildInfoItem(Icons.calendar_today_outlined, data['schedule']),
                const SizedBox(height: 8),
                _buildInfoItem(Icons.location_on_outlined, data['room']),
                const SizedBox(height: 16),
                
                 // Semester Badge & Progress
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                       decoration: BoxDecoration(
                         color: Colors.grey[100],
                         borderRadius: BorderRadius.circular(8),
                         border: Border.all(color: Colors.grey[300]!),
                       ),
                       child: Text(
                         data['class_info'], // Semester Info
                         style: TextStyle(fontSize: 11, color: Colors.grey[700], fontWeight: FontWeight.bold),
                       ),
                     ),

                     const SizedBox(width: 16), // Spacing between semester and progress
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text(
                             '${(data['progress'] * 100).toInt()}% Selesai',
                             style: TextStyle(fontSize: 10, color: primaryColor, fontWeight: FontWeight.bold),
                           ),
                           const SizedBox(height: 4),
                           ClipRRect(
                             borderRadius: BorderRadius.circular(2),
                             child: LinearProgressIndicator(
                               value: data['progress'],
                               backgroundColor: Colors.grey[200],
                               valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                               minHeight: 6, // Slightly thicker
                             ),
                           ),
                         ],
                       ),
                     )
                   ],
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
