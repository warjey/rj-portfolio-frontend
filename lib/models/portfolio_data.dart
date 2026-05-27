class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String category;
  final String emoji;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.category,
    required this.emoji,
  });
}

class PortfolioData {
  static const String name = "RJ Salundaga";
  static const String tagline = "3rd Year BSIT Student · Web Developer";
  static const String bio =
      "I'm a 3rd year Bachelor of Science in Information Technology student who builds things that solve real problems. "
      "I turn ideas into working software and always shipping something new.";

  static const List<String> skills = [
    "Flutter", "Dart", "React.js", "HTML/CSS", "JavaScript",
    "Python", "C#", "Java", "MySQL", "Git", "MongoDB",
    "UI/UX Design", "REST APIs",
  ];

  static const List<Project> projects = [
    Project(
      title: "AXIOMA",
      description:
          "A cross-platform AI-powered research mapping and cloud integrated knowledge synthesis system for quantifying institutional research redundancy. My most ambitious project to date.",
      technologies: ["Flutter", "Python", "AI/ML", "Cloud", "Dart"],
      category: "AI / Research",
      emoji: "🧠",
    ),
    Project(
      title: "CalmLeaf",
      description:
          "An online wellness web app designed to support mental health and mindfulness. Clean UI focused on calm user experience.",
      technologies: ["React.js", "JavaScript", "CSS", "Node.js"],
      category: "Web App",
      emoji: "🌿",
    ),
    Project(
      title: "Hospital Queue Management",
      description:
          "A real-world queue management system for hospitals, reducing wait times and improving patient flow through digital ticketing.",
      technologies: ["Java", "MySQL", "Spring Boot"],
      category: "Healthcare",
      emoji: "🏥",
    ),
    Project(
      title: "Fast Food Management System",
      description:
          "A complete POS and order management system for fast food chains, handling orders, inventory, and reporting.",
      technologies: ["C#", "SQL Server", "WPF"],
      category: "Management System",
      emoji: "🍔",
    ),
    Project(
      title: "Mini Games Collection",
      description:
          "Built classic browser games including Tic-Tac-Toe and a Matching Card Game as fun projects to sharpen logic and UI skills.",
      technologies: ["JavaScript", "HTML", "CSS"],
      category: "Games",
      emoji: "🎮",
    ),
  ];

  static const List<Map<String, String>> achievements = [
    {
      "title": "7+ Competitions Joined",
      "desc": "Competed against top student developers in various level coding competitions.",
      "icon": "🏆",
    },
    {
      "title": "AXIOMA — Capstone Project",
      "desc": "My featured and developed AI-powered cross-platform research knowledge system.",
      "icon": "🚀",
    },
    {
      "title": "5+ Projects Shipped",
      "desc": "From healthcare to wellness apps, consistently delivering real-world solutions.",
      "icon": "💡",
    },
  ];
}
