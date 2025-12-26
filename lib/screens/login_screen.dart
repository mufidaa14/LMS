import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  // Warna Merah Maroon
  final Color maroonColor = const Color(0xFF800000); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========================
              // HEADER & LOGO (STACK APPROACH)
              // ========================
              // Menggunakan Stack untuk overlap yang "LEGAL" (Aman dari error negative margin)
              Stack(
                clipBehavior: Clip.none, // Izinkan logo keluar dari batas bawah header
                alignment: Alignment.center,
                children: [
                  // 1. HEADER (Gradient & Wave)
                  ClipPath(
                    clipper: HeaderWaveClipper(),
                    child: Container(
                      height: 150, 
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF600000), // Dark Red
                            maroonColor, // Maroon
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 2. LOGO (Positioned Overlap)
                  // Posisikan di bawah (bottom: -40) agar setengahnya keluar
                  Positioned(
                    bottom: -40, 
                    child: Container(
                      width: 90, 
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: maroonColor, // Changed from Colors.white
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10, 
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16), // A bit more padding for the logo
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/login_logo.png', // New Logo
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.school, size: 40, color: Colors.white);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Spacer untuk memberi tempat bagi Logo yang "numpang"
              // Karena logo keluar 40px dari Stack, kita butuh spacer 40px + margin tambahan
              const SizedBox(height: 60), 

              // ========================
              // TITLE
              // ========================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 26, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // ========================
              // FORM FIELDS
              // ========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Email
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: maroonColor.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: maroonColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: maroonColor, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        isDense: true,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Password
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: maroonColor.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: maroonColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: maroonColor, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ========================
              // BUTTON & HELP
              // ========================
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(top: 32, left: 24, right: 24),
                decoration: BoxDecoration(
                  color: maroonColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: maroonColor.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.of(context).pushReplacementNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 32),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lupa Password?",
                      style: TextStyle(
                        color: maroonColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // ========================
              // FOOTER
              // ========================
              ClipPath(
                clipper: FooterDecorationClipper(),
                child: Container(
                  height: 100, 
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [maroonColor, const Color(0xFFA00000)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HEADER CLIPPER (INVERTED WAVE)
class HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Start bottom-leftish

    // Convex curve down
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0); // Top Right
    path.lineTo(0, 0); // Top Left
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// FOOTER CLIPPER
class FooterDecorationClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 20); 
    
    var controlPoint1 = Offset(size.width * 0.3, -20); 
    var endPoint1 = Offset(size.width * 0.6, 30);
    path.quadraticBezierTo(controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);
    
    var controlPoint2 = Offset(size.width * 0.8, 60); 
    var endPoint2 = Offset(size.width, 20);
    path.quadraticBezierTo(controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);
    
    path.lineTo(size.width, size.height); 
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
