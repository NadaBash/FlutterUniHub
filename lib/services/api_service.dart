import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/activity.dart';

// Service class for API calls to Supabase
// Following bootcamp pattern: services folder with methods that return lists
class ApiService {
  // Get Supabase client instance
  final supabase = Supabase.instance.client;

  // Fetch all activities from database
  // Returns a list of Activity objects
  Future<List<Activity>> fetchActivities() async {
    try {
      // Query the 'activities' table
      // Order by creation date (newest first)
      final response = await supabase
          .from('activities')
          .select()
          .order('created_at', ascending: false);

      // FIXED: Handle response properly
      List<Activity> activities = [];
      
      // Check if response is a List
      if (response is List) {
        // Loop through each item and convert to Activity
        for (var json in response) {
          try {
            activities.add(Activity.fromJson(json as Map<String, dynamic>));
          } catch (e) {
            print('Error parsing activity: $e');
            // Skip this activity if there's an error
          }
        }
      }

      return activities;
    } catch (e) {
      print('Error fetching activities: $e');
      // Return empty list if there's an error
      return [];
    }
  }

  // Join an activity
  // Creates a new record in user_activities table
  Future<void> joinActivity(String activityId) async {
    try {
      // Get current logged-in user's ID
      final userId = supabase.auth.currentUser?.id;
      
      // Check if user is logged in
      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Insert into user_activities table
      await supabase.from('user_activities').insert({
        'user_id': userId,
        'activity_id': activityId,
      });
    } catch (e) {
      print('Error joining activity: $e');
      throw e; // Re-throw so the UI can show error
    }
  }
}