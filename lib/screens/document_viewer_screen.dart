import 'package:flutter/material.dart';

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final String title = args['title'] ?? 'Pengantar User Interface Design';

    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0), // Light grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C), // Telkom Red
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Text(
                'Halaman\n1/26',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold, height: 1.1),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSlide1(),
          const SizedBox(height: 16),
          _buildSlide2(),
          const SizedBox(height: 16),
          _buildSlide3(),
          const SizedBox(height: 16),
          _buildSlide4(),
        ],
      ),
    );
  }

  // Slide 1: Cover
  Widget _buildStandardImage(String url, {double height = 180}) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null));
          },
          errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
        ),
      ),
    );
  }

  Widget _buildSlide1() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Standardized Cover Image - Reliable Source
          _buildStandardImage('https://images.unsplash.com/photo-1561070791-2526d30994b5?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
          
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pengantar Desain', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                    const Text('Antarmuka Pengguna', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), color: const Color(0xFFB71C1C), child: const Text('VEI214', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10))),
                  ],
                ),
              ),
              Column(
                children: [
                   Icon(Icons.local_library_outlined, size: 40, color: Colors.grey[800]),
                   const SizedBox(height: 4),
                   Text('Universitas\nTelkom', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Colors.grey[800], fontWeight: FontWeight.bold)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // Slide 2: Perkenalan
  Widget _buildSlide2() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Perkenalan',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Photo - Kept as CircleAvatar for Profile
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: const CircleAvatar(
                   radius: 40, // Slightly smaller to fit better
                   backgroundColor: Colors.grey,
                   backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'), // Generic male avatar
                ),
              ),
              const SizedBox(width: 20),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Ady Purna Kurniawan', ' --> ADY', isBold: true),
                    const SizedBox(height: 8),
                    _buildInfoRow('E-mail:', '\nadypurnakurniawan@telkomuniversity.ac.id'),
                    const SizedBox(height: 8),
                    _buildInfoRow('Bidang Keahlian:', '\n– Information System\n– Web Programming and Design\n– Game Development'),
                    const SizedBox(height: 8),
                    _buildInfoRow('No.HP: 085727930642', ' -->\nSMS/Telp/Whatsapp'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Added Decorative Icons for Contact
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               _buildIconCard(Icons.email_outlined, Colors.red[100]!, Colors.red[800]!),
               const SizedBox(width: 16),
               _buildIconCard(Icons.language, Colors.blue[100]!, Colors.blue[800]!),
               const SizedBox(width: 16),
               _buildIconCard(Icons.chat_bubble_outline, Colors.green[100]!, Colors.green[800]!),
            ],
          )
        ],
      ),
    );
  }

  // Slide 3: User Interface Definition
  Widget _buildSlide3() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           const Text(
            'User Interface',
            style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 24),
          // Added relevant image for UI - Abstract
          _buildStandardImage('https://images.unsplash.com/photo-1550684848-fac1c5b4e853?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
          const SizedBox(height: 24),
          _buildBulletItem(
            TextSpan(
               // Inherits fontSize 16 from _buildBulletItem
               children: [
                 const TextSpan(text: 'Antarmuka/ '),
                 TextSpan(text: 'user interface (UI)', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[800])),
                 const TextSpan(text: ' merupakan bagian dari komputer dan perangkat lunaknya yang dapat '),
                 const TextSpan(text: 'dilihat, \ndidengar, disentuh.', style: TextStyle(fontWeight: FontWeight.bold)),
               ]
            )
          ),
          const SizedBox(height: 12),
          _buildBulletItem(
            TextSpan(
               children: [
                 const TextSpan(text: 'UI yang baik adalah UI yang '),
                 const TextSpan(text: 'tidak disadari, ', style: TextStyle(fontWeight: FontWeight.bold)),
                 const TextSpan(text: 'memungkinkan pengguna fokus pada informasi dan '),
                 const TextSpan(text: 'task.', style: TextStyle(fontStyle: FontStyle.italic)),
               ]
            )
          ),
          const SizedBox(height: 12),
          _buildBulletItem(
             const TextSpan(
              children: [
                 TextSpan(text: 'Komponen utamanya:\n'),
              ]
             )
          ),
          // Added Component Icons (Input/Output)
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildComponentIcon(Icons.keyboard, 'Input'),
              _buildComponentIcon(Icons.mouse, 'Input'),
              _buildComponentIcon(Icons.monitor, 'Output'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIconCard(IconData icon, Color hColor, Color iColor) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: hColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: iColor, size: 20),
    );
  }

  Widget _buildComponentIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!)
          ),
          child: Icon(icon, color: Colors.grey[700], size: 24),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600]))
      ],
    );
  }

  // Slide 4: Pentingnya Desain UI
  Widget _buildSlide4() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Pentingnya Desain UI',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black87),
          ),
          const SizedBox(height: 24),
          // Cleaned up image - Abstract Shapes to ensure visibility
          _buildStandardImage('https://images.unsplash.com/photo-1558655146-d09347e0b7a8?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
          
          const SizedBox(height: 24),
          _buildBulletItem(
            const TextSpan(
              // Inherits fontSize 16 from _buildBulletItem
              children: [
                TextSpan(text: 'Banyak sistem dengan fungsionalitas yang baik tapi tidak efisien karena '),
                TextSpan(text: 'desain UI yang buruk.', style: TextStyle(fontWeight: FontWeight.bold)),
              ]
            )
          ),
          const SizedBox(height: 12),
          _buildBulletItem(
            const TextSpan(
              children: [
                TextSpan(text: 'Desain yang buruk akan '),
                TextSpan(text: 'membingungkan, tidak efisien, ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'dan menyebabkan '),
                TextSpan(text: 'frustasi.', style: TextStyle(fontWeight: FontWeight.bold)),
              ]
            )
          ),
        ],
      ),
    );
  }

  // Helpers
  Widget _buildBulletItem(TextSpan textSpan) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5), // Base style for bullets
              children: [textSpan],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        children: [
          TextSpan(text: label, style: isBold ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 16) : const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          TextSpan(text: value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
