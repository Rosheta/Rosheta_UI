// Class representing a chronic disease
class ChronicDisease {
  final String name;
  final String date;
  final String notes;
  ChronicDisease({
    required this.name,
    required this.date,
    required this.notes,
  });
  factory ChronicDisease.fromJson(Map<String, dynamic> jsonData) {
    return ChronicDisease(
      name: jsonData['name'],
      date: jsonData['date'],
      notes: jsonData['notes'],
    );
  }
}

class ChronicDiseaseList {
  final List<ChronicDisease> diseases;
  ChronicDiseaseList({required this.diseases});
  factory ChronicDiseaseList.fromJson(List<dynamic> jsonList) {
    List<ChronicDisease> diseases = jsonList.map((jsonData) {
      return ChronicDisease(
        name: jsonData['name'],
        date: jsonData['date'],
        notes: jsonData['notes'],
      );
    }).toList();

    return ChronicDiseaseList(diseases: diseases);
  }
}
