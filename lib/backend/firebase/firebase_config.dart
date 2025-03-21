import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyALUenUEOTd_bvvJY4lq0_a5hwqVkokutY",
            authDomain: "musicnearme-akash-n3hrd5.firebaseapp.com",
            projectId: "musicnearme-akash-n3hrd5",
            storageBucket: "musicnearme-akash-n3hrd5.firebasestorage.app",
            messagingSenderId: "311035935284",
            appId: "1:311035935284:web:9b18533ae2b94bbcd3e861"));
  } else {
    await Firebase.initializeApp();
  }
}
