import 'package:flavour_town_subs_flutter_application/api.dart';
import 'package:flavour_town_subs_flutter_application/pages/home_page.dart';
import 'package:flavour_town_subs_flutter_application/pages/components/products_grid_cold.dart';
import 'package:flavour_town_subs_flutter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseURL, anonKey: supabaseKey);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  // this is the root of your application.
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavour Town Subs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // sets the background color
        scaffoldBackgroundColor: primaryWhite,
        // set the font family to googl's 'anybody' font
        textTheme: GoogleFonts.anybodyTextTheme(Theme.of(context).textTheme),
      ),
      home: const Scaffold(
        // body: ProductsGrid(),
        body: HomePage(),
      ),
    );
  }
}
