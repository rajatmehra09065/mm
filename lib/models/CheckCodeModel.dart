class CheckCodeModel {
  MetaData? metaData;
  List<Data>? data;
  List<Code>? code;

  CheckCodeModel({this.metaData, this.data, this.code});

  CheckCodeModel.fromJson(Map<String, dynamic> json) {
    metaData = json['meta_data'] != null
        ? new MetaData.fromJson(json['meta_data'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['code'] != null) {
      code = <Code>[];
      json['code'].forEach((v) {
        code!.add(new Code.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.code != null) {
      data['code'] = this.code!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetaData {
  String? status;
  int? code;
  String? userMessage;
  String? developerMessage;

  MetaData({this.status, this.code, this.userMessage, this.developerMessage});

  MetaData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    userMessage = json['user_message'];
    developerMessage = json['developer_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['user_message'] = this.userMessage;
    data['developer_message'] = this.developerMessage;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? discription;
  String? picture;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.discription,
        this.picture,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    discription = json['discription'];
    picture = json['picture'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['discription'] = this.discription;
    data['picture'] = this.picture;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Code {
  int? id;
  String? code;
  int? status;
  Null? createdAt;
  Null? updatedAt;

  Code({this.id, this.code, this.status, this.createdAt, this.updatedAt});

  Code.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
