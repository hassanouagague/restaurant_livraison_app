import 'package:food_livraison_app/model/reponse.dart';

class ReclamationModel {
  String? id;
  String? reclameur;
  String? idReclameur;
  String? titre;
  String? type;
  String? reclamation;
  String? etat;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Reponse>? reponse;
  ReclamationModel(
      {this.id,
      this.reclameur,
      this.idReclameur,
      this.titre,
      this.type,
      this.reclamation,
      this.etat,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.reponse
      });

  ReclamationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reclameur = json['reclameur'];
    idReclameur = json['id_reclameur'];
    titre = json['titre'];
    type = json['type'];
    reclamation = json['reclamation'];
    etat = json['etat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reclameur'] = reclameur;
    data['id_reclameur'] = idReclameur;
    data['titre'] = titre;
    data['type'] = type;
    data['reclamation'] = reclamation;
    data['etat'] = etat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
