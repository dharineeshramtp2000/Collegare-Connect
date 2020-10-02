import 'package:company/screens/doctor_screens/patients_filtering.dart';
import 'package:company/services/company_services/doctor_info.dart';
import 'package:company/services/doctor_services/filtered_patients_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/services/patient_services/patient_profile_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DoctorFirebaseServices {
  final _firestore = FirebaseFirestore.instance;
  String name;
  String experience;
  String patient;
  String imageurl;
  Future<List<dynamic>> getDoctors({String specialization}) async {

    final result = await _firestore.collection('hosptial').doc(specialization).get();
    return result.get('doctors');
  }
  Future<DoctorInfo> displayDoctor({String doctorId,String specialization}) async{
    final result = await _firestore.collection('hosptial').doc(specialization).collection(doctorId).doc(doctorId).get();
    name = await result.get('name');
    experience = await result.get('experience');
    patient = await result.get('patient');
    imageurl = await result.get('image_url');

    DoctorInfo doctorInfo = DoctorInfo(doctorId,name, experience, patient,imageurl);
    return doctorInfo;
  }

  Future<List<FilteredPatientsDetails>> getFilteredPatients({Gender gender,int startBP,int endBP, int startAge,int endAge,int startSugar, int endSugar,int startHemo,int endHemo,int startEso,int endEso,String special,String tag}) async {
    String selectedGender;
    if (gender == Gender.Male) {
      selectedGender = 'male';
    } else if (gender == Gender.Female) {
      selectedGender = 'female';
    }
    else {
      selectedGender = 'both';
    }
    List<FilteredPatientsDetails> patientsList = [];
    try {
      final result = await _firestore.collection('patient_details').get();
      for (var doc in result.docs) {
        String name = await doc.get('name').toString();
        String id = await doc.get('id').toString();
        String age = await doc.get('age').toString();
        String bp = await doc.get('blood_pressure').toString();
        String sugar = await doc.get('sugar_level').toString();
        String hemo = await doc.get('hemoglobin_level').toString();
        String eso = await doc.get('eosinophils_count').toString();
        String realGender = await doc.get('gender').toString();
        List<dynamic> illness = await doc.get('illness');
        List<dynamic> specialization = await doc.get('specialization');
        print(illness);
        print(specialization);
        print(eso);
        print(hemo);
        print(name);
        print(sugar);

        if (selectedGender == 'both') {
          print('1');
          if (int.parse(age) < endAge && int.parse(age) > startAge) {
            print('2');

            if (int.parse(bp) < endBP && int.parse(bp) > startBP) {
              print('3');

              if (int.parse(sugar) < endSugar &&
                  int.parse(sugar) > startSugar) {
                print('4');

                if (int.parse(eso) < endEso && int.parse(eso) > startEso) {
                  print('5');

                  if (int.parse(hemo) < endHemo &&
                      int.parse(hemo) > startHemo) {
                    print('6');

                    if (specialization.contains(special)) {
                      print('7');

                      if (illness.contains(tag)) {
                        print('8');

                        print('Filter');
                        FilteredPatientsDetails details = FilteredPatientsDetails(
                            name: name, id: id);
                        patientsList.add(details);
                        return patientsList;
                        print('last 9');

                      }
                    }
                  }
                }
              }
            }
          }
        }
        else{
          if(selectedGender==realGender)
            {
              if (int.parse(age) < endAge && int.parse(age) > startAge) {
                print('2');

                if (int.parse(bp) < endBP && int.parse(bp) > startBP) {
                  print('3');

                  if (int.parse(sugar) < endSugar &&
                      int.parse(sugar) > startSugar) {
                    print('4');

                    if (int.parse(eso) < endEso && int.parse(eso) > startEso) {
                      print('5');

                      if (int.parse(hemo) < endHemo &&
                          int.parse(hemo) > startHemo) {
                        print('6');

                        if (specialization.contains(special)) {
                          print('7');

                          if (illness.contains(tag)) {
                            print('8');

                            print('Filter');
                            FilteredPatientsDetails details = FilteredPatientsDetails(
                                name: name, id: id);
                            patientsList.add(details);
                            return patientsList;
                            print('last 9');

                          }
                        }
                      }
                    }
                  }
                }
              }

            }
        }
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  Future<PatientProfileInfo> fetchProfile()async{
    final result = await _firestore.collection('hosptial').doc('patients')
        .collection('12345678').doc('12345678').get();
    String name = await result.get('name').toString();
    String id = await result.get('id').toString();
    String address = await result.get('address').toString();

    String age = await result.get('age').toString();
    String gender = await result.get('sex').toString();
    String bp = await result.get('bp').toString();
    String sugar = await result.get('sugar').toString();
    String hemo = await result.get('hemo').toString();
    List<dynamic> past_history = await result.get('past_history');

    List<dynamic> drug_history = await result.get('drug_history');
    Map<dynamic, dynamic> medical_history = await result.get(
        'medical_history');


    PatientProfileInfo info = PatientProfileInfo(name: name,id: id,address:address,age: age,gender: gender,bp: bp,sugar: sugar,hemo: hemo,past_history: past_history,drug_history: drug_history,medical_history: medical_history);

    return info;
}

}
