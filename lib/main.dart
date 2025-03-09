// import 'package:flutter/material.dart';
// import 'screens/dashboard.dart'; // Impor dashboard.dart

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Ekonomi Kreatif Nganjuk',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Dashboard(), // Menampilkan Dashboard sebagai halaman utama
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'screens/notifikasi_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification App',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const NotifikasiScreen(),
    );
  }
}
