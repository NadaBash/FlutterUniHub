import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  
  
  await Supabase.initialize(
    url: 'https://pezqfyfmdadnhhrmveqk.supabase.co',
    anonKey: 'sb_publishable_B7kHeF702YsPQuGhSS8cBg_94WQsfgD', 
  );
  

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniHub',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primaryColor: Color(0xFF2A52BE), 
        scaffoldBackgroundColor: Colors.white, 
      ),
      home: LoginScreen(),
    );
  }
}


class AuthChecker extends StatefulWidget {
  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  @override
void initState() {
  super.initState();
  
  WidgetsBinding.instance.addPostFrameCallback((_) {
    checkAuth();
  });
}

  
  void checkAuth() {
    final session = Supabase.instance.client.auth.currentSession;
    
    
    if (session != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}