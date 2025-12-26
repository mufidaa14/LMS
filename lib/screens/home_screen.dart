import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna Tema Utama
    final Color primaryDark = const Color(0xFF800000); 
    final Color primaryLight = const Color(0xFFA00000); 

// ... (Keeping imports and class definition)

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Slightly cleaner white-grey
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===========================
            // 1. HEADER MODERN (IMPROVED)
            // ===========================
            Stack(
              children: [
                // Background Pattern/Gradient
                ClipPath(
                  clipper: HomeHeaderClipper(),
                  child: Container(
                    height: 240, 
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryDark, const Color(0xFFB71C1C)], // Richer gradient
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                         // Decorative Circles
                         Positioned(
                           top: -50, right: -50,
                           child: Container(
                             width: 200, height: 200,
                             decoration: BoxDecoration(
                               color: Colors.white.withOpacity(0.05),
                               shape: BoxShape.circle
                             ),
                           ),
                         ),
                         Positioned(
                           bottom: 50, left: -20,
                           child: Container(
                             width: 100, height: 100,
                             decoration: BoxDecoration(
                               color: Colors.white.withOpacity(0.05),
                               shape: BoxShape.circle
                             ),
                           ),
                         ),
                      ],
                    ),
                  ),
                ),

                // Content
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0), // Adjusted padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamat Pagi,',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'FIDAAAAA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(context, '/profile'),
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'MAHASISWA',
                                        style: TextStyle(
                                          color: Colors.white, 
                                          fontSize: 12, 
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.person, color: Colors.white, size: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Status Card (Floating inside Header)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.school, color: Colors.white, size: 28),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Semester 7',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Mahasiswa Aktif',
                                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '2024/2025',
                                  style: TextStyle(color: primaryDark, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ===========================
            // 2. MAIN CONTENT
            // ===========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  
                  // Priority Task - Improved Look
                  Row(
                    children: [
                      const Text(
                        'Tugas Prioritas',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_forward, size: 18, color: primaryDark)
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 5))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF3E0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.warning_rounded, color: Colors.orange, size: 24),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('UI/UX Android Game', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    SizedBox(height: 4),
                                    Text('Desain Antarmuka', style: TextStyle(color: Colors.grey, fontSize: 13)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.timer, size: 14, color: Colors.red[700]),
                                    const SizedBox(width: 6),
                                    Text('Jumat, 23:59', style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Text('Segera Kumpulkan', style: TextStyle(fontSize: 12, color: Colors.grey[500]))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Announcements - Carousel Style
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pengumuman',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                             Navigator.pushNamed(context, '/announcement_list');
                          },
                          child: Text('Lihat Semua', style: TextStyle(color: primaryDark)),
                        )
                      ],
                    ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: Row(
                      children: [
                        _buildAnnouncementCard(
                          primaryDark, 
                          icon: Icons.campaign_rounded, 
                          title: 'Maintenance', 
                          date: '20 Des',
                          color: Colors.blue
                        ),
                        const SizedBox(width: 12),
                         _buildAnnouncementCard(
                          primaryDark, 
                          icon: Icons.calendar_today_rounded, 
                          title: 'Libur Akhir Tahun', 
                          date: '25 Des',
                          color: Colors.orange
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Academic Progress - Detailed List
                  const Text(
                    'Kelas & Progres',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
                  ..._buildSubjectList(primaryDark),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: primaryDark,
          unselectedItemColor: Colors.grey[400],
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushReplacementNamed(context, '/class_list');
            } else if (index == 2) {
               Navigator.pushReplacementNamed(context, '/notification');
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Kelas'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined), label: 'Notifikasi'),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(Color primary, {required IconData icon, required String title, required String date, required Color color}) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(date, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildSubjectList(Color themeColor) {
    // ENHANCED DATA (Added details)
    final subjects = [
      {
        'name': 'SISTEM CERDAS',
        'code': 'MKK020127',
        'progress': 0.9,
        'lecturer': 'MIFTAHUL WALID, S.Kom., MT',
        'schedule': 'Selasa, 10:50 - 12:30',
        'room': 'LAB-3 TI',
      },
      {
        'name': 'SEMINAR TUGAS AKHIR',
        'code': 'MPB020102',
        'progress': 0.8,
        'lecturer': 'Dr. HOZAIRI, S.ST., M.T',
        'schedule': 'Senin, 10:50 - 12:30',
        'room': 'RUANG-3 TI',
      },
      {
        'name': 'PENGAMAN SISTEM CYBER',
        'code': 'MKK020124',
        'progress': 0.75,
        'lecturer': 'MASDUKIL MAKRUF, S.Kom., M.T',
        'schedule': 'Rabu, 12:30 - 14:10',
        'room': 'LAB-2 TI',
      },
       {
        'name': 'MOBILE PROGRAMMING LANJUT',
        'code': 'MKB020122',
        'progress': 0.85,
        'lecturer': 'ROFIUDDIN, M. Kom',
        'schedule': 'Selasa, 14:10 - 15:50',
        'room': 'LAB-1 TI',
      },
    ];

    return subjects.map((subject) {
      double progress = subject['progress'] as double;
      int percent = (progress * 100).toInt();

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: InkWell(
          onTap: (){},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Box
                    Container(
                      width: 45, height: 45,
                      decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          (subject['code'] as String).substring(0, 1), 
                          style: TextStyle(
                            color: themeColor, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            subject['name'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                           ),
                           const SizedBox(height: 4),
                           Text(
                             subject['code'] as String,
                             style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                           ),
                        ],
                      ),
                    )
                  ],
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),

                // DETAILS SECTION (Lecturer, Schedule, etc.)
                _buildDetailRow(Icons.person_outline_rounded, subject['lecturer'] as String),
                const SizedBox(height: 8),
                _buildDetailRow(Icons.access_time_rounded, subject['schedule'] as String),
                const SizedBox(height: 8),
                _buildDetailRow(Icons.location_on_outlined, subject['room'] as String),
                
                const SizedBox(height: 20),

                // Progress Bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: Colors.grey[100],
                          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$percent%',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[400]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text, 
            style: TextStyle(color: Colors.grey[700], fontSize: 13),
            overflow: TextOverflow.ellipsis,
          )
        )
      ],
    );
  }
}

class HomeHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    
    // Wave
    var controlPoint1 = Offset(size.width * 0.25, size.height);
    var endPoint1 = Offset(size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);

    var controlPoint2 = Offset(size.width * 0.75, size.height - 40);
    var endPoint2 = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}