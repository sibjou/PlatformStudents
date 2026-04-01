import 'package:flutter_test/flutter_test.dart';
import '../lib/data/local/hash_utils.dart';

void main() {
  test('Демонстрация работы хеширования (MD5)', () {
    
    final data1 = "Задание №1: Решить уравнение";
    final data2 = "Задание №1: Решить Уравнение"; // Изменили одну букву
    
    final hash1 = HashUtils.generateHash(data1);
    final hash2 = HashUtils.generateHash(data2);
    
    print('Данные 1: $data1');
    print('Хеш 1:   $hash1');
    
    print('\nДанные 2: $data2');
    print('Хеш 2:   $hash2');
    
    // Проверка: хеши должны быть разными из за одной буквы
    expect(hash1, isNot(hash2));
    print('\n Хеши разные, система видит изменение данных');
    print('--------------------------------\n');
  });
}