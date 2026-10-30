import 'dart:async';
import 'dart:developer' as dev;
import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {bbbbbbb
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    dev.log('FlutterError', error: details.exception, stackTrace: details.stack);

  };
  PlatformDispatcher.instance.onError =(error,stack) {
    dev.log('Uncaught error', error: error, stackTrace: stack);
    return true;
  };

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: await builder(),)
  );
}

