class DateDis {
  String? id;
  String? livreurId;
  String? date;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  DateDis(
      {this.id,
      this.livreurId,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  DateDis.fromJson(Map<String, dynamic> json) {
   
    id = json['id']?? " ";
    livreurId = json['livreur_id'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['livreur_id'] = this.livreurId;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
