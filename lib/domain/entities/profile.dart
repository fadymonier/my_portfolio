import 'package:fady_portfolio/domain/entities/education.dart';
import 'package:fady_portfolio/domain/entities/experience.dart';
import 'package:fady_portfolio/domain/entities/project.dart';
import 'package:fady_portfolio/domain/entities/social_link.dart';

class Profile {
  const Profile({
    required this.name,
    required this.title,
    required this.location,
    required this.phone,
    required this.email,
    required this.summary,
    required this.socials,
    required this.skills,
    required this.experience,
    required this.education,
    required this.projects,
  });

  final String name;
  final String title;
  final String location;
  final String phone;
  final String email;
  final String summary;
  final List<SocialLink> socials;
  final List<String> skills;
  final List<Experience> experience;
  final List<Education> education;
  final List<Project> projects;
}
