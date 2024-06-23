class PointsRecord {
  int points;
  DateTime date;
  PointsRecord({required this.points, required this.date});


  factory PointsRecord.fromJson(Map<String, dynamic> json) {
    return PointsRecord(
      points: json['points'] as int,
      date: DateTime.parse(json['date'] as String)
      );
  }

  Map<String,dynamic> toJson(PointsRecord record){
    return {
      "points": record.points,
      "date": record.date.toString()
    };
  }
}