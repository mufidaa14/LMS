import 'package:flutter/material.dart';

class ClassDetailScreen extends StatefulWidget {
  const ClassDetailScreen({super.key});

  @override
  State<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showMeetingDetail(BuildContext context, String title) {
    // Determine if we are on the specific "Konsep User Interface Design" meeting
    final isMeeting2 = title.contains('Konsep User Interface Design');

    // Specific Description for Meeting 2
    final description = isMeeting2
        ? 'Konsep dasar User Interface Design akan dipelajari bagaimana membangun sebuah Interaction Design pada antarmuka. Interaction ini sangat penting untuk aplikasi berkomunikasi dengan pengguna. Lalu dipelajari juga poin-poin penting pada interaction design seperti visibility, feedback, limitation, consistency dan affordance. Dan terakhir materi conceptual dan perceptual design interaction akan memberikan gambaran bagaimana bentuk dari Interaction.'
        : 'Antarmuka yang dibangun harus memperhatikan prinsip-prinsip desain yang ada. Hal ini diharapkan agar antarmuka yang dibangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip desain diharapkan akan mendukung pengguna dalam menggunakan produk secara baik.';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Internal Content
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          children: [
                            Text(
                              isMeeting2 ? 'Konsep User Interface Design' : title,
                              style: const TextStyle(
                                fontSize: 16, // Slightly reduced to match screenshot
                                fontWeight: FontWeight.bold,
                                color: Colors.black87
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Deskripsi',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              description,
                              style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      
                      // Nested TabBar
                      Container(
                        color: Colors.grey[50], // Light background for tab bar area
                        child: const TabBar(
                          labelColor: Colors.black87,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.black87,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          tabs: [
                            Tab(text: 'Lampiran Materi'),
                            Tab(text: 'Tugas dan Kuis'),
                          ],
                        ),
                      ),

                      // Nested TabView
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildLampiranList(controller, isMeeting2),
                            isMeeting2 ? _buildTugasKuisPopulated(controller) : _buildTugasEmptyState(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLampiranList(ScrollController controller, bool isMeeting2) {
    // Specific items for Meeting 2 vs Default
    final items = isMeeting2
        ? [
            {'icon': Icons.link, 'title': 'Zoom Meeting Syncronous', 'type': 'link'},
            {'icon': Icons.article, 'title': 'Elemen-elemen Antarmuka Pengguna', 'type': 'doc'},
            {'icon': Icons.article, 'title': 'UID Guidelines and Principles', 'type': 'doc'},
            {'icon': Icons.article, 'title': 'User Profile', 'type': 'doc'},
            {'icon': Icons.link, 'title': 'Principles of User Interface DesignURL', 'type': 'link'},
          ]
        : [
            {'icon': Icons.link, 'title': 'Zoom Meeting Syncronous', 'type': 'link'},
            {'icon': Icons.picture_as_pdf, 'title': 'Pengantar User Interface Design', 'type': 'pdf'},
            {'icon': Icons.article, 'title': 'Empat Teori Dasar Antarmuka Pengguna', 'type': 'doc'},
            {'icon': Icons.link, 'title': '20 Prinsip Desain', 'type': 'link'},
            {'icon': Icons.link, 'title': 'Best Practice UI Design', 'type': 'link'},
          ];

    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30), // Pill shape
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
               BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
               Icon(item['icon'] as IconData, size: 22, color: Colors.black87),
               const SizedBox(width: 16),
               Expanded(
                 child: Text(
                   item['title'] as String,
                   style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                 ),
               ),
               const Icon(Icons.check_circle, color: Colors.green, size: 22),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTugasKuisPopulated(ScrollController controller) {
    return ListView(
      controller: controller,
      padding: const EdgeInsets.all(20),
      children: [
        // Quiz Card
        _buildDetailCard(
          title: 'Quiz Review 01',
          content: 'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan. Kerjakan sebelum hari Jum\'at, 26 Februari 2021 jam 23:59 WIB.',
          icon: Icons.quiz_outlined,
          isCompleted: true,
        ),
        const SizedBox(height: 16),
        // Tugas Card
        _buildDetailCard(
          title: 'Tugas 01 - UID Android Mobile Game',
          content: '1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.\n2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi ......',
          icon: Icons.assignment_outlined,
          isCompleted: false, // Grey check
        ),
      ],
    );
  }

  Widget _buildDetailCard({
    required String title,
    required String content,
    required IconData icon,
    required bool isCompleted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                Icon(
                  Icons.check_circle, 
                  color: isCompleted ? Colors.green : Colors.grey[400],
                  size: 20
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 24, color: Colors.black87),
                const SizedBox(width: 16),
                Container(width: 1, height: 60, color: Colors.grey[300]), // Vertical Divider
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 11, color: Colors.black87, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTugasEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Placeholder
           Image.network(
            'https://cdni.iconscout.com/illustration/premium/thumb/empty-state-2130362-1800926.png', // Placeholder URL or local asset
            height: 150,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.person_outline_rounded, size: 100, color: Colors.red.shade100),
          ),
          const SizedBox(height: 24),
          const Text(
            'Tidak Ada Tugas Dan Kuis Hari Ini',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Safely receive arguments or use fallback for development/hot-reload
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? 
    {
      'name': 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
      'progress': 0.9,
    };

    if (args.isEmpty) { // Should not happen with fallback, but safe check
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Kelas')),
        body: const Center(child: Text('Error: Data kelas tidak ditemukan.')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Detail Kelas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB71C1C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // BAGIAN ATAS – INFO KELAS
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args['name'] ?? 'Mata Kuliah',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (args['progress'] as num?)?.toDouble() ?? 0.0,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFB71C1C)),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${((args['progress'] as num? ?? 0) * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // TAB NAVIGATION
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 10),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black87,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: 'Materi'),
                Tab(text: 'Tugas'),
                Tab(text: 'Kuis'),
              ],
            ),
          ),
          
          // TAB CONTENT
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMateriTab(context),
                _buildTugasTab(),
                _buildKuisTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Badge Card Style
  Widget _buildBadgeCard({
    required String badgeText,
    required Color badgeColor,
    required String title,
    required String subtitle,
    required Widget statusIcon,
    VoidCallback? onTap,
    Widget? leadingIcon,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  statusIcon,
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   if (leadingIcon != null) ...[
                     leadingIcon,
                     const SizedBox(width: 12),
                   ],
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           title,
                           style: const TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 14,
                             color: Colors.black87,
                           ),
                         ),
                         const SizedBox(height: 6),
                         Text(
                           subtitle,
                           style: TextStyle(
                             color: Colors.grey[600],
                             fontSize: 12,
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
    );
  }

  Widget _buildMateriTab(BuildContext context) {
    final List<Map<String, dynamic>> materiList = [
      {
        'badge': 'Pertemuan 1',
        'title': '01 - Pengantar User Interface Design',
        'subtitle': '3 URLs, 2 Files, 3 Interactive Content',
        'isCompleted': true,
      },
      {
        'badge': 'Pertemuan 2',
        'title': '02 - Konsep User Interface Design',
        'subtitle': '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
        'isCompleted': true,
      },
      {
        'badge': 'Pertemuan 3',
        'title': '03 - Interaksi pada User Interface Design',
        'subtitle': '3 URLs, 2 Files, 3 Interactive Content',
        'isCompleted': true,
      },
       {
        'badge': 'Pertemuan 4',
        'title': '04 - Ethnographic Observation',
        'subtitle': '3 URLs, 2 Files, 3 Interactive Content',
        'isCompleted': true,
      },
      {
        'badge': 'Pertemuan 5',
        'title': '05 - UID Testing',
        'subtitle': '3 URLs, 2 Files, 3 Interactive Content',
        'isCompleted': true,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materiList.length,
      itemBuilder: (context, index) {
        final item = materiList[index];
        final isCompleted = item['isCompleted'] as bool;
        
        return _buildBadgeCard(
          badgeText: item['badge'],
          badgeColor: const Color(0xFF42A5F5),
          title: item['title'],
          subtitle: item['subtitle'],
          statusIcon: Icon(
            Icons.check_circle, 
            color: isCompleted ? Colors.green : Colors.grey[300],
            size: 20
          ),
          onTap: () => _showMeetingDetail(context, item['title']),
        );
      },
    );
  }

  Widget _buildTugasTab() {
    final List<Map<String, dynamic>> tugasList = [
      {
        'name': 'Tugas 01 – UID Android Mobile Game',
        'deadline': 'Tenggat Waktu : 26 Februari 2025 23:59 WIB',
        'isSubmitted': true,
      },
      {
        'name': 'Tugas 02 – Dashboard LMS',
        'deadline': 'Tenggat Waktu : 05 Maret 2025 23:59 WIB',
        'isSubmitted': false,
      },
      {
        'name': 'Tugas 03 – User Research',
        'deadline': 'Tenggat Waktu : 12 Maret 2025 23:59 WIB',
        'isSubmitted': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tugasList.length,
      itemBuilder: (context, index) {
        final item = tugasList[index];
        final isSubmitted = item['isSubmitted'] as bool;

        return _buildBadgeCard(
          badgeText: 'Tugas',
          badgeColor: const Color(0xFF42A5F5),
          title: item['name'],
          subtitle: item['deadline'],
          leadingIcon: Icon(Icons.assignment_outlined, size: 28, color: Colors.grey[800]),
          statusIcon: Icon(
             Icons.check_circle, 
             color: isSubmitted ? Colors.green : Colors.grey[300],
             size: 20
          ),
          onTap: () {
             Navigator.pushNamed(context, '/task_detail', arguments: item);
          },
        );
      },
    );
  }

  Widget _buildKuisTab() {
    final List<Map<String, dynamic>> kuisList = [
      {
        'name': 'Quiz Review 01',
        'deadline': 'Tenggat Waktu : 26 Februari 2025 23:59 WIB',
        'isDone': true,
      },
      {
        'name': 'Kuis - Assessment 2',
        'deadline': 'Tenggat Waktu : 26 Februari 2025 23:59 WIB',
        'isDone': true,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: kuisList.length,
      itemBuilder: (context, index) {
        final item = kuisList[index];
        final isDone = item['isDone'] as bool;

        return _buildBadgeCard(
          badgeText: 'QUIZ',
          badgeColor: const Color(0xFF42A5F5),
          title: item['name'],
          subtitle: item['deadline'],
          leadingIcon: Icon(Icons.quiz_outlined, size: 28, color: Colors.grey[800]),
          statusIcon: Icon(
             Icons.check_circle, 
             color: isDone ? Colors.green : Colors.grey[300],
             size: 20
          ),
        );
      },
    );
  }
}
