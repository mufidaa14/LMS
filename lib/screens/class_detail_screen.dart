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

  @override
  Widget build(BuildContext context) {
    // Safely receive arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
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
        backgroundColor: const Color(0xFFB71C1C), // Maroon
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // BAGIAN ATAS – INFO KELAS (Red Header Style or Clean White)
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
          
          // TAB NAVIGATION (Matched Style: Indicator Underline, Maroon text)
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 10), // Separator
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
                _buildMateriTab(),
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
    Widget? leadingIcon, // Optional Icon for Tugas/Kuis
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
              // Row 1: Badge & Status
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
              
              // Row 2: Title & Content
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

  // TAB 1 – MATERI
  Widget _buildMateriTab() {
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
          badgeColor: const Color(0xFF42A5F5), // Light Blue
          title: item['title'],
          subtitle: item['subtitle'],
          statusIcon: Icon(
            Icons.check_circle, 
            color: isCompleted ? Colors.green : Colors.grey[300],
            size: 20
          ),
        );
      },
    );
  }

  // TAB 2 – TUGAS
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

  // TAB 3 – KUIS
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
