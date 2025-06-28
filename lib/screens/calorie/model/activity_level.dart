enum ActivityLevel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
  superActive,
}

extension ActivityLevelExtension on ActivityLevel {
  double get factor {
    switch (this) {
      case ActivityLevel.sedentary:
        return 1.2;
      case ActivityLevel.lightlyActive:
        return 1.375;
      case ActivityLevel.moderatelyActive:
        return 1.55;
      case ActivityLevel.veryActive:
        return 1.725;
      case ActivityLevel.superActive:
        return 1.9;
    }
  }

  String get description {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Tôi ít vận động (ít hoặc không tập thể dục )';
      case ActivityLevel.lightlyActive:
        return 'Tôi vận động nhẹ ( tập thể dục nhẹ nhàng hoặc chơi thể theo 1-3 ngày một tuần)';
      case ActivityLevel.moderatelyActive:
        return 'Tội hoạt động vừa phải ( tập thể dục hoặc thể theo vừa phải 3-5 ngày mỗi tuần)';
      case ActivityLevel.veryActive:
        return 'Tôi rất năng động (chăm chỉ tập thể dục hoặc chơi thể thao 6-7 ngày một tuần)';
      case ActivityLevel.superActive:
        return 'Tôi cực kỳ năng động (tập thể dục hoặc thể thao rất chăm chỉ và một công việc thể chất hoặc tập luyện gấp đôi)';
    }
  }
}

extension ActivityLevelMessage on ActivityLevel {
  String get summary {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'Bạn là người không vận động; để duy trì cân nặng hiện tại, bạn cần khoảng';
      case ActivityLevel.lightlyActive:
        return 'Bạn vận động nhẹ (1–3 buổi/tuần); để duy trì cân nặng hiện tại, bạn cần khoảng';
      case ActivityLevel.moderatelyActive:
        return 'Bạn vận động vừa phải (3–5 buổi/tuần); bạn sẽ cần khoảng';
      case ActivityLevel.veryActive:
        return 'Bạn vận động tích cực (6–7 buổi/tuần); để duy trì cân nặng hiện tại, bạn cần';
      case ActivityLevel.superActive:
        return 'Bạn vận động cực kỳ tích cực (2 lần/ngày); bạn cần nạp vào khoảng';
    }
  }
}
