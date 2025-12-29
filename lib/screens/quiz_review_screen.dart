import 'package:flutter/material.dart';
import 'quiz_attempt_screen.dart';

class QuizReviewScreen extends StatelessWidget {
  const QuizReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data (In reality, this would be passed from the attempt screen)
    final List<Map<String, dynamic>> questions = [
      {
        'id': 1,
        'question': 'Radio button dapat digunakan untuk menentukan ?',
        'answer': 'A. Jenis Kelamin',
      },
       {
        'id': 2,
        'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
        'answer': 'B. Konsistensi',
      },
       {
        'id': 3,
        'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
        'answer': 'C. Konsistensi',
      },
       {
        'id': 4,
        'question': 'Radio button dapat digunakan untuk menentukan ?',
        'answer': 'A. Jenis Kelamin',
      },
       {
        'id': 5,
        'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
        'answer': 'C. Konsistensi',
      }
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Review Jawaban',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Di Mulai Pada', 'Kamis 25 Februari 2021 10:25'),
                  _buildSummaryRow('Status', 'Selesai'),
                  _buildSummaryRow('Selesai Pada', 'Kamis 25 Februari 2021 10:40'),
                  _buildSummaryRow('Waktu Penyelesaian', '13 Menit 22 Detik'),
                  _buildSummaryRow('Nilai', '0 / 100', isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 2. Question List
            ListView.separated(
              itemCount: questions.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                final item = questions[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        'Pertanyaan ${item['id']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item['question'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, color: Colors.black87),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Jawaban Tersimpan',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    item['answer'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to QuizAttemptScreen in Review Mode
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuizAttemptScreen(
                                        isReviewMode: true, 
                                        initialIndex: index, // Pass specific index
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Lihat Soal',
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),

            // 3. Submit Button
            SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                   // Final Submit Logic
                   // Pop until we reach the Class Detail screen or the root
                   Navigator.popUntil(context, (route) {
                     return route.settings.name == '/class_detail' || route.isFirst;
                   });
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Jawaban Akhir Terkirim!")));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Kirim Jawaban', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
