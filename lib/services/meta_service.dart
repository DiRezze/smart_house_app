import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:firebase_database/firebase_database.dart';

class MetaService {
  static final MetaService _instance = MetaService._internal();
  User? get user => FirebaseAuth.instance.currentUser;
  String? get uid => user?.uid;
  factory MetaService() => _instance;
  MetaService._internal();

  static String? _cachedName;

  final db = FirebaseDatabase.instance;

  final prefs = PrefsService();

  Future<void> updateMeta() async {
    try {
      if (uid == null) return;
      final ref = db.ref('users/$uid/meta');
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        final name = data['displayName'];
        if (name != null && name.toString().isNotEmpty) {
          await PrefsService().setString('displayName', name);
          _cachedName = name;
        }
      }
    }
    catch (e) {
      // pass
    }

  }

  Future<String?> getDisplayName() async {
    if (_cachedName != null) {
      return _cachedName;
    }
    try {
      final name = await prefs.getString('displayName');
      if (name != null && name.isNotEmpty) {
        _cachedName = name;
        return name;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  Future<void> flushMeta() async {
    await PrefsService().clear();
  }

}