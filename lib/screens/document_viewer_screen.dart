import 'package:flutter/material.dart';

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final String title = args['title'] ?? 'Pengantar User Interface Design';

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Clean, modern off-white
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C), // Telkom Red
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20), // Pill shape
                border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
              ),
              child: const Text(
                '1 / 26',
                style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        children: [
          _buildHasDecoration(child: _buildSlide1()),
          const SizedBox(height: 24),
          _buildHasDecoration(child: _buildSlide2()),
          const SizedBox(height: 24),
          _buildHasDecoration(child: _buildSlide3()),
          const SizedBox(height: 24),
          _buildHasDecoration(child: _buildSlide4()),
          const SizedBox(height: 48), // Bottom padding
        ],
      ),
    );
  }

  // Wrapper for common slide decoration
  Widget _buildHasDecoration({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  // Slide 1: Cover
  Widget _buildStandardImage(String url, {double height = 200}) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.grey[100],
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              color: const Color(0xFFB71C1C),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            const Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 40)),
      ),
    );
  }

  Widget _buildSlide1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Standardized Cover Image
        _buildStandardImage('https://images.unsplash.com/photo-1561070791-2526d30994b5?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', height: 220),
        
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFB71C1C),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('VEI214', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
              ),
              const SizedBox(height: 16),
              const Text('Pengantar Desain', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 4),
              const Text('Antarmuka Pengguna', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.2)),
              const SizedBox(height: 32),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Container(
                     padding: const EdgeInsets.all(8),
                     decoration: BoxDecoration(
                       color: Colors.grey[50],
                       shape: BoxShape.circle,
                     ),
                     child: Icon(Icons.school, size: 24, color: Colors.grey[800]),
                   ),
                   const SizedBox(width: 12),
                   Text('Universitas\nTelkom', style: TextStyle(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  // Slide 2: Perkenalan
  Widget _buildSlide2() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Biodata',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFB71C1C), letterSpacing: 1.2),
          ),
          const SizedBox(height: 32),
          
          Container(
            padding: const EdgeInsets.all(4),
             decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFB71C1C), width: 2),
            ),
            child: const CircleAvatar(
               radius: 48, 
               backgroundColor: Colors.grey,
               backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'), 
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text('Ady Purna Kurniawan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          const Text('DOSEN PEMBIMBING', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.5)),
          
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildContactRow(Icons.email_rounded, 'adypurnal@telkomuniversity.ac.id'),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
                _buildContactRow(Icons.phone_rounded, '0857-2793-0642'),
              ],
            ),
          ),
           
           const SizedBox(height: 24),
           Wrap(
             spacing: 8,
             runSpacing: 8,
             alignment: WrapAlignment.center,
             children: const [
               Chip(label: Text('Information System', style: TextStyle(fontSize: 10))),
               Chip(label: Text('Web Programming', style: TextStyle(fontSize: 10))),
               Chip(label: Text('Game Dev', style: TextStyle(fontSize: 10))),
             ],
           )
        ],
      ),
    );
  }

  // Slide 3: User Interface Definition
  Widget _buildSlide3() {
    return Column(
      children: [
         Padding(
           padding: const EdgeInsets.all(24),
           child: Column(
             children: const [
               Text('Definisi & Konsep', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 2)),
               SizedBox(height: 8),
               Text(
                'User Interface (UI)',
                style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
             ],
           ),
         ),
        _buildStandardImage('https://images.unsplash.com/photo-1550684848-fac1c5b4e853?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
        
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHighlightBox(
                text: 'Bagian dari sistem komputer dan perangkat lunak yang dapat dilihat, didengar, disentuh, dan diajak berinteraksi oleh pengguna.',
                icon: Icons.touch_app_rounded
              ),
              const SizedBox(height: 20),
              
              const Text(
                'Penjelasan Lengkap:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                'UI bukan hanya tentang "tampilan" visual semata, tetapi juga mencakup mekanisme input dan output yang memungkinkan pengguna mengendalikan sistem. UI menjembatani keinginan pengguna (User Intent) dengan kapabilitas mesin.',
                style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.6),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 20),
              const Text(
                'Tujuan Utama Desain UI:',
                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                '“UI yang baik adalah UI yang transparan dan tidak disadari (invisible), sehingga pengguna dapat fokus sepenuhnya pada informasi yang dicari dan tugas (task) yang ingin diselesaikan tanpa terganggu oleh mekanisme antarmuka yang rumit.”',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black54, height: 1.5),
              ),
              
              const SizedBox(height: 24),
              const Text(
                'Alur Interaksi:',
                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIOIcon(Icons.keyboard, 'Input\n(Keyboard/Mouse)'),
                  Icon(Icons.arrow_right_alt, color: Colors.grey[300]),
                  _buildIOIcon(Icons.computer, 'Proses\n(Sistem)'),
                  Icon(Icons.arrow_right_alt, color: Colors.grey[300]),
                  _buildIOIcon(Icons.monitor, 'Output\n(Layar/Suara)'),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIOIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFB71C1C)),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
      ],
    );
  }

  Widget _buildHighlightBox({required String text, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orange[800], size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: Colors.orange[900], height: 1.4))),
        ],
      ),
    );
  }

  // Slide 4: Pentingnya Desain UI
  Widget _buildSlide4() {
    return Column(
      children: [
         Padding(
           padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
           child: Column(
             children: const [
                 Icon(Icons.warning_amber_rounded, size: 40, color: Color(0xFFEF5350)),
                 SizedBox(height: 16),
                 Text(
                  'Mengapa UI Penting?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
             ],
           ),
         ),
         _buildStandardImage('https://images.unsplash.com/photo-1558655146-d09347e0b7a8?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', height: 180),
         
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(
              'Banyak sistem dengan fungsionalitas hebat GAGAL di pasaran karena desain UI yang buruk.',
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.red[900], fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            const Text('Dampak Buruk UI:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildBulletPoint('Membingungkan Pengguna: Struktur navigasi yang tidak logis membuat pengguna tersesat.'),
            const SizedBox(height: 8),
            _buildBulletPoint('Tidak Efisien: Membutuhkan terlalu banyak klik untuk menyelesaikan tugas sederhana.'),
             const SizedBox(height: 8),
            _buildBulletPoint('Frustasi & Churn: Pengguna akan meninggalkan aplikasi jika merasa sulit digunakan.'),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildBadEffectCard('Membingungkan', Icons.question_mark)),
                const SizedBox(width: 12),
                Expanded(child: _buildBadEffectCard('Frustasi', Icons.emoji_emotions_outlined)),
              ],
            )
          ]),
        )
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(color: Color(0xFFB71C1C), fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4))),
      ],
    );
  }

  Widget _buildBadEffectCard(String label, IconData icon) {
     return Container(
       padding: const EdgeInsets.symmetric(vertical: 16),
       decoration: BoxDecoration(
         color: Colors.red[50],
         borderRadius: BorderRadius.circular(12),
         border: Border.all(color: Colors.red[100]!)
       ),
       child: Column(
         children: [
           Icon(icon, color: Colors.red[400]),
           const SizedBox(height: 8),
           Text(label, style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold, fontSize: 12))
         ],
       ),
     );
  }


  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[800]), overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
