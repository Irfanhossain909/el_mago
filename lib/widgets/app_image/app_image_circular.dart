import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppImageCircular extends StatelessWidget {
  const AppImageCircular({
    super.key,
    this.color = Colors.blue,
    this.fit = BoxFit.cover,
    this.height,
    this.path,
    this.url,
    this.width,
    this.filePath,
    this.borderRadius = 100,
    this.borderColor = Colors.transparent, // New parameter for border color
  });
  final String? path;
  final String? filePath;
  final String? url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color color;
  final Color borderColor; // Customizable border color

  @override
  Widget build(BuildContext context) {
    // >>>>>>>>>>>>>>>>>>>>>> Check for file image first <<<<<<<<<<<<<<<<<<<<<<
    if (filePath != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ), // Use the passed borderColor
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.file(
            File(filePath!),
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              log("Error loading file image: $error");
              return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.pinkAccent,
                ),
              );
            },
          ),
        ),
      );
    }

    // >>>>>>>>>>>>>>>>>>>>>> Check for network image (URL) <<<<<<<<<<<<<<<<<<<<<<
    if (url != null && url!.isNotEmpty) {
      String imageUrl = url!;
      if (!(imageUrl.startsWith("http://") ||
          imageUrl.startsWith("https://"))) {
        imageUrl = "https://$imageUrl"; // Add 'https' if not present
      }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ), // Use the passed borderColor
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              log("Error loading network image: $error");
              return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.pinkAccent,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.pinkAccent,
                  child: const CupertinoActivityIndicator(color: Colors.black),
                ),
              );
            },
          ),
        ),
      );
    }

    // >>>>>>>>>>>>>>>>>>>>>> Check for local asset image <<<<<<<<<<<<<<<<<<<<<<
    if (path != null) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ), // Use the passed borderColor
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            path!,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              log("Error loading asset image: $error");
              return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.pinkAccent,
                ),
              );
            },
          ),
        ),
      );
    }

    // >>>>>>>>>>>>>>>>>>>>>> Default widget when no image source is provided <<<<<<<<<<<<<<<<<<<<<<
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ), // Use the passed borderColor
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(width: width, height: height, color: color),
      ),
    );
  }
}


