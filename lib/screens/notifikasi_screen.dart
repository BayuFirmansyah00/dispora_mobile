import 'package:flutter/material.dart';
import '../widgets/notification_item.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and title
              Padding(
                padding: const EdgeInsets.only(top: 51),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/return_icon.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Notifikasi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Archivo',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF171A1F),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.only(top: 43),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/search_icon.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Cari',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFBCC1CA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 17),
                    Image.asset(
                      'assets/icons/filter_icon.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              // Notification items
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      NotificationItem(
                        imageUrl:
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/439c348230591606807769415ac41970e4f1a5b9574f3e8ea54546cd99ea6ef7?placeholderIfAbsent=true&apiKey=25ad814c905a4c70a9074c709eade236',
                        title: 'Informasi Event',
                        description:
                            'Pentas pantonim tingkat kabupaten nganjuk....',
                      ),
                      const SizedBox(height: 12),
                      NotificationItem(
                        imageUrl:
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/60811d19bad586d20db3a1f506e9d2efddf716bfc57c368decc81a0b1d6d35d5?placeholderIfAbsent=true&apiKey=25ad814c905a4c70a9074c709eade236',
                        title: 'Informasi Event',
                        description:
                            'Bazar umkm bertujuan untuk meningkatkan kabupaten nganjuk...',
                      ),
                      const SizedBox(height: 12),
                      NotificationItem(
                        imageUrl:
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/b0d41b383417a56bf45ab6eb006c8c424f5296a852521851e7a70fac067cf4c1?placeholderIfAbsent=true&apiKey=25ad814c905a4c70a9074c709eade236',
                        title: 'Informasi Event',
                        description:
                            'Warga kabupaten Nganjuk menggelar pentas .....',
                      ),
                      const SizedBox(height: 12),
                      NotificationItem(
                        imageUrl:
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/ce179dd90a717ac37bceb75bfa5ac265d4a745592351faa13be138ba2863837b?placeholderIfAbsent=true&apiKey=25ad814c905a4c70a9074c709eade236',
                        title: 'Informasi Event',
                        description:
                            'Seminar webbinar bersama sonia damanik.....',
                      ),
                      const SizedBox(height: 12),
                      NotificationItem(
                        imageUrl:
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/87becc3e6912607c7ce43a275ffb7d9f53017679b9cce1b0665bd9de5b7bcc10?placeholderIfAbsent=true&apiKey=25ad814c905a4c70a9074c709eade236',
                        title: 'Informasi Event',
                        description:
                            'Workshop fotografi untuk kalangan remaja yang bertujuan.....',
                      ),
                      const SizedBox(height: 12),
                      NotificationItem(
                        imageUrl:
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/1a839dbae2f9283feaea81c7cd333e449a3072d3cbc2a47c1e2ae6235ac7203c?placeholderIfAbsent=true&apiKey=25ad814c905a4c70a9074c709eade236',
                        title: 'Informasi Event',
                        description:
                            'Sharing seputar dunia desain & Digital....',
                      ),
                      const SizedBox(height: 12),
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
}
