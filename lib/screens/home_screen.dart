import 'package:flutter/material.dart';
import 'dart:async'; 
import '../models/activity.dart';
import '../services/api_service.dart';
import 'activity_detail_screen.dart';
import 'profile_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final ApiService apiService = ApiService();
  
  
  List<Activity> allActivities = [];
  List<Activity> featuredActivities = [];
  List<Activity> hackathons = [];
  List<Activity> ccisActivities = [];
  List<Activity> artsAndSports = [];
  
  
  bool isLoading = true;
  
  
  PageController featuredPageController = PageController();
  Timer? autoScrollTimer;
  int currentFeaturedPage = 0;

  @override
  void initState() {
    super.initState();
    loadActivities(); 
    startAutoScroll(); 
  }

  
  void startAutoScroll() {
    
    autoScrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (featuredActivities.isNotEmpty) {
        
        currentFeaturedPage = (currentFeaturedPage + 1) % featuredActivities.length;
        
        
        if (featuredPageController.hasClients) {
          featuredPageController.animateToPage(
            currentFeaturedPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  
  Future<void> loadActivities() async {
    setState(() {
      isLoading = true;
    });

    try {
      
      final activities = await apiService.fetchActivities();

      setState(() {
        allActivities = activities;
        
        
        featuredActivities = activities.where((a) => a.isFeatured).toList();
        
        
        hackathons = activities.where((a) => a.category == 'Hackathons').toList();
        ccisActivities = activities.where((a) => a.category == 'CCIS').toList();
        artsAndSports = activities.where((a) => a.category == 'Arts & Sports').toList();
        
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load activities: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    
    autoScrollTimer?.cancel();
    featuredPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'UniHub',
          style: TextStyle(
            color: Color(0xFF2A52BE),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Color(0xFF2A52BE)),
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      
      
      body: isLoading
          ? Center(child: CircularProgressIndicator()) 
          : RefreshIndicator(
              onRefresh: loadActivities, 
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        'Enjoy!',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    
                    if (featuredActivities.isNotEmpty) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'Featured',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      
                      
                      SizedBox(
                        height: 240, 
                        child: PageView.builder(
                          controller: featuredPageController,
                          onPageChanged: (index) {
                            
                            setState(() {
                              currentFeaturedPage = index;
                            });
                          },
                          itemCount: featuredActivities.length,
                          itemBuilder: (context, index) {
                            return buildFeaturedCard(featuredActivities[index]);
                          },
                        ),
                      ),
                      
                      
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          featuredActivities.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentFeaturedPage == index
                                  ? Color(0xFF2A52BE)
                                  : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],

                    
                    if (hackathons.isNotEmpty)
                      buildCategorySection('Hackathons', hackathons),

                    
                    if (ccisActivities.isNotEmpty)
                      buildCategorySection('CCIS', ccisActivities),

                    
                    if (artsAndSports.isNotEmpty)
                      buildCategorySection('Arts & Sports', artsAndSports),

                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  
  Widget buildFeaturedCard(Activity activity) {
    return GestureDetector(
      onTap: () {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityDetailScreen(activity: activity),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                activity.imageUrl,
                height: 180, 
                width: double.infinity,
                fit: BoxFit.cover,
                
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            
            
            Text(
              activity.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  
  Widget buildCategorySection(String title, List<Activity> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 12),
        
        
        SizedBox(
          height: 180, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              return buildActivityCard(activities[index]);
            },
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  
  Widget buildActivityCard(Activity activity) {
    return GestureDetector(
      onTap: () {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityDetailScreen(activity: activity),
          ),
        );
      },
      child: Container(
        width: 140, 
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                activity.imageUrl,
                height: 120, 
                width: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: 140,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            
            
            Text(
              activity.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}