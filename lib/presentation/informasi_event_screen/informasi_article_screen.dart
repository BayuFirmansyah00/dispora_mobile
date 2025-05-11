import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/Article.dart';

class InformasiArticleScreen extends StatelessWidget {
  final Article data;

  const InformasiArticleScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  // Fungsi untuk menampilkan gambar dalam ukuran asli saat diklik
  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, size: 100, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Formatter untuk updatedAt
  String? _formatUpdatedAt(Article data) {
    if (data.updatedAt == null) {
      print('updatedAt is null'); // Debug log
      return null;
    }
    try {
      return DateFormat('dd MMM yyyy, HH:mm').format(data.updatedAt!);
    } catch (e) {
      print('Error formatting updatedAt: $e'); // Debug log
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Debug log untuk memeriksa data
    print('InformasiArticleScreen data:');
    print('title: ${data.title}');
    print('thumbnail: ${data.thumbnail}');
    print('content: ${data.content}');
    print('createdAt: ${data.createdAt}');
    print('formattedCreatedAt: ${data.formattedCreatedAt}');
    print('updatedAt: ${data.updatedAt}');

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Artikel')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan gambar
            if (data.thumbnail.isNotEmpty)
              GestureDetector(
                onTap: () => _showFullImage(context, data.thumbnail),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    data.thumbnail,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 100),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            // Judul
            Text(
              data.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Tampilkan created_at
            Text(
              'Dibuat pada: ${data.formattedCreatedAt ?? 'Tanggal tidak tersedia'}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            // Tampilkan updated_at
            Text(
              'Diperbarui pada: ${_formatUpdatedAt(data) ?? 'Tanggal tidak tersedia'}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            // Tampilkan content
            Text(
              'Isi artikel: ${data.content?.isNotEmpty == true ? data.content : 'Belum ada konten'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}