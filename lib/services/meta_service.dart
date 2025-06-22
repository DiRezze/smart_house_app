import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:firebase_database/firebase_database.dart';

class MetaService {
  static final MetaService _instance = MetaService._internal();
  final user = FirebaseAuth.instance.currentUser;
  get uid => user?.uid;
  factory MetaService() => _instance;
  MetaService._internal();

  final db = FirebaseDatabase.instance;

  Future<void> updateMeta() async {
    try {
      final ref = db.ref('users/$uid/meta');
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        if (data['displayName'] != null && data['displayName'].toString().isNotEmpty) {
          await PrefsService().setString('displayName', data['displayName']);
        }

      }
    }
    catch (e) {
      // pass
    }

  }

}