import 'package:flutter/material.dart';
import 'quiz_review_screen.dart';

class QuizAttemptScreen extends StatefulWidget {
  final bool isReviewMode;
  final int initialIndex;

  const QuizAttemptScreen({
    super.key, 
    this.isReviewMode = false,
    this.initialIndex = 0,
  });

  @override
  State<QuizAttemptScreen> createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends State<QuizAttemptScreen> {
  int _currentQuestionIndex = 0;
  final int _totalQuestions = 15;
  
  @override
  void initState() {
    super.initState();
    _currentQuestionIndex = widget.initialIndex;
  }

  // Dummy data for questions
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Radio button dapat digunakan untuk menentukan ?',
      'options': [
        'A. Jenis Kelamin',
        'B. Alamat',
        'C. Hobby',
        'D. Riwayat Pendidikan',
        'E. Umur'
      ],
      'selectedAnswer': 0, // Default selected A for demo as per image 1
    },
    {
      'question': 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
      'options': [
        'A. Intergrasi',
        'B. Standarisasi',
        'C. Konsistensi',
        'D. Koefensi',
        'E. Koreksi'
      ],
      'selectedAnswer': 2, // Default selected C for demo as per image 2
    },
     // Generate more dummy questions
    ...List.generate(13, (index) => {
      'question': 'Pertanyaan dummy nomor ${index + 3}. Silahkan pilih jawaban yang paling benar di bawah ini.',
      'options': [
        'A. Jawaban Pilihan A',
        'B. Jawaban Pilihan B',
        'C. Jawaban Pilihan C',
        'D. Jawaban Pilihan D',
        'E. Jawaban Pilihan E'
      ],
      'selectedAnswer': -1,
    }),
  ];

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      if (widget.isReviewMode) {
        // In review mode, maybe just loop or stay? Or return?
        // Let's just do nothing for now or go to last page
      } else {
         // Last question - Submit logic
         // Instead of dialog, go to Review Screen? 
         // User Prompt said: "selanjunya hamana ini" showing review screen.
         // So "Submit" -> Go to Review Screen.
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuizReviewScreen()),
         );
      }
    }
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kirim Jawaban?'),
        content: const Text('Apakah Anda yakin ingin menyelesaikan kuis ini? Pastikan semua soal telah terjawab.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close quiz screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kuis berhasil dikirim!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB71C1C),
              foregroundColor: Colors.white,
            ),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  void _prevQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _selectAnswer(int index) {
    setState(() {
      _questions[_currentQuestionIndex]['selectedAnswer'] = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isReviewMode ? 'Quiz Review 1' : 'Quiz Review 1', // Same title?
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 20),
                const SizedBox(width: 6),
                const Text(
                  '15 : 00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Question Navigation Bar (Circles)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(_totalQuestions, (index) {
                    final isCurrent = index == _currentQuestionIndex;
                    final isAnswered = _questions[index]['selectedAnswer'] != -1;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentQuestionIndex = index;
                        });
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isAnswered 
                            ? const Color(0xFF00E676) // Bright Green for Answered
                            : (isCurrent ? Colors.white : Colors.white), 
                          border: Border.all(
                            color: isCurrent ? Colors.black87 : Colors.grey.shade400,
                            width: isCurrent ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isAnswered ? Colors.black87 : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Question Title
                  Text(
                    'Soal Nomor ${_currentQuestionIndex + 1} / $_totalQuestions',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // 3. Question Text
                  Text(
                    currentQuestion['question'],
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // 4. Options
                  ...List.generate(currentQuestion['options'].length, (index) {
                    final optionText = currentQuestion['options'][index];
                    final isSelected = currentQuestion['selectedAnswer'] == index;
                    
                    return GestureDetector(
                      onTap: () => _selectAnswer(index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEF5350) : const Color(0xFFF5F5F5), // Red if selected, light grey if not
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                optionText,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  
                  const SizedBox(height: 40),
                  
                  // 5. Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       // Prev Button
                       _currentQuestionIndex > 0 
                       ? ElevatedButton(
                           onPressed: _prevQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                           child: const Text('Soal Sebelum nya.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                         )
                       : const SizedBox.shrink(), // Placeholder to keep Next button aligned right if alone? Or SpaceBetween handles it.
                       
                       // Next Button / Finish Button / Review Back Button
                       if (widget.isReviewMode) 
                          Align(
                            alignment: Alignment.center, // Center for "Kembali"
                            child: SizedBox(
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[100],
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text("Kembali Ke Halam Review", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                            ),
                          )
                       else
                         ElevatedButton(
                         onPressed: _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentQuestionIndex == _questions.length - 1 
                                ? const Color(0xFF00E676) // Green for Selesai
                                : Colors.grey[200],
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                         child: Text(
                           _currentQuestionIndex == _questions.length - 1 ? 'Selesai.' : 'Soal Selanjutnya.', 
                           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                         ),
                       ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
