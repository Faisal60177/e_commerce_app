import 'dart:async';
import 'dart:developer' as dev;

import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final crashlytics = FirebaseCrashlytics.instance;
  await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      dev.log(
        'FlutterError',
        error: details.exception,
        stackTrace: details.stack,
      );
    } else {
      unawaited(crashlytics.recordFlutterFatalError(details));
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      dev.log('Uncaught error', error: error, stackTrace: stack);
    } else {
      unawaited(crashlytics.recordError(error, stack, fatal: true));
    }
    return true;
  };

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: await builder(),
    ),
  );
}