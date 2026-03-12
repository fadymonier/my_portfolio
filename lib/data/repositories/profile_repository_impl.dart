import 'package:fady_portfolio/domain/entities/education.dart';
import 'package:fady_portfolio/domain/entities/experience.dart';
import 'package:fady_portfolio/domain/entities/profile.dart';
import 'package:fady_portfolio/domain/entities/project.dart';
import 'package:fady_portfolio/domain/entities/social_link.dart';
import 'package:fady_portfolio/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl._();
  static final ProfileRepositoryImpl _instance = ProfileRepositoryImpl._();
  static ProfileRepository get profileRepository => _instance;

  static const _socials = [
    SocialLink(
      label: 'GitHub',
      url: 'https://github.com/fadymonier',
      icon: 'assets/icons/github.png',
    ),
    SocialLink(
      label: 'LinkedIn',
      url: 'https://www.linkedin.com/in/fadymonierfouad/',
      icon: 'assets/icons/linkedin.png',
    ),
    SocialLink(
      label: 'WhatsApp',
      url: 'https://wa.me/201200528999',
      icon: 'assets/icons/whatsapp.png',
    ),
    SocialLink(
      label: 'CV',
      url:
          'https://drive.google.com/file/d/1GQGpaOvKCSJ7F8Cm6cmfmeoBSPhoV0jC/view?usp=drive_link',
      icon: 'assets/icons/cv.png',
    ),
  ];

  static const _skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'REST APIs',
    'SQLite',
    'Hive',
    'Clean Architecture',
    'MVVM',
    'State Management (Provider, Bloc, GetX, Riverpod)',
    'Dependency Injection',
    'SOLID Principles',
    'Design Patterns',
    'CI/CD',
    'Git/GitHub',
    'Unit Testing',
    'Debugging',
    'Performance Optimization',
    'Responsive Design',
    'Localization',
    'Security',
    'Networking',
    'Problem Solving',
    'Adaptability',
    'Collaboration',
  ];

  static const _experience = [
    Experience(
      role: 'Application Support',
      company: 'MNT-Halan',
      type: 'Full-Time',
      place: 'Egypt',
      period: 'Oct 2025 – Present',
      bullets: [
        'Providing technical support for Halan mobile application',
        'Troubleshooting and resolving user issues',
      ],
    ),
    Experience(
      role: 'Flutter Developer',
      company: 'Bayan Digital',
      type: 'Full-Time',
      place: 'Mansura, Egypt',
      period: 'Jan 2025 – Oct 2025',
      bullets: [
        'Developing diverse Flutter apps for clients',
        'Full lifecycle: planning to deployment and support',
      ],
    ),
    Experience(
      role: 'Flutter Developer',
      company: 'Octopus Development',
      type: 'Part-Time',
      place: 'Remote',
      period: 'Jul 2024 – Jan 2025',
      bullets: [
        'Developed and maintained Flutter applications',
        'Implemented scalable state management',
      ],
    ),
    Experience(
      role: 'Flutter Developer',
      company: 'Freelance',
      type: 'Remote',
      place: 'Remote',
      period: 'Jan 2024 – Present',
      bullets: [
        'Firebase auth and realtime database',
        'RESTful APIs and third-party integrations',
      ],
    ),
  ];

  static const _education = [
    Education(
      title: 'B.Sc. Computers & Informatics',
      org: 'Zagazig University, Egypt',
      period: '2019 – 2023',
    ),
    Education(
      title: 'Flutter & Dart Advanced Course',
      org: 'Route Academy',
      period: 'Nov 2023 – May 2024',
    ),
  ];

  static const _projects = [
    Project(
      title: 'Darbonna',
      subtitle: 'Location-based taxi booking, real-time tracking',
      image: 'assets/images/darbonna.png',
      link: 'https://play.google.com/store/apps/details?id=com.Bayain.Darbonna',
    ),
    Project(
      title: 'Darbonna Driver',
      subtitle: 'Driver app for ride management',
      image: 'assets/images/darbonna_driver.png',
      link:
          'https://play.google.com/store/apps/details?id=com.Bayain.DriverDarbonna',
    ),
    Project(
      title: 'Estraha',
      subtitle: 'Hotel & stay booking',
      image: 'assets/images/estraha.png',
      link: 'https://play.google.com/store/apps/details?id=dev.vlab.bookingbox',
    ),
    Project(
      title: 'Last Soma',
      subtitle: 'Auctions & E-commerce',
      image: 'assets/images/last_soma.png',
      link: 'https://play.google.com/store/apps/details?id=com.bayain.lastsoma',
    ),
    Project(
      title: 'FitPulse',
      subtitle: 'Fitness app with dynamic ECG',
      image: 'assets/images/fitpulse.png',
      link: 'https://github.com/fadymonier/Fit-Pulse.git',
    ),
    Project(
      title: 'QR Reader',
      subtitle: 'Scan and store QR codes',
      image: 'assets/images/qr_reader.png',
      link: 'https://github.com/fadymonier/QR-Scanner.git',
    ),
    Project(
      title: 'Mandop',
      subtitle: 'Sales points monitoring',
      image: 'assets/images/mandop.png',
      link: 'https://github.com/fadymonier/Mandop.git',
    ),
    Project(
      title: 'Movies TMDB',
      subtitle: 'Movie browsing via TMDB API',
      image: 'assets/images/movies_tmdb.png',
      link: 'https://github.com/fadymonier/Movies_TMDB.git',
    ),
    Project(
      title: 'Souq',
      subtitle: 'Cross-platform E-commerce with cart & checkout',
      image: 'assets/images/souq.png',
      link: 'https://github.com/fadymonier/souq.git',
    ),
  ];

  @override
  Profile getProfile() {
    return const Profile(
      name: 'Fady Monier Fouad',
      title: 'Mobile App Developer | Flutter',
      location: 'Cairo, Egypt',
      phone: '+201200528999',
      email: 'fadymonier111@gmail.com',
      summary:
          'Flutter developer specialized in building cross-platform apps with Flutter, Dart, Firebase, and REST APIs. Experienced in scalable architectures, performance optimization, and delivering user-centric solutions with clean code practices.',
      socials: _socials,
      skills: _skills,
      experience: _experience,
      education: _education,
      projects: _projects,
    );
  }
}
