import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashUtils {
  /// Создает "цифровой отпечаток" (MD5 хеш) для любой строки
  static String generateHash(String input) {
    final bytes = utf8.encode(input);
    return md5.convert(bytes).toString();
  }

  ///  соответствуют ли данные своему хешу (защита от подмены)
  static bool verify(String input, String hash) {
    return generateHash(input) == hash;
  }
}