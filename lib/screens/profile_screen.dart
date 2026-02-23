import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  String userEmail = '';
  
  
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserInfo(); 
  }

  
  void loadUserInfo() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email ?? 'No email';
      });
    }
  }

  
  Future<void> logout() async {
    setState(() {
      isLoading = true;
    });

    try {
      
      await Supabase.instance.client.auth.signOut();

      
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false, 
        );
      }
    } catch (e) {
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: $e')),
        );
      }
    } finally {
      
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF2A52BE)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF2A52BE),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            
            
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFF2A52BE).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 60,
                color: Color(0xFF2A52BE),
              ),
            ),
            
            SizedBox(height: 24),
            
            
            Text(
              'Logged in as:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            
            SizedBox(height: 8),
            
            
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            
            Spacer(),
            
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}