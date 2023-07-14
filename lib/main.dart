import 'package:darebny/providers/category_provider.dart';
import 'package:darebny/providers/opportunities_provider.dart';
import 'package:darebny/screens/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider<OpportunitiesProvider>(
        create: (_) => OpportunitiesProvider(),
      ),
      ChangeNotifierProvider<CategoryProvider>(
        create: (_) => CategoryProvider(),
      ),
    ],
    child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Splash(),
    );
  }
}