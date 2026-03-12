import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class UrlHelper {
  /// Launches a standard web URL. Prepends https:// if missing.
  static Future<void> launchWebsite(String url) async {
    if (url.isEmpty) return;
    
    String finalUrl = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      finalUrl = 'https://$url';
    }

    final Uri uri = Uri.parse(finalUrl);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch website: $finalUrl');
      }
    } catch (e) {
      debugPrint('Error launching website: $finalUrl, Error: $e');
    }
  }

  /// Launches a WhatsApp chat with the given number.
  static Future<void> launchWhatsApp(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;
    
    // Remove '+' or spaces for the whatsapp scheme
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    final Uri uri = Uri.parse('https://wa.me/$cleanNumber');
    
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch WhatsApp for: $phoneNumber');
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $phoneNumber, Error: $e');
    }
  }

  /// Launches an email draft to the given email address.
  static Future<void> launchEmail(String email) async {
    if (email.isEmpty) return;

    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    
    try {
      if (!await launchUrl(uri)) {
        debugPrint('Could not launch email to: $email');
      }
    } catch (e) {
      debugPrint('Error launching email: $email, Error: $e');
    }
  }

  /// Launches the device dialer with the given phone number.
  static Future<void> launchPhone(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;

    // Use tel scheme
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri uri = Uri(
      scheme: 'tel',
      path: cleanNumber,
    );
    
    try {
      if (!await launchUrl(uri)) {
        debugPrint('Could not launch phone: $phoneNumber');
      }
    } catch (e) {
      debugPrint('Error launching phone: $phoneNumber, Error: $e');
    }
  }
}
