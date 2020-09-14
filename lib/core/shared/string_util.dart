import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StringUtil {
  static final StringUtil _instance = StringUtil._internal();
  String _encryptedPcode = '';
  bool _isPcodeHidden = true;

  factory StringUtil() {
    return _instance;
  }
  StringUtil._internal();

  bool get isPcodeHidden => _isPcodeHidden;
  String get encryptedPcode => _encryptedPcode;

  String encryptedString(String string) {
    if (string == null || string.isEmpty) return '';
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    return encrypter.encrypt(string, iv: iv).base64;
  }

  Future<void> readEncrptedData() async {
    final prefs = await SharedPreferences.getInstance();
    _isPcodeHidden = prefs.getBool('isPasscodeHidden') ?? true;
    _encryptedPcode = prefs.getString('pcd') ?? '';
  }  
}