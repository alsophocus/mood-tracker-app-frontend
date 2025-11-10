class MoodModel {
  final int? id;
  final int userId;
  final String date;
  final String mood;
  final int moodValue;
  final String notes;
  final String triggers;
  final MoodContext context;
  final String timestamp;
  final int hour;
  final List<String>? tags;

  MoodModel({
    this.id,
    required this.userId,
    required this.date,
    required this.mood,
    required this.moodValue,
    this.notes = '',
    this.triggers = '',
    required this.context,
    required this.timestamp,
    required this.hour,
    this.tags,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      mood: json['mood'],
      moodValue: json['mood_value'],
      notes: json['notes'] ?? '',
      triggers: json['triggers'] ?? '',
      context: MoodContext.fromJson(json['context'] ?? {}),
      timestamp: json['timestamp'],
      hour: json['hour'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'date': date,
      'mood': mood,
      'mood_value': moodValue,
      'notes': notes,
      'triggers': triggers,
      'context': context.toJson(),
      'timestamp': timestamp,
      'hour': hour,
      if (tags != null) 'tags': tags,
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'date': date,
      'mood': mood,
      'notes': notes,
      'triggers': triggers,
      'context': context.toJson(),
    };
  }
}

class MoodContext {
  final String location;
  final String activity;
  final String weather;
  final String notes;

  MoodContext({
    this.location = '',
    this.activity = '',
    this.weather = '',
    this.notes = '',
  });

  factory MoodContext.fromJson(Map<String, dynamic> json) {
    return MoodContext(
      location: json['location'] ?? '',
      activity: json['activity'] ?? '',
      weather: json['weather'] ?? '',
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'activity': activity,
      'weather': weather,
      'notes': notes,
    };
  }
}

// Mood types enum matching backend
enum MoodType {
  veryBad('very bad', 1),
  bad('bad', 2),
  slightlyBad('slightly bad', 3),
  neutral('neutral', 4),
  slightlyWell('slightly well', 5),
  well('well', 6),
  veryWell('very well', 7);

  final String value;
  final int numericValue;

  const MoodType(this.value, this.numericValue);

  static MoodType fromString(String value) {
    return MoodType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MoodType.neutral,
    );
  }
}
