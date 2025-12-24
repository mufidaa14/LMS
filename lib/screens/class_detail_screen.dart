import 'package:flutter/material.dart';
import 'document_viewer_screen.dart';
import 'video_player_screen.dart';
import 'quiz_detail_screen.dart';

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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showMeetingDetail(BuildContext context, String title) {
    // Logic to switch content based on meeting title
    bool isMeeting2 = title.contains('02') || title.contains('Konsep');
    
    String description;
    List<Map<String, dynamic>> materiData;
    List<Map<String, dynamic>> tugasData;
    
    if (isMeeting2) {
       description = "Konsep dasar User Interface Design akan dipelajari bagaimana membangun sebuah Interaction Design pada antarmuka. Interaction ini sangat penting untuk aplikasi berkomunikasi dengan pengguna. Lalu dipelajari juga poin-poin penting pada interaction design seperti visibility, feedback, limitation, consistency dan affordance. Dan terakhir materi conceptual dan perceptual design interaction akan memberikan gambaran bagaimana bentuk dari Interaction.";
       materiData = [
          {'icon': Icons.link, 'title': 'Zoom Meeting Syncronous', 'isDone': true},
          {'icon': Icons.description_outlined, 'title': 'Elemen-elemen Antarmuka Pengguna', 'isDone': true},
          {'icon': Icons.description_outlined, 'title': 'UID Guidelines and Principles', 'isDone': true},
          {'icon': Icons.description_outlined, 'title': 'User Profile', 'isDone': true},
          {'icon': Icons.link, 'title': 'Principles of User Interface DesignURL', 'isDone': true},
       ];
       tugasData = [
          {
            'type': 'quiz',
            'title': 'Quiz Review 01',
            'desc': 'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.',
            'deadline': 'Tenggat Waktu : 26 Februari 2021 23:59 WIB',
            'isDone': true
          },
          {
            'type': 'tugas',
            'title': 'Tugas 01 - UID Android Mobile Game',
            'desc': '1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.\n2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi .............',
            'deadline': 'Tenggat Waktu : 26 Februari 2021 23:59 WIB',
            'isDone': false
          }
       ];
    } else {
       // Default / Meeting 1 (Pengantar)
       description = 'Antarmuka yang dibangun harus memperhatikan prinsip-prinsip desain yang ada. Hal ini diharapkan agar antarmuka yang dibangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip desain diharapkan akan mendukung pengguna dalam menggunakan produk secara baik. Pelajaran mengenai prinsip UID ini sudah pernah diajarkan dalam mata kuliah Implementasi Desain Antarmuka Pengguna tetap pada matakuliah ini akan direview kembali sehingga dapat menjadi bekal saat memasukki materi mengenai User Experience';
       materiData = [
          {'icon': Icons.link, 'title': 'Zoom Meeting Syncronous', 'isDone': true},
          {'icon': Icons.description_outlined, 'title': 'Pengantar User Interface Design', 'isDone': false},
          {'icon': Icons.description_outlined, 'title': 'Empat Teori Dasar Antarmuka Pengguna', 'isDone': false},
          {'icon': Icons.description_outlined, 'title': 'Empat Teori Dasar Antarmuka Pengguna', 'isDone': true},
          {'icon': Icons.video_collection_outlined, 'title': 'User Interface Design for Beginner', 'isDone': true},
          {'icon': Icons.link, 'title': '20 Prinsip Desain', 'isDone': true},
          {'icon': Icons.link, 'title': 'Best Practice UI Design', 'isDone': true},
       ];
       tugasData = []; 
    }

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
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Use min size
                          children: [
                            Center(
                              child: Text(
                                title.replaceAll(RegExp(r'^\d+ - '), ''), 
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                                textAlign: TextAlign.center
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 8),
                            // Fix Overflow: Wrap description in flexible scrollable container
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.25 // Max 25% of screen height
                              ), 
                              child: SingleChildScrollView(
                                child: Text(
                                  description, 
                                  style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.5), 
                                  textAlign: TextAlign.justify
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const TabBar(
                        labelColor: Color(0xFF800000),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Color(0xFF800000),
                        indicatorWeight: 3,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        tabs: [Tab(text: 'Lampiran Materi'), Tab(text: 'Tugas dan Kuis')],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildLampiranList(controller, materiData),
                            tugasData.isNotEmpty ? _buildTugasList(controller, tugasData) : _buildTugasEmptyState(controller),
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

  Widget _buildLampiranList(ScrollController controller, List<Map<String, dynamic>> items) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final bool isDone = item['isDone'] as bool;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            leading: Icon(item['icon'] as IconData, color: Colors.black87),
            title: Text(
              item['title'] as String,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? const Color(0xFF00E676) : Colors.grey[300],
              ),
              padding: const EdgeInsets.all(2),
              child: const Icon(Icons.check, size: 16, color: Colors.white),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildTugasList(ScrollController controller, List<Map<String, dynamic>> tasks) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(20),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        bool isQuiz = task['type'] == 'quiz';

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), 
                blurRadius: 10, 
                offset: const Offset(0, 4)
              )
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 // Left Indicator
                 Container(
                   width: 80,
                   decoration: BoxDecoration(
                     border: Border(right: BorderSide(color: Colors.grey[100]!)),
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       if (isQuiz)
                        const Icon(Icons.chat_bubble_outline_rounded, size: 28)
                       else 
                        const Icon(Icons.assignment_outlined, size: 28),
                       
                       const SizedBox(height: 4),
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                         decoration: BoxDecoration(
                           color: isQuiz ? Colors.blue[400] : Colors.blue[400],
                           borderRadius: BorderRadius.circular(4)
                         ),
                         child: Text(
                           isQuiz ? "Quiz" : "Tugas",
                           style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                         ),
                       )
                     ],
                   ),
                 ),
                 
                 // Content
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.all(16),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Expanded(
                               child: Text(
                                 task['title'], 
                                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                               ),
                             ),
                             Icon(
                               Icons.check_circle, 
                               color: task['isDone'] ? const Color(0xFF00E676) : Colors.grey[300],
                               size: 22,
                             )
                           ],
                         ),
                         const SizedBox(height: 8),
                         Text(
                           task['desc'],
                           style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
                         ),
                         const SizedBox(height: 12),
                         Text(
                           task['deadline'],
                           style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                         )
                       ],
                     ),
                   ),
                 )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTugasEmptyState([ScrollController? controller]) {
    return ListView(
      controller: controller,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1), // Top spacing
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration Placeholder (Use a network image or asset if available)
              Container(
                width: 250, 
                height: 250,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/empty_state_girl.png'), 
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Tidak Ada Tugas Dan Kuis Hari Ini",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final Color primaryDark = const Color(0xFF800000);
    final Color primaryLight = const Color(0xFFA00000);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 2. Content
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                // Info Section
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
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        args['lecturer'] ?? 'Dosen Pengampu',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (args['progress'] as num?)?.toDouble() ?? 0.0,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(primaryDark),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),

                // Tabs
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: primaryDark,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: primaryDark,
                    indicatorWeight: 3,
                    tabs: const [Tab(text: 'Materi'), Tab(text: 'Tugas Dan Kuis')],
                  ),
                ),

                // Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildMateriTab(context, args['name'] ?? ''),
                      _buildTugasDanKuisTab(),
                    ],
                  ),
                ),
              ],
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
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
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
                    const Text('Detail Kelas', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMateriTab(BuildContext context, String courseName) {
    List<Map<String, dynamic>> meetings = [];

    if (courseName.contains('SISTEM CERDAS')) {
      meetings = [
        {'label': 'Pertemuan 1', 'title': '01 - Pengantar Kecerdasan Buatan', 'desc': '3 URLs, 2 Files', 'isDone': true},
        {'label': 'Pertemuan 2', 'title': '02 - Representasi Pengetahuan', 'desc': '2 URLs, 1 Kuis, 1 Tugas', 'isDone': true},
        {'label': 'Pertemuan 3', 'title': '03 - Sistem Pakar', 'desc': '3 URLs, 2 Files', 'isDone': true},
        {'label': 'Pertemuan 4', 'title': '04 - Logika Fuzzy', 'desc': '2 URLs, 1 Files', 'isDone': true},
        {'label': 'Pertemuan 5', 'title': '05 - Jaringan Saraf Tiruan', 'desc': '3 URLs, 2 Files', 'isDone': false},
        {'label': 'Pertemuan 6', 'title': '06 - Algoritma Genetika', 'desc': '2 URLs, 1 Files', 'isDone': false},
      ];
    } else if (courseName.contains('SEMINAR')) {
      meetings = [
        {'label': 'Pertemuan 1', 'title': '01 - Pengantar & Metodologi Riset', 'desc': '2 Files, 1 Link', 'isDone': true},
        {'label': 'Pertemuan 2', 'title': '02 - Penulisan Proposal TA', 'desc': '1 URLs, 1 Tugas', 'isDone': true},
        {'label': 'Pertemuan 3', 'title': '03 - Studi Literatur', 'desc': '3 URLs, 1 Files', 'isDone': true},
        {'label': 'Pertemuan 4', 'title': '04 - Teknik Presentasi Ilmiah', 'desc': '2 Files', 'isDone': true},
        {'label': 'Pertemuan 5', 'title': '05 - Persiapan Seminar', 'desc': '1 URLs, 1 Files', 'isDone': false},
      ];
    } else if (courseName.contains('CYBER')) {
      meetings = [
        {'label': 'Pertemuan 1', 'title': '01 - Konsep Dasar Keamanan', 'desc': '3 URLs, 2 Files', 'isDone': true},
        {'label': 'Pertemuan 2', 'title': '02 - Kriptografi Dasar', 'desc': '2 URLs, 1 Kuis', 'isDone': true},
        {'label': 'Pertemuan 3', 'title': '03 - Keamanan Jaringan', 'desc': '3 URLs, 2 Files', 'isDone': true},
        {'label': 'Pertemuan 4', 'title': '04 - Malware & Ancaman Siber', 'desc': '2 URLs', 'isDone': false},
        {'label': 'Pertemuan 5', 'title': '05 - Ethical Hacking', 'desc': '3 URLs, 1 Files', 'isDone': false},
      ];
    } else if (courseName.contains('MOBILE')) {
      meetings = [
        {'label': 'Pertemuan 1', 'title': '01 - Review Flutter Basic', 'desc': '3 URLs, 2 Files', 'isDone': true},
        {'label': 'Pertemuan 2', 'title': '02 - State Management (Provider)', 'desc': '2 GitHub, 1 Video', 'isDone': true},
        {'label': 'Pertemuan 3', 'title': '03 - REST API Integration', 'desc': '3 URLs, 1 Quiz', 'isDone': true},
        {'label': 'Pertemuan 4', 'title': '04 - Local Storage (Hive/SQLite)', 'desc': '2 URLs, 1 Code', 'isDone': false},
        {'label': 'Pertemuan 5', 'title': '05 - Firebase Integration', 'desc': '3 URLs, 1 Config', 'isDone': false},
      ];
    } else if (courseName.contains('GEOGRAFIS')) {
      meetings = [
        {'label': 'Pertemuan 1', 'title': '01 - Pengantar SIG', 'desc': '2 Files, 1 Video', 'isDone': true},
        {'label': 'Pertemuan 2', 'title': '02 - Sistem Koordinat & Proyeksi', 'desc': '2 Maps, 1 File', 'isDone': true},
        {'label': 'Pertemuan 3', 'title': '03 - Model Data Spasial', 'desc': '3 Files', 'isDone': true},
        {'label': 'Pertemuan 4', 'title': '04 - Digitasi Peta & Input Data', 'desc': '1 App, 2 Files', 'isDone': false},
        {'label': 'Pertemuan 5', 'title': '05 - Analisis Spasial Dasar', 'desc': '2 URLs, 1 Files', 'isDone': false},
      ];
    } else {
      // Default Fallback
       meetings = [
        {'label': 'Pertemuan 1', 'title': '01 - Pengantar Mata Kuliah', 'desc': 'Silabus & Kontrak Kuliah', 'isDone': true},
        {'label': 'Pertemuan 2', 'title': '02 - Teori Dasar', 'desc': 'Materi Dasar 1', 'isDone': true},
        {'label': 'Pertemuan 3', 'title': '03 - Pendalaman Materi', 'desc': 'Studi Kasus', 'isDone': false},
      ];
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: meetings.length,
      itemBuilder: (context, index) {
        final item = meetings[index];
        final bool isDone = item['isDone'];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showMeetingDetail(context, item['title']),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Badge Pertemuan
                        Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                           decoration: BoxDecoration(
                             color: const Color(0xFF64B5F6), // Light Blue like screenshot
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child: Text(
                             item['label'],
                             style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                           ),
                        ),
                        // Status Icon
                        Icon(
                          Icons.check_circle, 
                          color: isDone ? const Color(0xFF43A047) : Colors.grey[300], // Green or Grey
                          size: 24,
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['desc'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildTugasDanKuisTab() {
    final List<Map<String, dynamic>> tasks = [
      {
        'type': 'quiz',
        'label': 'QUIZ',
        'title': 'Quiz Review 01',
        'deadline': '26 Februari 2021 23:59 WIB',
        'isDone': true,
      },
      {
        'type': 'tugas',
        'label': 'Tugas',
        'title': 'Tugas 01 - UID Android Mobile Game',
        'deadline': '26 Februari 2021 23:59 WIB',
        'isDone': false, // Grey check in screenshot looks like history/pending or just done visually different
      },
      {
        'type': 'quiz',
        'label': 'Pertemuan 3',
        'title': 'Kuis - Assessment 2',
        'deadline': '26 Februari 2021 23:59 WIB',
        'isDone': true,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final item = tasks[index];
        final bool isQuiz = item['type'] == 'quiz';
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[100]!), // Softer border
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // Wider padding
                      decoration: BoxDecoration(
                        color: const Color(0xFF64B5F6), // Light Blue
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item['label'],
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Status Check
                   Icon(
                      Icons.check_circle,
                      color: item['isDone'] ? const Color(0xFF43A047) : Colors.grey[400],
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Main
                    isQuiz 
                    ? const Icon(Icons.quiz_outlined, size: 40, color: Colors.black87)
                    : const Icon(Icons.assignment_outlined, size: 40, color: Colors.black87),

                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item['title'],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                 const SizedBox(height: 16),
                 Text(
                   'Tenggat Waktu : ${item['deadline']}',
                   style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                 )
              ],
            ),
          ),
        );
      },
    );
  }
}
