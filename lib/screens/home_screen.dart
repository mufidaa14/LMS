import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna Tema Utama
    final Color primaryDark = const Color(0xFF800000); 
    final Color primaryLight = const Color(0xFFA00000); 

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Background abu sangat muda (Clean)
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===========================
            // 1. HEADER MODERN (CURVED)
            // ===========================
            Stack(
              children: [
                // Dekorasi lingkaran transparan (Aesthetic touch) - Moved to TOP to be BEHIND content
                Positioned(
                  top: -60,
                  right: -60,
                  child: Container(
                    width: 200, height: 200,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                  ),
                ),

                ClipPath(
                  clipper: HomeHeaderClipper(),
                  child: Container(
                    height: 220, // Agak tinggi untuk estetik
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryDark, primaryLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SafeArea( // Agar tidak tertutup status bar
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
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
                                      'Selamat Datang,',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'FIDAAAAA',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                // Profile Pill
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(context, '/profile'),
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.school, color: Colors.white, size: 20),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'MAHASISWA',
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ===========================
            // 2. KONTEN (Tumpang Tindih Header)
            // ===========================
            // Kita kurangi offset minusnya karena header sudah dipendekkan user (180px)
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Card Tugas (Hero Card) ---
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 12, top: 35),
                      child: Text(
                        'Tugas Prioritas',
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF4E5), // Orange muda
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'UI/UX Android Mobile Game',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Mata Kuliah: Desain Antarmuka',
                                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 16, color: Colors.red[400]),
                                    const SizedBox(width: 6),
                                    const Text(
                                      'Jumat, 23:59 WIB',
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.red),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Segera Kumpulkan',
                                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // --- Pengumuman Section ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pengumuman',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        TextButton(
                          onPressed: () {
                             Navigator.pushNamed(context, '/announcement_list');
                          },
                          child: Text('Lihat Semua', style: TextStyle(color: primaryDark)),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.campaign_outlined, color: Colors.blue[800]),
                        ),
                        title: const Text('Maintenance Sistem', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('Server akan down sementara pada hari libur...'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // --- Progres Kelas (List) ---
                    const Text(
                      'Progres Akademik',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Semester 7 - 2024/2025',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    
                    // GENERATED SUBJECT LIST
                    ..._buildSubjectList(primaryDark),
                    
                    const SizedBox(height: 40), // Bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // BOTTOM NAVIGATION (Keeping original style but cleaner)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
          ]
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
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Kelas'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded), label: 'Notifikasi'),
          ],
        ),
      ),
    );
  }

  // BUILDER LIST MATA KULIAH
  List<Widget> _buildSubjectList(Color themeColor) {
    // DATA BARU (Sesuai Request User)
    final subjects = [
      {
        'name': 'SISTEM CERDAS',
        'code': 'MKK020127',
        'progress': 0.9,
        'semester': 'Semester 7',
        'status': 'Approved'
      },
      {
        'name': 'SEMINAR TUGAS AKHIR',
        'code': 'MPB020102',
        'progress': 0.8,
        'semester': 'Semester 7',
        'status': 'Approved'
      },
      {
        'name': 'PENGAMAN SISTEM CYBER',
        'code': 'MKK020124',
        'progress': 0.75,
        'semester': 'Semester 7',
        'status': 'Approved'
      },
      {
        'name': 'MOBILE PROGRAMMING LANJUT',
        'code': 'MKB020122',
        'progress': 0.85,
        'semester': 'Semester 7',
        'status': 'Approved'
      },
      {
        'name': 'APLIKASI SISTEM INFORMASI GEOGRAFIS',
        'code': 'MKB020117',
        'progress': 0.70,
        'semester': 'Semester 7',
        'status': 'Approved'
      },
    ];

    return subjects.map((subject) {
      double progress = subject['progress'] as double;
      int percent = (progress * 100).toInt();

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Box
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        (subject['code'] as String).substring(0, 3), // Ambil 3 huruf kode depan
                        style: TextStyle(
                          color: themeColor, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 12
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                              subject['code'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w500),
                             ),
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                               decoration: BoxDecoration(
                                 color: Colors.green[50], 
                                 borderRadius: BorderRadius.circular(4)
                               ),
                               child: Text("Aktif", style: TextStyle(fontSize: 10, color: Colors.green[700])),
                             )
                           ],
                         ),
                         const SizedBox(height: 4),
                         Text(
                          subject['name'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, height: 1.2),
                         ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              
              // Progress Bar Modern
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: Colors.grey[100],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress > 0.85 ? Colors.green : (progress > 0.75 ? themeColor : Colors.orange),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$percent%',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }).toList();
  }
}

// Custom Clipper untuk Header Curve
class HomeHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    // Lengkungan cembung ke bawah
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - 50);
    
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}