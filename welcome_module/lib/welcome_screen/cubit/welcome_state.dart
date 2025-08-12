import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/welcome_item.dart';

class WelcomeState extends Equatable {
  final int currentIndex;
  final List<WelcomeItem> welcomeItems;

  const WelcomeState({
    this.currentIndex = 0,
    this.welcomeItems = const [
      WelcomeItem(
        title: "Smart Study Planning",
        description:
            "Create personalized study schedules that adapt to your learning pace and goals",
        icon: Icons.schedule,
        color: Color(0xFF6C63FF),
      ),
      WelcomeItem(
        title: "Track Your Progress",
        description:
            "Monitor your study sessions, achievements, and stay motivated with detailed analytics",
        icon: Icons.trending_up,
        color: Color(0xFF00D4AA),
      ),
      WelcomeItem(
        title: "Study Together",
        description:
            "Join study groups, collaborate with peers, and chat with friends seamlessly",
        icon: Icons.group,
        color: Color(0xFFFF6B6B),
      ),
    ],
  });

  WelcomeState copyWith({
    int? currentIndex,
    List<WelcomeItem>? welcomeItems,
  }) {
    return WelcomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      welcomeItems: welcomeItems ?? this.welcomeItems,
    );
  }

  @override
  List<Object> get props => [currentIndex, welcomeItems];
}
