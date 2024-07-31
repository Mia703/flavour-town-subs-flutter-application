import 'package:camera/camera.dart';
import 'package:flavour_town_subs_flutter_application/database/api.dart';
import 'package:flavour_town_subs_flutter_application/pages/home_page.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flavour_town_subs_flutter_application/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// gobal user object. udpates as user logs in and out
CurrentUser currentUser = CurrentUser();

// returns the list of cameras available on the device
late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseURL, anonKey: supabaseKey);
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavour Town Subs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // set the background colour
        scaffoldBackgroundColor: primaryColourWhite,
        // set the font family; google font's 'anybody' font
        textTheme: GoogleFonts.anybodyTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
