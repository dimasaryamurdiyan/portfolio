# 📱 Flutter Portfolio - Dimas Arya Murdiyan

A modern, responsive portfolio application built with Flutter showcasing professional experience, skills, education, and achievements. This cross-platform application demonstrates clean architecture principles and modern Flutter development practices.

## 🚀 Features

- **Responsive Design**: Optimized for mobile, tablet, and desktop platforms
- **Dark/Light Theme**: Toggle between themes with persistent preferences
- **Interactive UI**: Smooth animations and modern Material Design components
- **Cross-Platform**: Runs on iOS, Android, Web, Windows, macOS, and Linux
- **Clean Architecture**: Well-structured codebase with separation of concerns
- **State Management**: Efficient state management using Riverpod

## 🛠️ Technical Stack

### **Frontend Framework**
- **Flutter 3.7.2+**: Google's UI toolkit for building natively compiled applications
- **Dart**: Programming language optimized for building mobile, desktop, server, and web applications

### **Architecture & Design Patterns**
- **Clean Architecture**: Domain-driven design with clear separation of layers
- **MVVM Pattern**: Model-View-ViewModel architecture for better code organization
- **Provider Pattern**: State management using Flutter Riverpod

### **State Management**
- **Flutter Riverpod 2.4.9**: Reactive state management solution for Flutter

### **Storage & Persistence**
- **SharedPreferences 2.2.2**: Local storage for user preferences (theme settings)

### **External Integration**
- **URL Launcher 6.1.10**: Launch URLs, email clients, and make phone calls

### **Development Tools**
- **Flutter Lints 5.0.0**: Recommended lints for Flutter projects
- **Material Design**: Google's design system for modern UI components

## 📁 Project Structure

```
lib/
├── main.dart                    # Application entry point
├── data/
│   ├── portfolio_data.dart      # Static portfolio data and content
│   └── repositories/            # Data access layer
├── domain/
│   ├── repositories/            # Repository interfaces
│   └── usecases/               # Business logic
├── presentation/
│   ├── home_page.dart          # Main portfolio page
│   └── providers/              # Riverpod providers
│       └── theme_provider.dart # Theme state management
└── widgets/
    ├── certificate_card.dart   # Certificate display component
    ├── education_card.dart     # Education information component
    ├── experience_card.dart    # Work experience component
    ├── section_header.dart     # Section title component
    └── skill_chip.dart         # Skill tag component
```

## 🎨 Design Features

- **Material Design 3**: Modern, accessible design system
- **Responsive Layout**: Adapts to different screen sizes and orientations
- **Theme Support**: 
  - Light theme with blue primary colors and clean backgrounds
  - Dark theme with blue-grey palette for comfortable viewing
- **Custom Typography**: Inter font family for better readability
- **Elevated Cards**: Consistent card design with rounded corners and shadows

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.7.2 or higher
- Dart SDK (included with Flutter)
- IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Build for Production

**Web**
```bash
flutter build web
```

**Android**
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

**Desktop**
```bash
flutter build macos --release  # macOS
flutter build windows --release  # Windows
flutter build linux --release    # Linux
```

## 📱 Supported Platforms

- ✅ iOS
- ✅ Android  
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔧 Configuration

The application uses static data defined in `lib/data/portfolio_data.dart`. To customize the portfolio content:

1. Update personal information (name, contact details)
2. Modify professional experience entries
3. Add or remove skills and technologies
4. Update education information
5. Add certificates and achievements

## 📄 License

This project is a personal portfolio application. All rights reserved.

## 👨‍💻 About the Developer

**Dimas Arya Murdiyan**  
Android Engineer | Jakarta, Indonesia

- 📧 Email: dimasaryamurdiyan123@gmail.com
- 🔗 LinkedIn: [linkedin.com/in/dimasaryamurdiyan](https://linkedin.com/in/dimasaryamurdiyan)
- 🐙 GitHub: [github.com/dimasaryamurdiyan](https://github.com/dimasaryamurdiyan)

---

*Built with ❤️ using Flutter*
