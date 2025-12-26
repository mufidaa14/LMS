import 'package:flutter/material.dart';
import 'quiz_attempt_screen.dart';

class QuizDetailScreen extends StatelessWidget {
  const QuizDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Light grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Quiz Review 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header / Intro Section with overlapping card effect or just simple grouping
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                boxShadow: [
                   BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ]
              ),
              child: Column(
                children: [
                   // 1. Instructions
                  const Text(
                    'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis.\n\nJangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  
                  // Deadline Banner
                  Container(
                    padding: const EdgeInsets.symmetric(vertical:10, horizontal: 16),
                     decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0), // Light Orange/Yellow
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.warning_amber_rounded, size: 20, color: Colors.orange),
                        SizedBox(width: 8),
                         Flexible(
                           child: Text(
                             'Jatuh Tempo: Jum\'at, 26 Feb 2021, 23:59 WIB',
                             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                             textAlign: TextAlign.center,
                           ),
                         ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 2. Info Cards (Row)
                  Row(
                    children: [
                      _buildInfoCard(Icons.access_time_filled, 'Batas Waktu', '15 Menit'),
                      const SizedBox(width: 12),
                      _buildInfoCard(Icons.grade, 'Penilaian', 'Tertinggi'),
                    ],
                  ),
                ],
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 3. Header "Percobaan Yang Sudah Di Lakukan"
                  Row(
                    children: const [
                      Icon(Icons.history, color: Color(0xFFB71C1C), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Riwayat Percobaan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                   // 4. Attempts Table Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        // Table Header
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          color: const Color(0xFFB71C1C),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                              Text('Nilai / 100', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                              Text('Tinjau', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ),
                        // Table Row
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Status Column
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                       padding: const EdgeInsets.symmetric(horizontal:8, vertical: 4),
                                       decoration: BoxDecoration(
                                         color: Colors.green.shade50,
                                         borderRadius: BorderRadius.circular(4),
                                         border: Border.all(color: Colors.green.shade200)
                                       ),
                                       child: const Text('Selesai', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.green)),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '25 Feb 2021, 10:40',
                                      style: TextStyle(fontSize: 11, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                               // Score Column
                              const Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text('85,0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                                ),
                              ),
                              // Action Column
                              const Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey)
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                         Padding(
                           padding: const EdgeInsets.all(16),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: const [
                               Text("Nilai Akhir", style: TextStyle(fontWeight: FontWeight.bold)),
                               Text("85.0 / 100.0", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFB71C1C))),
                             ],
                           ),
                         )
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                   // 6. Buttons (Simple Style as requested)
                  SizedBox(
                    width: double.infinity, 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Ambil Kuis - Grey Pill Style (Matches Tambahkan Tugas)
                        SizedBox(
                          width: 220, // Slightly wider to accommodate text
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const QuizAttemptScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black87,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                            ),
                            child: const Text('Ambil Kuis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Kembali - Grey Pill Style (Matches Tambahkan Tugas)
                        SizedBox(
                          width: 220, // Matches width above
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black87,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                            ),
                            child: const Text('Kembali Ke Kelas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200)
        ),
        child: Column(
           children: [
             Icon(icon, color: Colors.grey[700], size: 28),
             const SizedBox(height: 8),
             Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
             const SizedBox(height: 4),
             Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
           ],
        ),
      ),
    );
  }
}
