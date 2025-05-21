import 'package:flutter/material.dart';

class AppConstants {
  // Text Constants
  static const String name = "Vishal A V";
  static const String title = "Flutter Developer";
  static const String shortBio =
      "Creative and detail-oriented Flutter developer passionate about building fast, responsive, "
      "and visually stunning apps for Android, iOS, and the web. Experienced in integrating modern "
      "UI/UX, managing app state with GetX, and implementing real-time features using Firebase and Supabase. "
      "Committed to writing clean, maintainable code and delivering seamless cross-platform user experiences.";




  static const String fullBio =
      "A passionate Flutter developer with over two and a half years of experience crafting high-quality, "
      "cross-platform applications for Android, iOS, and the web. Focused on delivering intuitive, responsive, "
      "and scalable user experiences, with a strong command over Flutter and Dart, combined with a deep understanding "
      "of mobile app architecture and UI design principles.\n\n"
      "Graduated with a Bachelor's degree in Computer Science Engineering in 2022, bringing both academic excellence and "
      "real-world application to every project. Currently working as a Software Engineer at Coffeeweb Technologies Pvt Ltd "
      "since January 2023, contributing significantly to the development and maintenance of production-level apps, including "
      "the company’s flagship application. Adept at solving complex problems, implementing robust features, and ensuring seamless user interaction.";


  // Contact Information
  static const String email = "vishalvav55@gmail.com";
  static const String phone = "+91 9980655374";
  static const String linkedin = "www.linkedin.com/in/vishal-a-v-b9537b1a4";
  static const String github = "https://github.com/imBOTSir";
  
  // Education
  static const String education = "Bachelor of Engineering in Computer Science, 2022";
  
  // Work Experience
  static const String workExperience = "Software Engineer at Coffeeweb Technologies Pvt Ltd (Jan 2023 - Present)";
  
  // Skills
  static const List<Map<String, dynamic>> skills = [
    {
      'name': 'Flutter & Dart',
      'level': 0.9,
      'description': 'Expert in Flutter framework and Dart programming language'
    },
    {
      'name': 'State Management',
      'level': 0.85,
      'description': 'Proficient in GetX, setState, and other state management solutions'
    },
    {
      'name': 'UI/UX Implementation',
      'level': 0.8,
      'description': 'Skilled in translating designs into pixel-perfect interfaces'
    },
    {
      'name': 'API Integration',
      'level': 0.85,
      'description': 'Experience with RESTful APIs, GraphQL, and WebSockets'
    },
    {
      'name': 'Firebase',
      'level': 0.75,
      'description': 'Proficient with Firebase Authentication, Firestore, and Cloud Functions'
    },
    {
      'name': 'Supabase',
      'level': 0.7,
      'description': 'Experience with Supabase for backend services'
    },
    {
      'name': 'Animations',
      'level': 0.8,
      'description': 'Creating smooth, engaging animations and transitions'
    },
    {
      'name': 'Version Control',
      'level': 0.85,
      'description': 'Git workflow, branching strategies, and collaboration'
    },
    {
      'name': 'Flutter Web',
      'level': 0.75,
      'description': 'Developing responsive web applications with Flutter'
    },
  ];
  
  // Portfolio Projects
  static const List<Map<String, dynamic>> projects = [
    {
      'name': 'Coffeeweb App',
      'description': 'A comprehensive mobile application built with Flutter for both Android and iOS platforms. '
          'The app features a modern UI, real-time data synchronization, and seamless user experience.',
      'role': 'Lead Flutter Developer',
      'technologies': ['Flutter', 'Dart', 'GetX', 'Firebase', 'RESTFUL APIs'],
      'image': 'assets/images/coffeeweb_app.png'
    }
  ];
  
  // Services
  static const List<Map<String, dynamic>> services = [
    {
      'title': 'Cross-Platform App Development',
      'description': 'Building high-quality applications that run seamlessly on Android, iOS, and web from a single codebase.',
      'icon': Icons.devices
    },
    {
      'title': 'Custom Widget Development',
      'description': 'Creating reusable, efficient custom widgets tailored to specific project requirements.',
      'icon': Icons.widgets
    },
    {
      'title': 'App Architecture Design',
      'description': 'Designing modular, maintainable app architectures that scale with project growth.',
      'icon': Icons.architecture
    },
    {
      'title': 'Performance Optimization',
      'description': 'Enhancing app performance through code optimization and efficient resource management.',
      'icon': Icons.speed
    },
    {
      'title': 'API Integration',
      'description': 'Seamlessly connecting apps with backend services through RESTful APIs and other protocols.',
      'icon': Icons.api
    },
    {
      'title': 'Authentication Systems',
      'description': 'Implementing secure, user-friendly authentication and authorization solutions.',
      'icon': Icons.security
    }
  ];
}
