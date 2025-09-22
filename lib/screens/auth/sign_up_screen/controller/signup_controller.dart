import 'package:get/get.dart';

enum Role { SalesRep, Retailer }

class SignUpController extends GetxController {
  // Rxn allows the value to be null or a valid Role.
  final Rxn<Role> workedInChildCare = Rxn<Role>();

  // Setter function to set the value of workedInChildCare
  void setWorkedInChildCare(Role? value) {
    workedInChildCare.value = value;
  }
}
