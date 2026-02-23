

class Activity {
  final String id;           
  final String title;        
  final String category;     
  final String description;  
  final String imageUrl;     
  final bool isFeatured;     

  
  Activity({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.isFeatured = false,
  });

  
  
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      isFeatured: json['is_featured'] ?? false,
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'image_url': imageUrl,
      'is_featured': isFeatured,
    };
  }
}