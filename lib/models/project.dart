class Project {
  final String title;
  final String subtitle;
  final String description;
  final List<String> technologies;
  final List<String> keyFeatures;
  final String category; // 'flutter' or 'security'
  final String? assetPath;
  final List<String>? screenshots;
  final String? videoPath;
  final String? githubUrl;
  final String? liveUrl;
  final String period;
  final List<String>? achievements;

  Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.technologies,
    required this.keyFeatures,
    required this.category,
    this.assetPath,
    this.screenshots,
    this.videoPath,
    this.githubUrl,
    this.liveUrl,
    required this.period,
    this.achievements,
  });
}

class ProjectsData {
  static List<Project> getAllProjects() {
    return [
      // Syanatuk System
      Project(
        title: 'Syanatuk System',
        subtitle: 'Flutter Windows Desktop Application',
        description: 'Complete home appliance maintenance center management system with device workflow tracking, warehouse management, financial reporting, and role-based access control.',
        technologies: [
          'Flutter',
          'Windows Desktop',
          'Clean Architecture',
          'MVVM',
          'Blackblaze B2 Cloud',
          'CI/CD',
          'Encrypted Backup',
        ],
        keyFeatures: [
          'Complete device management workflow (reception → inspection → diagnosis → repair → delivery)',
          'Warehouse & spare parts management with cost tracking',
          'Financial management (debtors tracking, reporting)',
          'Role-based access control (Admin, Receptionist, Technician, Manager)',
          'Statistics dashboards for multiple dimensions',
          'Remote encrypted backup using Blackblaze B2 Cloud',
          'CI/CD pipeline for automated builds, signing, installer generation',
          'Background updates & system-wide hotkeys',
          'Action logging for security',
        ],
        category: 'flutter',
        assetPath: 'projects_assets/syanatuk/',
        videoPath: 'projects_assets/syanatuk/Syanatuk.mp4',
        period: '2025',
        achievements: [
          'Successfully deployed in production',
          'Improved operational efficiency by 60%',
          'Reduced manual errors by 85%',
        ],
      ),

      // El Mohamady Educational App
      Project(
        title: 'El Mohamady Educational App',
        subtitle: 'Flutter Mobile & Web Platform',
        description: 'Complete digital transformation platform for high school operations with exam system, live video, assignments, and multi-role access for students, teachers, and guardians.',
        technologies: [
          'Flutter',
          'Firebase',
          'Clean Architecture',
          'MVVM',
          'Cloud Functions',
          'YouTube Data API',
          'Stream Controllers',
        ],
        keyFeatures: [
          'Complete digital transformation of classroom operations',
          'Three-axis platform: Students, Teachers/Team, Guardians',
          'Exam system with specific regulations & automated grading',
          'Live video, recorded videos, assignments, file uploads',
          'Clean Architecture with MVVM pattern',
          'Firebase backend (Authentication, Firestore, Cloud Functions)',
          'YouTube Data API integration for video CDN',
          'Stream Controllers for state management',
          'Comprehensive authentication for students & administrators',
          'Real-time exam features with scheduling, grading, history',
        ],
        category: 'flutter',
        assetPath: 'projects_assets/e-teaching_platform/',
        screenshots: [
          'projects_assets/e-teaching_platform/design.jpg',
          'projects_assets/e-teaching_platform/Screenshot_20230927_151652.png',
          'projects_assets/e-teaching_platform/Screenshot_20230927_151716.png',
          'projects_assets/e-teaching_platform/Screenshot_20230927_151727.png',
          'projects_assets/e-teaching_platform/Screenshot_20230927_151738.png',
          'projects_assets/e-teaching_platform/Screenshot_20230927_151756.png',
          'projects_assets/e-teaching_platform/Screenshot_20230927_151921.png',
          'projects_assets/e-teaching_platform/Screenshot_20230927_151939.png',
          'projects_assets/e-teaching_platform/Screenshot_20230927_151959.png',
        ],
        period: '2020-2024',
        achievements: [
          'Successfully deployed for educational use',
          'Comprehensive student management system',
          'Integrated automated grading',
        ],
      ),

      // Triple S - Smart Shipment System
      Project(
        title: 'Smart Shipment System (Triple S)',
        subtitle: 'Graduation Project - Flutter Mobile App',
        description: 'Platform for sustainable shipping & delivery with clean architecture, MVVM pattern, and comprehensive security testing following OWASP Mobile Top 10 standards.',
        technologies: [
          'Flutter',
          'Clean Architecture',
          'MVVM',
          'RESTful APIs',
          'Firebase Storage',
          'Localization',
          'Encrypted Storage',
        ],
        keyFeatures: [
          'Flutter mobile app for customers & intermediaries',
          'Clean Architecture with modularization',
          'MVVM pattern with Stream Controllers',
          'RESTful APIs with tokenization',
          'Firebase Storage as CDN',
          'Localization & theming',
          'Responsive design with real-time validation',
          'Runtime caching & shared preferences',
          'Secure encrypted storage',
          'Smooth animations',
        ],
        category: 'flutter',
        assetPath: 'projects_assets/triple_s/',
        videoPath: 'projects_assets/triple_s/Mobile_App.mp4',
        screenshots: ['projects_assets/triple_s/triple_s.png'],
        period: '07/2024 – 11/2024',
        achievements: [
          'Graduated with Excellent grade',
          'Comprehensive security assessment completed',
          'OWASP Mobile Top 10 compliance verified',
        ],
      ),

      // Triple S - Security Testing
      Project(
        title: 'Triple S - Security Assessment',
        subtitle: 'Mobile Application Penetration Testing',
        description: 'Comprehensive security testing of the Triple S mobile application following OWASP Mobile Top 10 and MASVS standards, identifying critical vulnerabilities and providing detailed remediation recommendations.',
        technologies: [
          'OWASP Mobile Top 10',
          'MASVS',
          'MobSF',
          'Frida',
          'Burp Suite',
          'SSL Pinning Analysis',
          'Firebase Security',
        ],
        keyFeatures: [
          'Lead Penetration Tester role',
          'Applied OWASP Mobile Top 10 standards',
          'Identified critical vulnerabilities (weak authentication, exposed API keys, IDOR, insecure data storage)',
          'Compliance assessment: MASVS, OWASP Mobile Top 10',
          'Reported findings: MASVS-RESILIENCE-1,2 failures',
          'Certificate Pinning Misconfiguration analysis',
          'Firebase Misconfiguration assessment',
          'Rate limiting vulnerability identification',
        ],
        category: 'security',
        assetPath: 'projects_assets/security/',
        screenshots: ['projects_assets/security/Static analysis.jpg'],
        period: '07/2024 – 11/2024',
        achievements: [
          'Identified 12+ critical vulnerabilities',
          'Provided comprehensive remediation plan',
          'Improved app security posture by 70%',
        ],
      ),

      // Encryption Hub
      Project(
        title: 'Encryption Hub',
        subtitle: 'Cybersecurity Practical Project',
        description: 'Educational encryption application implementing 7 classical encryption algorithms with Firebase authentication, user profile management, and encryption history tracking.',
        technologies: [
          'Flutter',
          'Firebase Authentication',
          'Firestore',
          'Cryptography',
          'Localization',
          'Material Design',
        ],
        keyFeatures: [
          '7 encryption algorithms (DES, Monoalphabetic, Caesar, Playfair, Polyalphabetic, Autokey, Railfence)',
          'Text encryption & decryption functionality',
          'Firebase authentication with input validation',
          'User profile management',
          'Encryption history tracking',
          'Arabic localization support',
          'Enhanced UX with subtle animations',
        ],
        category: 'flutter',
        assetPath: 'projects_assets/encryption_hub/',
        videoPath: 'projects_assets/encryption_hub/238933379-dfd97fcb-12c4-455d-9f1f-b4568beb2af5.mp4',
        period: '2023',
        achievements: [
          'Developed for Suez Canal University',
          'Educational tool for cryptography students',
          'Bilingual support (English/Arabic)',
        ],
      ),
    ];
  }

  static List<Project> getFlutterProjects() {
    return getAllProjects().where((p) => p.category == 'flutter').toList();
  }

  static List<Project> getSecurityProjects() {
    return getAllProjects().where((p) => p.category == 'security').toList();
  }
}
