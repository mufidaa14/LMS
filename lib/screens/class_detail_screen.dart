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
    final isMeeting2 = title.contains('Konsep User Interface Design');
    final description = isMeeting2
        ? 'Konsep dasar User Interface Design akan dipelajari bagaimana membangun sebuah Interaction Design pada antarmuka. Interaction ini sangat penting untuk aplikasi berkomunikasi dengan pengguna.'
        : 'Antarmuka yang dibangun harus memperhatikan prinsip-prinsip desain yang ada. Hal ini diharapkan agar antarmuka yang dibangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip desain.';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
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
                          children: [
                            Text(isMeeting2 ? 'Konsep User Interface Design' : title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            Text(description, style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.5), textAlign: TextAlign.justify),
                          ],
                        ),
                      ),
                      const TabBar(
                        labelColor: Color(0xFF800000),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Color(0xFF800000),
                        tabs: [Tab(text: 'Materi'), Tab(text: 'Tugas')],
                      ),
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
    final items = isMeeting2
        ? [{'icon': Icons.link, 'title': 'Zoom Meeting', 'type': 'link'}, {'icon': Icons.article, 'title': 'Materi PDF', 'type': 'doc'}]
        : [{'icon': Icons.link, 'title': 'Zoom Meeting', 'type': 'link'}, {'icon': Icons.picture_as_pdf, 'title': 'Pengantar UI', 'type': 'pdf'}];

    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Icon(item['icon'] as IconData, color: const Color(0xFF800000)),
          title: Text(item['title'] as String),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildTugasKuisPopulated(ScrollController controller) {
    return ListView(
      controller: controller,
      padding: const EdgeInsets.all(20),
      children: const [ListTile(title: Text("Kuis 1"), leading: Icon(Icons.quiz))],
    );
  }

  Widget _buildTugasEmptyState() {
    return const Center(child: Text("Tidak ada tugas"));
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
                      _buildMateriTab(context),
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

  Widget _buildMateriTab(BuildContext context) {
    // Data dummy sesuai screenshot (template untuk semua mata kuliah sementara)
    final List<Map<String, dynamic>> meetings = [
      {
        'label': 'Pertemuan 1',
        'title': '01 - Pengantar User Interface Design',
        'desc': '3 URLs, 2 Files, 3 Interactive Content',
        'isDone': false, // Belum selesai (Grey)
      },
      {
        'label': 'Pertemuan 2',
        'title': '02 - Konsep User Interface Design',
        'desc': '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
        'isDone': true,
      },
      {
        'label': 'Pertemuan 3',
        'title': '03 - Interaksi pada User Interface Design',
        'desc': '3 URLs, 2 Files, 3 Interactive Content',
        'isDone': true,
      },
      {
        'label': 'Pertemuan 4',
        'title': '04 - Ethnographic Observation',
        'desc': '3 URLs, 2 Files, 3 Interactive Content',
        'isDone': true,
      },
      {
        'label': 'Pertemuan 5',
        'title': '05 - UID Testing',
        'desc': '3 URLs, 2 Files, 3 Interactive Content',
        'isDone': true,
      },
      {
        'label': 'Pertemuan 6',
        'title': '06 - Assessment 1',
        'desc': '3 URLs, 2 Files, 3 Interactive Content',
        'isDone': true,
      },
    ];

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
