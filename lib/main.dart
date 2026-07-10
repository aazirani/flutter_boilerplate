import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_boilerplate/di/service_locator.dart';
import 'package:flutter_boilerplate/presentation/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  await ServiceLocator.configure();

  runApp(const ProviderScope(child: MyApp()));
}
