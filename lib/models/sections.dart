class Section {
  int? success;
  List<Data>? data;

  Section({this.success, this.data});

  Section.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sectionName;
  List<Days>? days;

  Data({this.sectionName, this.days});

  Data.fromJson(Map<String, dynamic> json) {
    sectionName = json['section_name'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(new Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_name'] = this.sectionName;
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  String? dayName;
  List<Classes>? classes;

  Days({this.dayName, this.classes});

  Days.fromJson(Map<String, dynamic> json) {
    dayName = json['day_name'];
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(new Classes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_name'] = this.dayName;
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classes {
  String? className;
  String? timePeriod;
  String? classType;
  String? moduleTeacher;

  Classes(
      {this.className, this.timePeriod, this.classType, this.moduleTeacher});

  Classes.fromJson(Map<String, dynamic> json) {
    className = json['class_name'];
    timePeriod = json['time_period'];
    classType = json['class_type'];
    moduleTeacher = json['module_teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_name'] = this.className;
    data['time_period'] = this.timePeriod;
    data['class_type'] = this.classType;
    data['module_teacher'] = this.moduleTeacher;
    return data;
  }
}

class FetchSection {
  static List<Section> section = [];
}
