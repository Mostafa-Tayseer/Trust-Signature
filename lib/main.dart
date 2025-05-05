import 'package:flutter/material.dart';
import 'package:project_youssef/login_page.dart';
import 'package:project_youssef/upload_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://aprhjthhyqzlevpwufrk.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFwcmhqdGhoeXF6bGV2cHd1ZnJrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYzMDE0MDcsImV4cCI6MjA2MTg3NzQwN30.9LWrsfuXKb8b08QT_2qjFJ1RtcDhXACmoFCuKEDTSxQ",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadPage(),
    );
  }
}

