import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  
  static final _storage = FlutterSecureStorage();
  static const _tokenKey = 'TOKEN';
  static const _emailKey = 'EMAIL';
  static const _uidKey ='UID';

  Future<void> setLoginData(String email, String token, String uid) async {
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _uidKey, value: uid);
  }

  Future<bool> hasToken() async {
    var value = await _storage.read(key: _tokenKey);
    return value != null;
  }

  /*Future<bool> hasEmail() async {
    var value = _storage.read(key: _emailKey);
    return value != null;
  }

  Future<void> deleteToken() async {
    return _storage.delete(key: _tokenKey);
  }

  Future<void> deleteEmail() async {
    return _storage.delete(key: _emailKey);
  }*/

  Future<String?> getEmail() async {
    return _storage.read(key: _emailKey);
  }

  Future<String?> getToken() async {
    //String value = await _storage.read(key: _tokenKey);
    return _storage.read(key: _tokenKey);
  }

  Future<String?> getUid() async {
    return _storage.read(key: _uidKey);
  }

  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }
}