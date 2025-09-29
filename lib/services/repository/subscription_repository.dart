import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/sub_model/sub_model.dart';
import 'package:el_mago/models/subscription_model/current_subscription_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';

class SubscriptionRepository {
  SubscriptionRepository._();
  static final SubscriptionRepository instance = SubscriptionRepository._();

  ApiServices apiServices = ApiServices.instance;

  Future<List<SubModelData>> getSubModels() async {
    List<SubModelData> subModelData = <SubModelData>[];
    try {
      var response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.getRetailerSubscription,
      );
      if (response != null) {
        if (response["data"] != null && response["data"] is List) {
          for (var item in response["data"]) {
            subModelData.add(SubModelData.fromJson(item));
          }
        }
      } else {
        AppPrint.appError("response data in null");
      }
    } catch (e) {
      AppPrint.appError(e, title: "getSubModels");
    }
    return subModelData;
  }

  Future<CurrentSubscriptionData?> getCurrentSubscription() async {
    try {
      var response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.getCurrentSubscription,
      );

      if (response != null && response['success'] == true) {
        if (response["data"] != null) {
          return CurrentSubscriptionData.fromJson(response["data"]);
        }
      } else {
        AppPrint.appLog("getCurrentSubscription response null or unsuccessful");
      }
    } catch (e) {
      AppPrint.appError(e, title: "getCurrentSubscription");
    }
    return null;
  }

  Future<bool> updateCardInfo({
    String? tier,
    String? subscription,
    String? freeShipping,
    String? noCreditCardFee,
    String? exclusiveProducts,
    String? limitedReleases,
    String? termsAndConditions,
    bool? termsAndConditionsAccepted,
    String? cardHolderName,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    String? zipCode,
  }) async {
    Map<String, dynamic> card = {
      "cardHolderName": cardHolderName,
      "cardNumber": cardNumber,
      "expiryDate": expiryDate,
      "cvv": cvv,
      "zipCode": zipCode,
    };

    Map<String, dynamic> body = {
      "tier": tier,
      "subscription": subscription,
      "freeShipping": freeShipping,
      "noCreditCardFee": noCreditCardFee,
      "exclusiveProducts": exclusiveProducts,
      "limitedReleases": limitedReleases,
      "termsAndConditions": termsAndConditions,
      "termsAndConditionsAccepted": termsAndConditionsAccepted,
      "card": card,
    };

    try {
      var response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.getRetailerSubscription,
        body: body,
      );
      if (response != null) {
        return true;
      } else {
        AppPrint.appError("UpdateCardInfo null");
        return false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "updateCardInfo");
    }
    return false;
  }
}
