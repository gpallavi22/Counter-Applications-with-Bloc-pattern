import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class AESHelper {
  // 🔑 Must be 16 / 24 / 32 chars (AES-128 / 192 / 256)
  static final _key = encrypt.Key.fromUtf8('12345678901234567890123456789012'); // 32 chars
  static final _iv = encrypt.IV.fromUtf8('1234567890123456'); // 16 chars

  static final _encrypter = encrypt.Encrypter(
    encrypt.AES(_key, mode: encrypt.AESMode.cbc),
  );

  /// 🔐 Encrypt Data
  static String encryptData(dynamic data) {
    final jsonString = jsonEncode(data);
    final encrypted = _encrypter.encrypt(jsonString, iv: _iv);
    return encrypted.base64;
  }

  /// 🔓 Decrypt Data
  static dynamic decryptData(String encryptedData) {
    final decrypted = _encrypter.decrypt64(encryptedData, iv: _iv);
    return jsonDecode(decrypted);
  }
}