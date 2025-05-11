import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class EventlistItemWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String? createdAt; // Parameter untuk createdAt
  final VoidCallback? onTapColumnSelengkap;

  const EventlistItemWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.createdAt,
    this.onTapColumnSelengkap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapColumnSelengkap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xFF123458),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 168,
                width: double.maxFinite,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, size: 100, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  if (createdAt != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        createdAt!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          "Selengkapnya",
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmallOnPrimary,
                        ),
                      ),
                      SizedBox(width: 4),
                      CustomImageView(
                        imagePath: ImageConstant.arrow,
                        height: 12,
                        width: 12,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}