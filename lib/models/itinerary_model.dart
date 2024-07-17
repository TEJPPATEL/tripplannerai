class IResponse {
  final Map<String,dynamic> res;
  IResponse({required this.res});

  factory IResponse.formJson(Map<String,dynamic> res) {
    return IResponse(res:res);
  }
}


class ItineraryResult {
  late final String title;
  late final String image;
  late final List<Plans> plans;

  ItineraryResult({
    required this.title,
    required this.image,
    required this.plans,
  });

  factory ItineraryResult.fromJson(Map<String, dynamic> json) {
    final plans =
        List.from(json['plans']).map((e) => Plans.fromJson(e)).toList();
    return ItineraryResult(
        title: json['title'], image: json['image'], plans: plans);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['plans'] = plans.map((e) => e.toJson()).toList();
    return data;
  }
}

class Plans {
  Plans({
    required this.day,
    required this.description,
    required this.activities,
  });
  late final String day;
  late final String description;
  late final List<Activities> activities;

  factory Plans.fromJson(Map<String, dynamic> json) {
  
    final activities = List.from(json['activities'])
        .map((e) => Activities.fromJson(e))
        .toList();
    return Plans(day: json['day'], description: json['description'], activities: activities);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['description'] = description;
    data['activities'] = activities.map((e) => e.toJson()).toList();
    return data;
  }
}

class Activities {
  Activities({
    required this.slot,
    required this.slotDescription,
  });
  late final String slot;
  late final List<String> slotDescription;

  factory Activities.fromJson(Map<String, dynamic> json) {
    final slotDescription = List.castFrom<dynamic, String>(json['slotDescription']);
    return Activities(slot: json['slot'],slotDescription: slotDescription);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['slot'] = slot;
    data['slotDescription'] = slotDescription;
    return data;
  }
}
