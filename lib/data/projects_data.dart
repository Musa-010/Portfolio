class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;

  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
  });
}

final List<Project> projects = [
  const Project(
    title: 'E-Commerce App',
    description: 'A full-featured e-commerce mobile application with product catalog, cart management, secure payments, and order tracking. Built with clean architecture and BLoC pattern.',
    imageUrl: 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=800',
    technologies: ['Flutter', 'Dart', 'Firebase', 'Stripe', 'BLoC'],
    githubUrl: 'https://github.com/johndoe/ecommerce-app',
    liveUrl: 'https://play.google.com/store/apps/details?id=com.example',
  ),
  const Project(
    title: 'Fitness Tracker',
    description: 'A comprehensive fitness tracking app with workout plans, progress monitoring, calorie counter, and social features. Integrates with health APIs for accurate data.',
    imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=800',
    technologies: ['Flutter', 'Dart', 'Node.js', 'MongoDB', 'REST API'],
    githubUrl: 'https://github.com/johndoe/fitness-tracker',
  ),
  const Project(
    title: 'Chat Application',
    description: 'Real-time messaging app with end-to-end encryption, group chats, media sharing, and push notifications. Features a beautiful Material Design 3 UI.',
    imageUrl: 'https://images.unsplash.com/photo-1611746872915-64382b5c76da?w=800',
    technologies: ['Flutter', 'Firebase', 'Firestore', 'FCM', 'Provider'],
    githubUrl: 'https://github.com/johndoe/chat-app',
  ),
  const Project(
    title: 'Weather App',
    description: 'Beautiful weather application with accurate forecasts, location-based weather, animated backgrounds, and detailed weather metrics.',
    imageUrl: 'https://images.unsplash.com/photo-1592210454359-9043f067919b?w=800',
    technologies: ['Flutter', 'Dart', 'REST API', 'Riverpod', 'Lottie'],
    githubUrl: 'https://github.com/johndoe/weather-app',
    liveUrl: 'https://weather-app-demo.web.app',
  ),
  const Project(
    title: 'Task Manager',
    description: 'Productivity app for managing tasks and projects with kanban boards, reminders, team collaboration, and cloud sync across devices.',
    imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=800',
    technologies: ['Flutter', 'Dart', 'SQLite', 'GetX', 'Hive'],
    githubUrl: 'https://github.com/johndoe/task-manager',
  ),
  const Project(
    title: 'Food Delivery App',
    description: 'Complete food delivery solution with restaurant listings, menu management, real-time order tracking, and integrated payment gateway.',
    imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
    technologies: ['Flutter', 'Firebase', 'Google Maps', 'Razorpay', 'BLoC'],
    githubUrl: 'https://github.com/johndoe/food-delivery',
  ),
];
