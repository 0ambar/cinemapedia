import 'dart:convert';

PopulaPeopleResponse populaPeopleResponseFromJson(String str) => PopulaPeopleResponse.fromJson(json.decode(str));

String populaPeopleResponseToJson(PopulaPeopleResponse data) => json.encode(data.toJson());

class PopulaPeopleResponse {
    int page;
    List<Person> people;
    int totalPages;
    int totalResults;

    PopulaPeopleResponse({
        required this.page,
        required this.people,
        required this.totalPages,
        required this.totalResults,
    });

    factory PopulaPeopleResponse.fromJson(Map<String, dynamic> json) => PopulaPeopleResponse(
        page: json["page"],
        people: List<Person>.from(json["results"].map((x) => Person.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(people.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Person {
    bool adult;
    int id;
    String name;
    String originalName;
    double popularity;
    int gender;
    String knownForDepartment;
    String? profilePath;

    Person({
        required this.adult,
        required this.id,
        required this.name,
        required this.originalName,
        required this.popularity,
        required this.gender,
        required this.knownForDepartment,
        required this.profilePath,
    });

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        adult: json["adult"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        gender: json["gender"],
        knownForDepartment: json["known_for_department"] ?? '',
        profilePath: json["profile_path"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "id": id,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "gender": gender,
        "known_for_department": knownForDepartment,
        "profile_path": profilePath,
    };
}
