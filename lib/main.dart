import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_with_adapter/model/notes_model.dart';
import 'package:hive_with_adapter/view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(notesmodelAdapter());
  var box = await Hive.openBox<notesmodel>('notebox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
