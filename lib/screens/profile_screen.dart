import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2); // Start at Edit Profile
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Slightly off-white background
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // 1. Header Background & Content
                Container(
                  height: 280, // Extended height to accommodate content
                  width: double.infinity,
                  color: const Color(0xFFB71C1C),
                  padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed('/home');
                            },
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Profile Image
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 55, // 110px diameter
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder
                          child: Icon(Icons.person, size: 60, color: Colors.white), // Fallback
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Name
                      const Text(
                        'DANDY CANDRA PRATAMA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Floating Menu Card
                Container(
                  margin: const EdgeInsets.only(top: 240, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
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
                    indicatorColor: const Color(0xFFB71C1C),
                    indicatorWeight: 3,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: 'About Me'),
                      Tab(text: 'Kelas'),
                      Tab(text: 'Edit Profile'),
                    ],
                  ),
                ),
              ],
            ),
            
            // 3. Tab Content
            // We use a SizedBox to give height, or let it take available space.
            // Since we are in SingleChildScrollView, we need a constrained height if we use TabBarView normally.
            // Alternatively, we can use an AnimatedBuilder or just switch locally if complex.
            // For simplicity and scroll behavior:
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // Calculate height dynamically or give fixed large height
              height: 700, 
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(), // Disable inner scroll
                children: [
                  _buildAboutMeTab(),
                  _buildKelasTab(),
                  _buildEditProfileTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFB71C1C),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 0, // Profile is accessed from Home, but for BottomNav context, keeping 0/none or highlight none? 
        // Actually Profile doesn't have its own tab in the 3-item list (Home, Kelas, Notifikasi).
        // The user hides Profile logic there?
        // Wait, the previous code had 4 items, but I changed it to 3 in the refined profile screen.
        // Let's stick to the 3 items (Home, Kelas, Notifikasi).
        // Since we are on Profile, none should be selected or maybe Home is implicitly parent.
        // But visuals might be confusing if Home is selected.
        // I will use currentIndex: 0 as fallback or maybe not highlight anything if possible, but standard widget requires valid index.
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
             Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
             Navigator.pushReplacementNamed(context, '/class_list');
          } else if (index == 2) {
             Navigator.pushReplacementNamed(context, '/notification');
          }
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

  Widget _buildAboutMeTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi User',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Email address: dandycandra365@telkomuniversity.ac.id'),
          const Text('Program Studi: D4 Teknologi Rekayasa Multimedia'),
          const Text('Fakultas: FIT'),
          const SizedBox(height: 16),
          const Text(
            'Aktivitas Login',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('First access to site: Monday, 7 September 2020, 9:27 AM (285 days 12 hours)'),
          const Text('Last access to site: Tuesday, 22 June 2021, 9:44 PM (now)'),
        ],
      ),
    );
  }

  Widget _buildKelasTab() {
    final classes = [
      {'name': 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA', 'code': 'D4SM-41-04', 'schedule': 'Senin, 08:00 - 10:00'},
      {'name': 'KEWARGANEGARAAN', 'code': 'D4SM-41-04', 'schedule': 'Selasa, 10:00 - 12:00'},
      {'name': 'SISTEM OPERASI', 'code': 'D4SM-41-04', 'schedule': 'Rabu, 13:00 - 15:00'},
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling issues
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final cls = classes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8), // Adjusted margin
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: const Color(0xFFB71C1C),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cls['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cls['code'] as String,
                         style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        cls['schedule'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditProfileTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabeledInput('Nama Pertama'),
        const SizedBox(height: 16),
        _buildLabeledInput('Nama Terakhir'),
        const SizedBox(height: 16),
        _buildLabeledInput('E-mail Address', inputType: TextInputType.emailAddress),
        const SizedBox(height: 16),
        _buildLabeledInput('Negara', placeholder: 'Indonesia'),
        const SizedBox(height: 16),
        _buildLabeledInput('Deskripsi', maxLines: 4),
        const SizedBox(height: 32),
        
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB71C1C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Simpan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledInput(String label, {
    TextInputType inputType = TextInputType.text,
    String? placeholder,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: inputType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: placeholder,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey), // Grey thin border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFB71C1C)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}