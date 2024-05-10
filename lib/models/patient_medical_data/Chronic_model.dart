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
    String d = jsonData['Date'];
    if (jsonData['Date'] == null) {
      d = "2001-07-12";
    }
    ;
    return ChronicDisease(
      name: jsonData['Name'],
      date: d,
      notes: jsonData['Notes'],
    );
  }
}

class ChronicDiseaseList {
  final List<ChronicDisease?> diseases;
  ChronicDiseaseList({required this.diseases});
  factory ChronicDiseaseList.fromJson(List<dynamic> jsonList) {
    List<ChronicDisease?> diseases = jsonList
        .map((jsonData) {
          String name = jsonData['Name'];
          String notes = jsonData['Notes'];
          // Check if name or notes is not an empty string
          if (name != "" || notes != "") {
            return ChronicDisease(
              name: name,
              date: "2001-07-12",
              notes: notes,
            );
          } else {
            return null; // Return null for empty data
          }
        })
        .where((disease) => disease != null)
        .toList(); // Convert Iterable to List and filter out null values
    return ChronicDiseaseList(diseases: diseases);
  }

  get length => diseases.length;
}

// class ChronicDiseaseList2 {
//   final List<ChronicDisease> diseases;
//   ChronicDiseaseList2({required this.diseases});
//   factory ChronicDiseaseList2.fromJson(List<dynamic> jsonList) {
//     List<ChronicDisease> diseases = jsonList.map((jsonData) {
//       return ChronicDisease(
//         name: jsonData['Name'],
//         date: "2001-07-12",
//         notes: jsonData['Notes'],
//       );
//     }).toList();
//     return ChronicDiseaseList2(diseases: diseases);
//   }
//   get length => diseases.length;
// }
