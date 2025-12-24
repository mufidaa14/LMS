import 'package:flutter/material.dart';

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0), // Light grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C), // Telkom Red
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pengantar User Interface Design',
          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
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
  Widget _buildSlide1() {
    return AspectRatio(
      aspectRatio: 16 / 10, // Adjusted aspect ratio
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          image: const DecorationImage(
            image: NetworkImage('https://img.freepik.com/free-vector/gradient-ui-ux-background_23-2149052117.jpg'), // Abstract UI bg
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Stack(
          children: [
            // Top Right Logo Area
            Positioned(
              top: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.local_library_outlined, size: 50, color: Colors.grey[800]), // Logo Placeholder
                  Text(
                    'Universitas\nTelkom',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w900, 
                      fontSize: 22, 
                      color: Colors.grey[800],
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            
            // Mockup Image (Left Side)
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                 width: 150,
                 height: 120,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(8),
                   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 5))],
                 ),
                 child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://cdn.dribbble.com/users/411420/screenshots/15469950/media/ce27010f37c357494002636a00bc79e8.png', 
                      fit: BoxFit.cover,
                    ),
                 ),
              ),
            ),

            // Bottom Dark Banner
            Positioned(
              left: 20,
              right: 20,
              bottom: 30,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                color: const Color(0xFF424242), // Dark Grey
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengantar Desain',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Antarmuka Pengguna',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey, // Vertical Divider
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('VEI214', style: TextStyle(color: Color(0xFFB71C1C), fontSize: 12, fontWeight: FontWeight.bold)), // Red Text
                        Text('UI / UX Design', style: TextStyle(color: Color(0xFFB71C1C), fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Slide 2: Perkenalan
  Widget _buildSlide2() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
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
              // Photo
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: const CircleAvatar(
                   radius: 45,
                   backgroundColor: Colors.grey,
                   backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'), // Generic male avatar
                ),
              ),
              const SizedBox(width: 24),
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
        ],
      ),
    );
  }

  // Slide 3: User Interface Definition
  Widget _buildSlide3() {
    return Container(
      padding: const EdgeInsets.all(32),
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
          _buildBulletItem(
            TextSpan(
               style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
               children: [
                 const TextSpan(text: 'Antarmuka/ '),
                 TextSpan(text: 'user interface (UI)', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[800])),
                 const TextSpan(text: ' merupakan bagian dari komputer dan perangkat lunaknya yang dapat '),
                 const TextSpan(text: 'dilihat, \ndidengar, disentuh, ', style: TextStyle(fontWeight: FontWeight.bold)),
                 const TextSpan(text: 'dan '),
                 const TextSpan(text: 'diajak bicara, ', style: TextStyle(fontWeight: FontWeight.bold)),
                 const TextSpan(text: 'baik secara langsung maupun dengan proses pemahaman tertentu.'),
               ]
            )
          ),
          const SizedBox(height: 12),
          _buildBulletItem(
            TextSpan(
               style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
               children: [
                 const TextSpan(text: 'UI yang baik adalah UI yang '),
                 const TextSpan(text: 'tidak disadari, ', style: TextStyle(fontWeight: FontWeight.bold)),
                 const TextSpan(text: 'dan UI yang memungkinkan pengguna fokus pada informasi dan '),
                 const TextSpan(text: 'task ', style: TextStyle(fontStyle: FontStyle.italic)),
                 const TextSpan(text: 'tanpa perlu mengetahui mekanisme untuk menampilkan informasi dan melakukan '),
                 const TextSpan(text: 'task ', style: TextStyle(fontStyle: FontStyle.italic)),
                 const TextSpan(text: 'tersebut.'),
               ]
            )
          ),
          const SizedBox(height: 12),
          _buildBulletItem(
            const TextSpan(
               style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
               children: [
                 TextSpan(text: 'Komponen utamanya:\n'),
                 TextSpan(text: '  – Input\n'),
                 TextSpan(text: '  – Output'),
               ]
            )
          ),
        ],
      ),
    );
  }

  // Slide 4: Pentingnya Desain UI
  Widget _buildSlide4() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: Colors.white,
         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Stack(
        children: [
          // Background "Z" decorative elements could be added here
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Pentingnya Desain UI yang Baik',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              _buildBulletItem(
                const TextSpan(
                  style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
                  children: [
                    TextSpan(text: 'Banyak sistem dengan fungsionalitas yang baik tapi tidak efisien, membingungkan, dan tidak berguna karena '),
                    TextSpan(text: 'desain \nUI yang buruk', style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
                )
              ),
              const SizedBox(height: 12),
              _buildBulletItem(
                const TextSpan(
                  style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
                  children: [
                    TextSpan(text: 'Antarmuka yang baik merupakan jendela untuk melihat kemampuan sistem serta jembatan bagi kemampuan perangkat lunak'),
                  ]
                )
              ),
              const SizedBox(height: 12),
              _buildBulletItem(
                const TextSpan(
                  style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
                  children: [
                    TextSpan(text: 'Desain yang buruk akan '),
                    TextSpan(text: 'membingungkan, tidak efisien, ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '\nbahkan menyebabkan '),
                    TextSpan(text: 'frustasi', style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
                )
              ),
              const SizedBox(height: 50), // Space for image
            ],
          ),
          
          // Frustrated Man Image
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
              ),
              child: Image.network(
                'https://t3.ftcdn.net/jpg/02/92/62/59/360_F_292625936_Wk1X52C1E3FfdgTf3bF5va5f5F5f5F5.jpg', // Frustrated man
                height: 100,
                width: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey, width: 140, height: 100),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Helpers
  Widget _buildBulletItem(TextSpan textSpan) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(
          child: RichText(text: textSpan),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12, color: Colors.black87),
        children: [
          TextSpan(text: label, style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
