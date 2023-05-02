class CheckError {
  bool? eteat;
  String? message;

  CheckError({this.eteat, this.message});

  CheckError.fromJson(Map<String, dynamic> json) {
    eteat = json['eteat'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['eteat'] = eteat;
    data['message'] = message;
    return data;
  }
}
