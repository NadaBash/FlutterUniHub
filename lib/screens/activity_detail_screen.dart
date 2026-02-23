import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../services/api_service.dart';


class ActivityDetailScreen extends StatefulWidget {
  final Activity activity; 

  ActivityDetailScreen({required this.activity});

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  
  final ApiService apiService = ApiService();
  
  
  bool isJoining = false;

  
  Future<void> joinActivity() async {
    setState(() {
      isJoining = true;
    });

    try {
      
      await apiService.joinActivity(widget.activity.id);

      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully joined activity!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to join: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      
      if (mounted) {
        setState(() {
          isJoining = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      
      body: CustomScrollView(
        slivers: [
          
          SliverAppBar(
            expandedHeight: 300, 
            pinned: true, 
            backgroundColor: Color(0xFF2A52BE),
            
            
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            
            
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image.network(
                  widget.activity.imageUrl,
                  fit: BoxFit.cover,
                  
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.image, size: 100, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),
          
          
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF2A52BE).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      widget.activity.category,
                      style: TextStyle(
                        color: Color(0xFF2A52BE),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  
                  Text(
                    widget.activity.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                  SizedBox(height: 12),
                  
                  
                  Text(
                    widget.activity.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5, 
                    ),
                  ),
                  
                  SizedBox(height: 100), 
                ],
              ),
            ),
          ),
        ],
      ),
      
      
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: isJoining ? null : joinActivity,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE67E22), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: isJoining
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Join Activity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}