class PortfolioData {
  static const String name = "Dimas Arya Murdiyan";
  static const String codeName = "DM";
  static const String title = "Android Developer | Mobile Developer";
  static const String location = "Jakarta, Indonesia";
  static const String email = "dimasaryamurdiyan123@gmail.com";
  static const String phone = "+6289601389327";
  static const String githubUrl = "https://github.com/dimasaryamurdiyan";
  static const String linkedinUrl = "https://linkedin.com/in/dimasaryamurdiyan"; 

  static const String aboutMe =
      "Android Engineer with over 4 years of experience in developing, improving, and maintaining native Android applications. "
      "Proficient in a range of modern technologies including Kotlin, MVVM Architecture, Android Jetpack, Jetpack Compose, Hilt, Koin, RxJava, "
      "Coroutines, Room, CI/CD Fastlane, and Firebase. Proven ability to lead feature development, collaborate with cross-functional "
      "teams, and deliver scalable solutions. Passionate about mobile development and delivering high-quality applications.";

  static final List<Map<String, String>> professionalExperience = [
    {
      "company": "KipasKipas",
      "role": "Android Engineer",
      "dates": "Oct 2023 - Present",
      "location": "Jakarta, Indonesia",
      "description": "First social-commerce and crowdfunding application from Indonesia.",
      "responsibilities":
          "• Actively involved in Android application development, including bug fixing and maintenance.\n"
          "• Successfully integrated Huawei Push Service in the first week of joining the team.\n"
          "• Highly contribute to the live stream feature development.\n"
          "• Collaborated with local and international engineering teams.\n"
          "• Initiated and executed the implementation of feature flags, enhancing the app's agility and allowing for controlled feature rollouts and testing.\n"
          "• Achieved a 20% reduction in app size.\n"
          "• Set up Continuous Integration/Continuous Deployment (CI/CID) pipelines using Fastlane and collaborate with devops to set up Jenkins, reducing deployment time by 30%.",
      "tech_stacks": "Kotlin, Android Jetpack, MVVM, Koin, Coroutines, Modularization, Dependency Injection, CI/CD",
      "logo_path": "assets/kipaskipas.png",
      "card_color": "#FEE8E8",
    },
    {
      "company": "Freelance / Self-Employed",
      "role": "Android Engineer",
      "dates": "Jan 2023 - June 2023",
      "location": "Remote, Indonesia",
      "description": "Develop and maintain apps based on client needs.",
      "responsibilities": "• Develop and maintain apps based on client needs.",
      "tech_stacks": "Kotlin, Android Jetpack, MVP",
      "logo_path": "", // No logo for freelance work
      "card_color": "#E8F5E9",
    },
    {
      "company": "Binar Academy",
      "role": "Android Engineer",
      "dates": "Oct 2021 - Dec 2022",
      "location": "Remote, Indonesia",
      "description": "Access to the best quality education to upskilling digital talent in Indonesia. Focusing on bootcamp, network events, and digital courses.",
      "responsibilities":
          "• Develop, improve, and maintain native Android apps Binar Academy.\n"
          "• Handle bug fixing and performance monitoring.\n"
          "• Perform peer reviews, write unit tests and contribute ideas to improve the quality of the codebase.\n"
          "• Improve code coverage by 40% and achieve a 98% crash-free user rate.\n"
          "• Within a cross-functional team, collaborate with other engineers specializing in backend, web frontend, ios, and QA team, as well as product design, product managers and ideation with scrum and/or kanban.",
      "tech_stacks": "Kotlin, Android Jetpack, MVVM, RxJava, Hilt, Coroutines, Firebase, Dependency Injection, Mockito, EventBus",
      "logo_path": "assets/binar.webp",
      "card_color": "#E8FEE8",
    },
    {
      "company": "Widya Analytic",
      "role": "Android Engineer",
      "dates": "Nov 2020 - Oct 2021",
      "location": "Yogyakarta, Indonesia",
      "description": "Big data analytic startup that focusing on social media analysis to compare your competitors with instagram or twitter.",
      "responsibilities":
          "• Independently conceptualized and implemented Toba apps with a strong sense of code ownership..\n"
          "• Involved in developing an android app for tongue detection using flutter without supervision.",
      "tech_stacks": "Kotlin, Flutter, Android Jetpack, MVVM, Firebase",
      "logo_path": "assets/widya.png",
      "card_color": "#FFFEE8",
    },
    {
      "company": "Kios Rakyat",
      "role": "Android Engineer",
      "dates": "Feb 2020 - Aug 2020",
      "location": "Yogyakarta, Indonesia",
      "description": "An innovative platform enabling kiosk owners to efficiently manage their products and facilitate user orders.",
      "responsibilities":
          "• Single-handedly conceived, designed, and developed Kios Rakyat-Retail v1.0.\n"
          "• Seamlessly integrated a real-time chat feature leveraging Firebase technology, enhancing user engagement and satisfaction.",
      "tech_stacks": "Java, Firebase, MVVM",
      "logo_path": "assets/kiosrakyat.png",
      "card_color": "#F8EEFE",
    },
  ];

  static final Map<String, List<String>> skills = {
    "Languages": ["Kotlin", "Java", "Dart"],
    "Technologies": [
      "Android Jetpack",
      "MVVM",
      "Jetpack Compose",
      "Coroutines",
      "RxJava",
      "Hilt",
      "Koin",
      "Firebase",
      "Fastlane",
      "Jenkins",
      "Flutter",
      "Mockito",
      "EventBus",
      "Jira",
      "Room",
      "Figma",
      "Git"
    ],
    "Skills": [
      "Modularization",
      "Dependency Injection",
      "CI/CD",
      "Unit Testing",
      "Code Review",
      "A/B Testing",
      "Feature Flags",
      "Clean Arch"
    ],
  };

  static final List<Map<String, String>> education = [
    {
      "institution": "Binus University",
      "degree": "Bachelor's Degree in Computer Science",
      "gpa": "3.68/4.00",
      "dates": "May 2023 - Now",
    },
    {
      "institution": "Universitas Gadjah Mada",
      "degree": "Assoc. D. in Computer Science",
      "gpa": "3.75/4.00",
      "dates": "Aug 2017 - Aug 2020",
      "awards": "Finalist Pertamina Hackathon Energy 2.0 2019",
    },
  ];

  static final List<String> certificates = [
    "Dicoding Indonesia: Belajar Prinsip Pemrograman SOLID",
    "Dicoding Indonesia: Memulai Pemrograman dengan Kotlin",
    "Dicoding Indonesia: Belajar Android Jetpack Pro",
    "Dicoding Indonesia: Belajar Pemrograman Dart",
    "Dicoding Indonesia: Membuat Aplikasi Flutter untuk Pemula",
  ];
}