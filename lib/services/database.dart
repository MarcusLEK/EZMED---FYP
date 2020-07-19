import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmed/models/appointment.dart';
import 'package:ezmed/models/doctor.dart';
import 'package:ezmed/models/patient.dart';
import 'package:ezmed/models/precriptiondetails.dart';
import 'package:ezmed/models/queue.dart';
import 'package:ezmed/models/staff.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  var uuid = Uuid();

  // colection reference
  final CollectionReference patientCollection = Firestore.instance.collection('patients');
  final CollectionReference staffCollection = Firestore.instance.collection('staffs');
  final CollectionReference doctorCollection = Firestore.instance.collection('doctors');
  final CollectionReference prescriptionCollection = Firestore.instance.collection('prescription');
  final CollectionReference appointmentCollection = Firestore.instance.collection('appointment');
  final CollectionReference queueCollection = Firestore.instance.collection('queue');

  // Creates PATIENT collection if not exist
  // Creates patient doc in PATIENT collection
  Future updatePatientData(String id, String queueID, String name, String ic, String contact) async {
    return await patientCollection.document(uid).setData({
      'name': name,
      'ic': ic,
      'contact': contact,
      'queueID' : '',
      'docID' : id,
    });
  }

  // Creates STAFF collection if not exist
  // Creates staff doc in staff collection
  Future updateStaffData(String name, String contact) async {
    return await staffCollection.document(uid).setData({
      'name': name,
      'contact': contact
    });
  }

  // Creates STAFF collection if not exist
  // Creates staff doc in staff collection
  Future updateDoctorData(String name, String contact) async {
    return await doctorCollection.document(uid).setData({
      'name': name,
      'contact': contact
    });
  }

  // get doctor stream
  Stream<List<Doctor>> get doctors {
    return doctorCollection.snapshots()
    .map(_doctorListFromSnapshot);
  }

  // doctor list from snapshot
  List<Doctor> _doctorListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Doctor(
        name: doc.data['name'] ?? '',
        contact: doc.data['contact'] ?? ''
      );
    }).toList();
  }

  // get patient stream
  Stream<List<Patient>> get patients {
    return patientCollection.snapshots()
    .map(_patientListFromSnapshot);
  }

  // patient list from snapshot
  List<Patient> _patientListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Patient(
        name: doc.data['name'] ?? '',
        ic: doc.data['ic'] ?? '',
        contact: doc.data['contact'] ?? '',
        docID: doc.data['docID'] ?? '',
      );
    }).toList();
  }

  // get staff stream
  Stream<List<Staff>> get staffs {
    return staffCollection.snapshots()
    .map(_staffListFromSnapshot);
  }

  // staff list from snapshot
  List<Staff> _staffListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Staff(
        name: doc.data['name'] ?? '',
        contact: doc.data['contact'] ?? ''
      );
    }).toList();
  }

  Future<Patient> patientDetails(String uid) async {
    final result = await patientCollection.document(uid).get();
    return Patient(
      name: result.data['name'] ?? '',
      ic: result.data['ic'] ?? '',
      contact: result.data['contact'] ?? '',
      queueID: result.data['queueID'] ?? ''
    );
  }

  Future updatePatientDetails(String uid, String name, String contact) async {
    return await patientCollection.document(uid).updateData({
      'name': name,
      'contact': contact
    });
  }

  Future<Doctor> doctorDetails(String uid) async {
    final result = await doctorCollection.document(uid).get();
    return Doctor(
      name: result.data['name'] ?? '',
      contact: result.data['contact'] ?? ''
    );
  }

  Future updateDoctorDetails(String uid, String name, String contact) async {
    return await doctorCollection.document(uid).updateData({
      'name': name,
      'contact': contact
    });
  }

  Future createPrescription(int timeStamp, String prescribeid, String newdate, String docname, String patientid, String sickness, String meds, String notes, String name) async {
    String uid2 = uuid.v4();
    return await prescriptionCollection.document(uid2).setData({
      'timestamp' : timeStamp,
      'uuid' : uid2,
      'doctorName' : docname,
      'date' : newdate,
      'patientID' : patientid,
      'illness' : sickness,
      'medication' : meds,
      'important' : notes,
      'patientName' : name,
      'prescribeID' : prescribeid,
    });
  } 

  Stream<List<PrescriptionDetails>> get prescriptions {
    return prescriptionCollection.orderBy('timestamp', descending: true).snapshots()
    .map(_prescriptionListFromSnapshot);
  }

  // staff list from snapshot
  List<PrescriptionDetails> _prescriptionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PrescriptionDetails(
        uuid: doc.data['uuid'] ?? '',
        date: doc.data['date'] ?? '',
        ic: doc.data['patientID'] ?? '',
        illness: doc.data['illness'] ?? '',
        medication: doc.data['medication'] ?? '',
        important: doc.data['important'] ?? '',
        patientname: doc.data['patientName'] ?? '',
        doctorname: doc.data['doctorName'] ?? '',
      );
    }).toList();
  }

  Future deletePrescription(String id) {
    return prescriptionCollection.document(id).delete();
  }

  Future createAppointment(int timestamps, String uid, String newdate, String newtime, String newstatus, String newnote, String patientid, String patientname) async {
    String uid2 = uuid.v4();
    return await appointmentCollection.document(uid2).setData({
      'timestamp' : timestamps,
      'createdby' : uid,
      'uuid' : uid2,
      'date' : newdate,
      'time' : newtime,
      'status' : newstatus,
      'note' : newnote,
      'patientID' : patientid,
      'patientName' : patientname,
    });
  } 


  Stream<List<Appointment>> get appointments {
    return appointmentCollection.orderBy('timestamp', descending: true).snapshots()
    .map(_appointmentListFromSnapshot);
  }

  List<Appointment> _appointmentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Appointment(
        uuid: doc.data['uuid'] ?? '',
        ic: doc.data['patientID'] ?? '',
        date: doc.data['date'] ?? '',
        time: doc.data['time'] ?? '',
        note: doc.data['note'] ?? '',
        status: doc.data['status'] ?? '',
        createdby: doc.data['createdby'] ?? '',
        patientname: doc.data['patientName'] ?? '',
      );
    }).toList();
  }

  Future deleteAppointment(String id) {
    return appointmentCollection.document(id).delete();
  }

  Future<Staff> staffDetails(String uid) async {
    final result = await staffCollection.document(uid).get();
    return Staff(
      name: result.data['name'] ?? '',
      contact: result.data['contact'] ?? ''
    );
  }

  Future updateStaffDetails(String uid, String name, String contact) async {
    return await staffCollection.document(uid).updateData({
      'name': name,
      'contact': contact
    });
  }

  // get patient appointment(ONLY) streams
  Stream<List<Appointment>> patientappointment(String id) {
    return appointmentCollection.where('patientID', isEqualTo: id).orderBy('time', descending: false).snapshots()
    .map(_appointmentListFromSnapshot);
  }

  Stream<List<PrescriptionDetails>> patientprescriptions(String id) {
    return prescriptionCollection.where('patientID', isEqualTo: id).snapshots()
    .map(_prescriptionListFromSnapshot);
  }

  Future newQueue(String uid2, int time2, String patientid, String name) async {
    return await queueCollection.document(uid2).setData({
      'uuid' : uid2,
      'time' : time2,
      'patientID' : patientid,
      'patientName' : name,
    });
  }

  Stream<List<Queue>> get queues {
    return queueCollection.orderBy('time', descending: false).snapshots()
    .map(_queueListFromSnapshot);
  }

  List<Queue> _queueListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Queue(
        patientID: doc.data['patientID'] ?? '',
        patientName: doc.data['patientName'] ?? '',
        time: doc.data['time'] ?? '',
        uuid: doc.data['uuid'] ?? '',
      );
    }).toList();
  }

  Future deleteQueue(String id) {
    return queueCollection.document(id).delete();
  }

  Future setQueueID(String uid2, String ic) async {
    return await patientCollection.document(ic).updateData({
      'queueID' : uid2,
    });
  }

  Future deleteQueueID(String ic) async {
    return await patientCollection.document(ic).updateData({
      'queueID' : '',
    });
  }

  Future updateAppointment(String id, String timedata, String datedata, String notes) async {
    return await appointmentCollection.document(id).updateData({
      'date' : datedata,
      'time' : timedata,
      'note' : notes,
    });
  }

}