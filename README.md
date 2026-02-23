# 🎓 UniHub - University Activity Management App

**Where growth starts**

A modern Flutter application for managing and discovering university activities, events, and competitions. Built with Flutter and Supabase.


---

## 📱 Features

- ✨ **User Authentication** - Secure email/password signup and login
- 🎯 **Featured Activities** - Auto-scrolling showcase of highlighted events
- 📂 **Category Organization** - Browse by Hackathons, CCIS, and Arts & Sports
- 🔍 **Activity Details** - View comprehensive information about each event
- ✅ **Join Activities** - One-click registration for events
- 👤 **User Profile** - View account details and logout
- 🎨 **Modern UI** - Clean, minimalist design with smooth animations

---

## 🖼️ Screenshots
<img width="499" height="859" alt="image" src="https://github.com/user-attachments/assets/004ddc4a-ade5-4867-9e96-d0efc6d51d90" />
<img width="498" height="849" alt="image" src="https://github.com/user-attachments/assets/9fccef48-60f4-4836-8ff1-9418f32f4fd8" />
<img width="494" height="855" alt="image" src="https://github.com/user-attachments/assets/abc89f89-de13-477f-88d3-b7698de2d449" />
<img width="499" height="849" alt="image" src="https://github.com/user-attachments/assets/45d5c4a1-b0e2-4d8a-b491-f28dcca47b86" />



---

## 🛠️ Built With

- **[Flutter](https://flutter.dev/)** - UI framework
- **[Supabase](https://supabase.com/)** - Backend as a Service
  - Authentication
  - PostgreSQL Database
- **[Dart](https://dart.dev/)** - Programming language

---

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point
├── models/
│   └── activity.dart              # Activity data model
├── services/
│   └── api_service.dart           # Supabase API calls
└── screens/
    ├── login_screen.dart          # Login page
    ├── signup_screen.dart         # Signup page
    ├── home_screen.dart           # Main dashboard
    ├── activity_detail_screen.dart # Activity details
    └── profile_screen.dart        # User profile
```

---

## 🎨 Design System

### Colors

- **Primary Blue**: `#2A52BE` - Brand color
- **Orange**: `#E67E22` - Action buttons
- **White**: `#FFFFFF` - Background
- **Grey**: Various shades for text

### Typography

- **Logo**: 48px, Bold
- **Headers**: 36px, Bold
- **Subheaders**: 20px, Bold
- **Body**: 16px, Regular

### Components

- Border radius: 15px (rounded corners)
- Button height: 56px
- Spacing: 24px padding

---

## 🔑 Key Concepts

### Authentication Flow

1. User signs up or logs in
2. Supabase handles authentication
3. Session is maintained automatically
4. User can logout anytime

### Data Flow

1. `ApiService` fetches data from Supabase
2. Data is converted to `Activity` models
3. UI displays activities in categorized lists
4. User interactions trigger database updates

---

## 🌟 Features in Detail

### Auto-Scrolling Featured Section

- Automatically scrolls every 3 seconds
- Manual swipe supported
- Page indicator dots
- Larger cards for prominence

### Category Lists

- Horizontal scrolling
- Smaller card size
- Organized by type
- Pull to refresh

### Join Activities

- One-click join button
- Stores user-activity relationship
- Prevents duplicate joins
- Success/error feedback

---
