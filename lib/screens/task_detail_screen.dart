import 'package:flutter/material.dart';
import 'submission_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final String title = args['title'] ?? 'Tugas 01 - UID Android Mobile Game';
    final String deadline = args['deadline'] ?? '26 Februari 2021 23:59 WIB';
    final bool isDone = args['isDone'] ?? false;
    final String descFromArgs = args['desc'] ?? '';

    // Hardcoded long description for Tugas 01
    final Widget tugas01Desc = Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: const [
          Text(
            '1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.',
            style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 12),
          Text(
            '2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi dibuka sampai ditutup kembali, serta desain untuk tampilan-tampilan fungsi yang mendukung permainan seperti pop-up, alert, chat, dan lain-lain.',
            style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 12),
          Text(
            '3. Desain bisa dibuat menggunakan aplikasi khusus desain atau secara manual dengan tetap menjunjung kerapihan dan kejelasan setiap elemen dalam desain.',
            style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 12),
          Text(
            '4. Berikan identitas aplikasi game yang dibuat, seperti Nama Game, Genre, dan Platform. Serta berikan penjelasan pada setiap elemen pada desain, seperti gambar, teks, tombol, icon, dan lain-lain.',
            style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 12),
          Text(
            '5. File dikumpulkan dalam format .PDF dengan size maksimal 5MB.',
            style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 12),
          Text(
            '6. Tugas dikumpulkan paling lambat hari Jum\'at, 26 Februari 2021 jam 23:59 WIB (akan tertutup otomatis) dan akan dipresentasikan pada pertemuan selanjutnya via Zoom Meeting.',
            style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
            textAlign: TextAlign.justify,
          ),
       ]
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Light grey background for better contrast
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C), // Telkom Red
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructions / Description
                // Description Section with Card
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Deskripsi Tugas',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 4), 
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: title.contains('01 - UID') ? tugas01Desc : Text(
                          descFromArgs.isNotEmpty ? descFromArgs : 'No Description', 
                          style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                          textAlign: TextAlign.justify
                        ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),

                // Status Tugas Section
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        color: const Color(0xFFEF5350), // Lighter red
                        child: const Text(
                          'Status Tugas',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      // Table Content
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                        ),
                        child: Column(
                          children: [
                             _buildStatusRow('Status', isDone ? 'Sudah Mengirim untuk di nilai' : 'Belum Mengirim', isFirst: true),
                             _buildStatusRow('Status Nilai', 'Belum Di nilai'),
                             _buildStatusRow('Batas tanggal', deadline.replaceAll('Tenggat Waktu : ', '')), // Clean string if needed
                             _buildStatusRow('Sisa Waktu', isDone ? 'Tugas sudah dikirim' : '-'),
                             if (isDone)
                               _buildStatusRow(
                                 'File Tugas', 
                                 'Dandy Candra Pratama_770817394.pdf', 
                                 isFile: true,
                                 isLast: true
                               ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 100), // Space for FAB/Button
              ],
            ),
          ),
          
          // Bottom Button "Tambahkan Tugas"
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const SubmissionScreen()),
                   );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Tambahkan Tugas',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, {bool isFirst = false, bool isLast = false, bool isFile = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
           bottom: isLast ? BorderSide.none : BorderSide(color: Colors.grey.shade200),
        ),
         color: isFirst ? Colors.white : (isFile ? Colors.transparent : Colors.white), // Alternating can be added if needed
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: isFile 
            ? Row(
                children: [
                  const Icon(Icons.picture_as_pdf, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : Text(
                value,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
          ),
        ],
      ),
    );
  }
}
