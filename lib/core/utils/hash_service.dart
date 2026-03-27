import 'dart:convert';
import '../../data/models/hash_data.dart';

class HashService {
  // Метод для создания HashUsl (данные задачи)
  static String encodeHashUsl(HashUslData data) {
    final rawString = "${data.teacherId}|${data.studentId}|${data.startTaskId}|${data.seed}|${data.timestamp}";
    return _encodeWithChecksum(rawString);
  }

  // Метод для расшифровки HashUsl
  static HashUslData decodeHashUsl(String hash) {
    final decoded = _decodeWithChecksum(hash);
    final parts = decoded.split('|');

    return HashUslData(
      teacherId: parts[0],
      studentId: parts[1],
      startTaskId: int.parse(parts[2]),
      seed: int.parse(parts[3]),
      timestamp: int.parse(parts[4]),
    );
  }

  // Вспомогательный метод: Кодирование + Контрольная сумма
  static String _encodeWithChecksum(String data) {
    final bytes = utf8.encode(data);
    final checksum = bytes.fold<int>(0, (prev, element) => prev + element) % 256; // Простая сумма
    final finalData = "$data|$checksum";
    return base64Url.encode(utf8.encode(finalData)).replaceAll('=', '');
  }

  // Вспомогательный метод: Декодирование + Проверка
  static String _decodeWithChecksum(String hash) {
    try {
      // Добавляем padding если нужно для base64
      String normalizedHash = hash;
      while (normalizedHash.length % 4 != 0) { normalizedHash += '='; }

      final decodedData = utf8.decode(base64Url.decode(normalizedHash));
      final parts = decodedData.split('|');
      final checksum = int.parse(parts.last);
      final rawContent = parts.sublist(0, parts.length - 1).join('|');

      // Проверка контрольной суммы
      final actualSum = utf8.encode(rawContent).fold<int>(0, (prev, element) => prev + element) % 256;

      if (actualSum != checksum) {
        throw Exception("Ошибка контрольной суммы: данные повреждены или опечатка");
      }
      return rawContent;
    } catch (e) {
      throw Exception("Некорректный формат хэша");
    }
  }
}