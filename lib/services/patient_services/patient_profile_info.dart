class PatientProfileInfo {
  final String name ;
  final String id ;
  final String address ;

  final String age ;
  final String gender ;
  final String bp ;
  final String sugar ;
  final String hemo ;
  final List<dynamic> past_history ;

  final List<dynamic> drug_history ;
  final Map<dynamic,dynamic> medical_history ;

  PatientProfileInfo({this.name, this.id,this.address, this.age, this.gender, this.bp, this.sugar, this.hemo, this.past_history, this.drug_history, this.medical_history});



}