import 'package:flutter/material.dart';

class SubmissionScreen extends StatelessWidget {
  const SubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Background behind the "sheet"
      body: SafeArea(
        child: Column(
          children: [
            // Spacer to make it look like a bottom sheet if desired, 
            // or just full screen. Given "page" context, we might want full screen 
            // but styled like the image. The image shows a full red header top.
            
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // If we want the top rounded corners look:
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              // Header Section
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFB71C1C), // Telkom Red
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    // Drag Handle
                                    Container(
                                      width: 60,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Title
                                    const Text(
                                      'Upload File',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Content
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Maksimum File 5MB , Maksimum Jumlah File 20',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13, 
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87
                                        ),
                                      ),
                                      const SizedBox(height: 32),

                                      // Dashed Upload Area
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 70.0),
                                        child: AspectRatio(
                                          aspectRatio: 1.4,
                                          child: CustomPaint(
                                            painter: DashedRectPainter(
                                              color: Colors.black54, 
                                              strokeWidth: 1.5, 
                                              gap: 6.0
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  // Asset Image
                                                  Image.asset(
                                                    'assets/images/aploud.PNG',
                                                    height: 30,
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Icon(
                                                        Icons.cloud_upload_rounded, 
                                                        size: 30, 
                                                        color: Colors.blue[400]
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Text(
                                                    'File yang akan di upload akan tampil di sini',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 15), // Replaced Spacer with fixed space for scrolling safety
                                      
                                      // Buttons
                                      SizedBox(
                                        width: 160,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[100],
                                            foregroundColor: Colors.black87,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          ),
                                          child: const Text('Pilih File', style: TextStyle(fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        width: 160,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[100],
                                            foregroundColor: Colors.black87,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          ),
                                          child: const Text('Simpan', style: TextStyle(fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;

  DashedRectPainter({this.strokeWidth = 1.0, this.color = Colors.black, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = Path();
    Path _bottomPath = Path();
    Path _leftPath = Path();
    Path _rightPath = Path();

    PathWrapper pathWrapper = PathWrapper();

    pathWrapper.addLine(0, x, 0, 0, _topPath, gap);
    pathWrapper.addLine(0, x, y, y, _bottomPath, gap);
    pathWrapper.addLine(0, 0, 0, y, _leftPath, gap);
    pathWrapper.addLine(x, x, 0, y, _rightPath, gap);
    
    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PathWrapper {
  void addLine(double startX, double endX, double startY, double endY, Path path, double gap) {
      // Logic for drawing dashed line
      if (startY == endY) { // Horizontal
         double currentX = startX;
         while (currentX < endX) {
            double remaining = endX - currentX;
            double dash = remaining < 10 ? remaining : 10;
            path.moveTo(currentX, startY);
            path.lineTo(currentX + dash, startY);
            currentX += 10 + gap;
         }
      } else { // Vertical
         double currentY = startY;
         while (currentY < endY) {
            double remaining = endY - currentY;
            double dash = remaining < 10 ? remaining : 10;
            path.moveTo(startX, currentY);
            path.lineTo(startX, currentY + dash);
            currentY += 10 + gap;
         }
      }
  }
}
