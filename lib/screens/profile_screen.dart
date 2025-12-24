import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Color primaryDark = const Color(0xFF800000); 
  final Color primaryLight = const Color(0xFFA00000); 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Match Home background
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===========================
            // 1. HEADER & PROFILE
            // ===========================
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // A. Curved Header Background
                ClipPath(
                  clipper: ProfileHeaderClipper(),
                  child: Container(
                    height: 260,
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
                        padding: const EdgeInsets.only(top: 16, left: 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pushReplacementNamed('/home'),
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // B. Decorative Circles (Optional consistency)
                Positioned(
                  top: -50, right: -50,
                  child: Container(
                    width: 150, height: 150,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                  ),
                ),

                // C. Profile Image & Name (Centered)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Wrap content height
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                            child: Icon(Icons.person, size: 60, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'FIDAAAAA', // Name
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            
            // Status Badge (Below Header)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Mahasiswa Aktif',
                style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20), // Spacer before Tabs

            // ===========================
            // 2. TAB MENU
            // ===========================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: primaryDark,
                  borderRadius: BorderRadius.circular(25),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                dividerColor: Colors.transparent,
                padding: const EdgeInsets.all(6),
                tabs: const [
                  Tab(text: 'About Me'),
                  Tab(text: 'Kelas'),
                  Tab(text: 'Edit Profile'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ===========================
            // 3. TAB CONTENT
            // ===========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 600, // Fixed height or constraints
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildAboutMeTab(),
                    _buildKelasTab(),
                    _buildEditProfileTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Matches Home Bottom Nav
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
          currentIndex: 0, // No specific active tab for Profile usually, or treat as Home
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (index) {
            if (index == 0) Navigator.pushReplacementNamed(context, '/home');
            else if (index == 1) Navigator.pushReplacementNamed(context, '/class_list');
            else if (index == 2) Navigator.pushReplacementNamed(context, '/notification');
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

  // --- TAB 1: ABOUT ME ---
  Widget _buildAboutMeTab() {
    return Column(
      children: [
        _buildInfoCard('Informasi User', [
          _buildInfoRow(Icons.email_outlined, 'Email', 'dandycandra365@telkomuniversity.ac.id'),
          _buildInfoRow(Icons.school_outlined, 'Program Studi', 'D4 Teknologi Rekayasa Multimedia'),
          _buildInfoRow(Icons.domain_outlined, 'Fakultas', 'FIT'),
        ]),
        const SizedBox(height: 20),
        _buildInfoCard('Aktivitas Login', [
          _buildInfoRow(Icons.calendar_today_outlined, 'First Access', 'Monday, 7 September 2020'),
          _buildInfoRow(Icons.access_time, 'Last Access', 'Now'),
        ]),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryDark)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[400]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- TAB 2: KELAS ---
  Widget _buildKelasTab() {
    final classes = [
      {'name': 'DESAIN ANTARMUKA', 'code': 'D4SM-41-04', 'schedule': 'Senin, 08:00 - 10:00'},
      {'name': 'KEWARGANEGARAAN', 'code': 'D4SM-41-04', 'schedule': 'Selasa, 10:00 - 12:00'},
      {'name': 'SISTEM OPERASI', 'code': 'D4SM-41-04', 'schedule': 'Rabu, 13:00 - 15:00'},
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final cls = classes[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: primaryDark.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.book, color: primaryDark),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cls['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(cls['schedule']!, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- TAB 3: EDIT PROFILE ---
  Widget _buildEditProfileTab() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _buildModernInput('Nama Depan', 'Nama Depan'),
          const SizedBox(height: 16),
          _buildModernInput('Nama Belakang', 'Nama Belakang'),
          const SizedBox(height: 16),
          _buildModernInput('Email', 'Email', icon: Icons.email_outlined),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryDark,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                shadowColor: primaryDark.withOpacity(0.4),
              ),
              child: const Text('Simpan Perubahan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildModernInput(String label, String placeholder, {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: icon != null ? Icon(icon, color: primaryDark.withOpacity(0.6), size: 20) : null,
            filled: true,
            fillColor: const Color(0xFFF9F9F9),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        )
      ],
    );
  }
}

// HEADER CLIPPER
class ProfileHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    // Cembung ke bawah
    var controlPoint = Offset(size.width / 2, size.height + 30);
    var endPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}