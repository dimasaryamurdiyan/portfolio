class PortfolioData {
  static const String name = "Jay Jhaveri";
  static const String title = "Senior Software Engineer | AI Integration Specialist";
  static const String location = "Remote";
  static const String email = "jay@jhaveri.dev";
  static const String phone = "+1-555-0123";
  static const String githubUrl = "https://github.com/jayjhaveri";
  static const String linkedinUrl = "https://linkedin.com/in/jayjhaveri"; 

  static const String heroDescription = 
      "I engineer intelligent systems that automate workflows, power user experiences, and leverage AI innovation.";

  static const String aboutMe =
      "A Senior Software Engineer with 8+ years of experience blending mobile development expertise with cutting-edge AI technologies. I specialize in building intelligent, production-ready applications using Flutter, Firebase Cloud Functions, and Generative AI models like OpenAI and Anthropic. Focused on turning ideas into scalable products, automating workflows, and delivering seamless user experiences.";

  static final List<Map<String, String>> projects = [
    {
      "title": "TiramAI - From Concept to Creation",
      "description": "Built TiramAI, an AI-driven mobile code generation and self-healing engine. It generates full Flutter apps from user text or voice prompts — and continuously evolves them. Users can report issues or suggest improvements directly from the app. TiramAI analyzes feedback, regenerates affected screens, and automatically updates the apps to Play Store and App Store — accelerating traditional development cycles by 10x. 20+ production-ready apps generated and shipped in beta using this system.",
      "tech": "Flutter, Firebase, OpenAI, AI/ML",
      "featured": true,
      "url": "https://play.google.com/store/apps/developer?id=TiramAI",
      "status": "View Beta Apps on Play Store"
    },
    {
      "title": "CareAlert – Wellness Monitoring App",
      "description": "Migrated the CareAlert mobile app to Flutter, improving scalability, stability, and maintenance efficiency.",
      "tech": "Flutter, Mobile Development",
      "featured": false,
      "status": "View Project"
    },
    {
      "title": "Product Engineering Bridge",
      "description": "Built an MVP tool for better PM-engineering collaboration. Breaks down product ideas into features, clarifications, and tech stack.",
      "tech": "Product Management, Engineering",
      "featured": false,
      "status": "View Project"
    },
    {
      "title": "Stock Buddy - Indian Stock Advisor",
      "description": "Developed a conversational AI for Indian stock investors to check stock valuation metrics and offer beginner-friendly advice.",
      "tech": "AI, Finance, Flutter",
      "featured": false,
      "status": "View Project"
    },
    {
      "title": "The Eternal Journey - AI Comic",
      "description": "Created an AI-generated mythological comic series, blending storytelling and visual design through Generative AI models.",
      "tech": "AI, Creative Technology",
      "featured": false,
      "status": "View Project"
    },
    {
      "title": "IoT Smart Air Purifier App",
      "description": "Built a Bluetooth-enabled Flutter app to control smart air purifiers, improving product usability and control experience.",
      "tech": "IoT, Flutter, Bluetooth",
      "featured": false,
      "status": "Coming Soon"
    },
  ];

  static final List<Map<String, String>> techStack = [
    {
      "name": "Flutter",
      "icon": "🐦", // Will be replaced with actual icon
    },
    {
      "name": "Firebase", 
      "icon": "🔥",
    },
    {
      "name": "OpenAI",
      "icon": "🤖",
    },
    {
      "name": "TypeScript",
      "icon": "📘",
    },
    {
      "name": "Anthropic",
      "icon": "🧠",
    },
    {
      "name": "Flutter",
      "icon": "🐦",
    },
  ];

  static final Map<String, List<String>> skills = {
    "Core Technologies": ["Flutter", "Firebase", "TypeScript", "Dart"],
    "AI & ML": ["OpenAI", "Anthropic", "GPT Models", "AI Integration", "Machine Learning"],
    "Backend & Cloud": ["Firebase Functions", "Cloud Functions", "REST APIs", "Authentication"],
    "Mobile Development": ["iOS", "Android", "Cross-platform", "App Store", "Play Store"],
    "Development Tools": ["Git", "CI/CD", "Agile", "Product Management", "Code Generation"]
  };

  static const String contactTitle = "Let's Work Together";
  static const String contactDescription = 
      "I'm always excited to collaborate, innovate, and build meaningful solutions. Whether you have a project, a job opportunity, or just want to connect — let's talk!";
}