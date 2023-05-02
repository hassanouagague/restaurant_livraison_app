abstract class Path {
  static const String baseUrl = "https://repas-maison.com/MobileAppScript/";
  //static const String instCon = "https://repas-maison.com/MobileAppScript/getlivraisonbyLiv.php?type=instRouteLiv";
  static const String instCon ="$baseUrl$getLivraisons?type=instRouteLiv";
  static const String user = "user.php";
 // static const String kbisapi ="$baseUrl$user?type=updatelivreur";
  static const String getLivraisons = "getlivraisonbyLiv.php"; //getforLiv.php
  static const String getforLiv = "getforLiv.php";
  static const String confirmRefuseByLiv = "confirmRefuseByLiv.php";
  static const String register = "$baseUrl$user?type=registlivreur";
  static const String login = "$baseUrl$user?type=loginlivreur";
  static const String getpas = "${baseUrl}getpassword.php";


  static const String getUser = "$baseUrl$user?type=GetDatalivreur";

  static const String updatelivreur = "$baseUrl$user?type=updatelivreur";
  static const String pre = "$baseUrl$getLivraisons?type=pre";
  static const String inst = "$baseUrl$getLivraisons?type=inst";
  static const String livpreconfirm =
      "$baseUrl$getLivraisons?type=livpreconfirm";
  static const String reg = "$baseUrl$getforLiv?type=reglements";
  static const String pen = "$baseUrl$getforLiv?type=penalites";
  static const String confirme = "$baseUrl$confirmRefuseByLiv?type=confirmpre";
  static const String refuse =
      "$baseUrl$confirmRefuseByLiv?type=refusepre"; //getvilles.php
  static const String getVilles =
      "${baseUrl}getvilles.php"; //https://repas-maison.com/MobileAppScript/
  static const String getAllReclamation = "${baseUrl}reclamByliv.php";
  static const String getReponse =
      "${baseUrl}reclamReponse.php"; //statistiques.php
  static const String statistiques = "${baseUrl}statistiques.php";
  static const String getNot = "${baseUrl}getNotifications.php";
  static const String updateEtatNotif = "${baseUrl}updatenotification.php";//updatenotification.php
  static const String codeSuivi =
      "$baseUrl$confirmRefuseByLiv?type=codelivreur";

}
class Constants {
  //TODO: PLACE YOUR API-KEY
  static const String apiKey = "AIzaSyD_NGHN-TrneW_c_G7XeCdCojJsgFgh-Wg";
}
