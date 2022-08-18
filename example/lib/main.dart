import 'package:flutter/material.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements PayUCheckoutProProtocol {
  late PayUCheckoutProFlutter _checkoutPro;

  @override
  void initState() {
    super.initState();
    _checkoutPro = PayUCheckoutProFlutter(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayU Checkout Pro'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text("Start Payment"),
            onPressed: () async {
              _checkoutPro.openCheckoutScreen(
                payUPaymentParams:
                    PayUParams.createPayUPaymentParams(), // REQUIRED
                payUCheckoutProConfig: PayUParams.createPayUConfigParams(),
              );
            },
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String content) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Text(content),
            ),
            actions: [okButton],
          );
        });
  }

  @override
  generateHash(Map response) {
    // Pass response param to your backend server
    // Backend will generate the hash which you need to pass to SDK
    // hashResponse: is the response which you get from your server
    Map hashResponse = {};
    _checkoutPro.hashGenerated(hash: hashResponse);
  }

  @override
  onPaymentSuccess(dynamic response) {
    showAlertDialog(context, "onPaymentSuccess", response.toString());
  }

  @override
  onPaymentFailure(dynamic response) {
    showAlertDialog(context, "onPaymentFailure", response.toString());
  }

  @override
  onPaymentCancel(Map? response) {
    showAlertDialog(context, "onPaymentCancel", response.toString());
  }

  @override
  onError(Map? response) {
    showAlertDialog(context, "onError", response.toString());
  }
}

class PayUTestCredentials {
  static const merchantKey = "<ADD YOUR MERCHANT KEY>";
  static const iosSurl = "<ADD YOUR iOS SURL>";
  static const iosFurl = "<ADD YOUR iOS FURL>";
  static const androidSurl = "<ADD YOUR ANDROID SURL>";
  static const androidFurl = "<ADD YOUR ANDROID FURL>";

  static const merchantAccessKey = "<ADD YOUR MERCHNAT ACCESS KEY>"; // Optional
  static const sodexoSourceId = "<ADD YOUR SODEXO SOURCE ID>"; // Optional
}

//Pass these values from your app to SDK, this data is only for test purpose
class PayUParams {
  static Map createPayUPaymentParams() {
    var siParams = {
      PayUSIParamsKeys.isFreeTrial: true,
      PayUSIParamsKeys.billingAmount: '1', //REQUIRED
      PayUSIParamsKeys.billingInterval: 1, //REQUIRED
      PayUSIParamsKeys.paymentStartDate: '2023-04-20', //REQUIRED
      PayUSIParamsKeys.paymentEndDate: '2023-04-30', //REQUIRED
      PayUSIParamsKeys.billingCycle:
          'daily', //REQUIRED //Can be any of 'daily','weekly','yearly','adhoc','once','monthly'
      PayUSIParamsKeys.remarks: 'Test SI transaction',
      PayUSIParamsKeys.billingCurrency: 'INR',
      PayUSIParamsKeys.billingLimit: 'ON', //ON, BEFORE, AFTER
      PayUSIParamsKeys.billingRule: 'MAX', //MAX, EXACT
    };

    var additionalParam = {
      PayUAdditionalParamKeys.udf1: "udf1",
      PayUAdditionalParamKeys.udf2: "udf2",
      PayUAdditionalParamKeys.udf3: "udf3",
      PayUAdditionalParamKeys.udf4: "udf4",
      PayUAdditionalParamKeys.udf5: "udf5",
      PayUAdditionalParamKeys.merchantAccessKey:
          PayUTestCredentials.merchantAccessKey,
      PayUAdditionalParamKeys.sourceId: PayUTestCredentials.sodexoSourceId,
    };

    var spitPaymentDetails = [
      {
        "type": "absolute",
        "splitInfo": {
          "imAJ7I": {
            "aggregatorSubTxnId": "Testchild123",
            "aggregatorSubAmt": "5"
          },
          "qOoYIv": {
            "aggregatorSubTxnId": "Testchild098",
            "aggregatorSubAmt": "5"
          },
        }
      }
    ];

    var payUPaymentParams = {
      PayUPaymentParamKey.key: PayUTestCredentials.merchantKey, //REQUIRED
      PayUPaymentParamKey.amount: "1", //REQUIRED
      PayUPaymentParamKey.productInfo: "Info", //REQUIRED
      PayUPaymentParamKey.firstName: "Abc", //REQUIRED
      PayUPaymentParamKey.email: "test@gmail.com", //REQUIRED
      PayUPaymentParamKey.phone: "9999999999", //REQUIRED
      PayUPaymentParamKey.ios_surl: PayUTestCredentials.iosSurl, //REQUIRED
      PayUPaymentParamKey.ios_furl: PayUTestCredentials.iosFurl, //REQUIRED
      PayUPaymentParamKey.android_surl:
          PayUTestCredentials.androidSurl, //REQUIRED
      PayUPaymentParamKey.android_furl:
          PayUTestCredentials.androidFurl, //REQUIRED
      PayUPaymentParamKey.environment: "0", //0 => Production 1 => Test
      PayUPaymentParamKey.userCredential:
          null, //Pass user credential to fetch saved cards => A:B - OPTIONAL
      PayUPaymentParamKey.transactionId: "<ADD TRANSACTION ID>", //REQUIRED
      PayUPaymentParamKey.additionalParam: additionalParam, // OPTIONAL
      PayUPaymentParamKey.enableNativeOTP: true, // OPTIONAL
      PayUPaymentParamKey.userToken:
          "<Pass a unique token to fetch offers>", // OPTIONAL
      PayUPaymentParamKey.payUSIParams: siParams, // OPTIONAL
      PayUPaymentParamKey.splitPaymentDetails: spitPaymentDetails, // OPTIONAL
    };

    return payUPaymentParams;
  }

  static Map createPayUConfigParams() {
    var paymentModesOrder = [
      {"Wallets": "PHONEPE"},
      {"UPI": "TEZ"},
      {"Wallets": ""},
      {"EMI": ""},
      {"NetBanking": ""},
    ];

    var cartDetails = [
      {"GST": "5%"},
      {"Delivery Date": "25 Dec"},
      {"Status": "In Progress"}
    ];
    var enforcePaymentList = [
      {"payment_type": "CARD", "enforce_ibiboCode": "UTIBENCC"},
    ];

    var customNotes = [
      {
        "custom_note": "Its Common custom note for testing purpose",
        "custom_note_category": [
          PayUPaymentTypeKeys.emi,
          PayUPaymentTypeKeys.card
        ]
      },
      {
        "custom_note": "Payment options custom note",
        "custom_note_category": null
      }
    ];

    var payUCheckoutProConfig = {
      PayUCheckoutProConfigKeys.primaryColor: "#4994EC",
      PayUCheckoutProConfigKeys.secondaryColor: "#FFFFFF",
      PayUCheckoutProConfigKeys.merchantName: "PayU",
      PayUCheckoutProConfigKeys.merchantLogo: "logo",
      PayUCheckoutProConfigKeys.showExitConfirmationOnCheckoutScreen: true,
      PayUCheckoutProConfigKeys.showExitConfirmationOnPaymentScreen: true,
      PayUCheckoutProConfigKeys.cartDetails: cartDetails,
      PayUCheckoutProConfigKeys.paymentModesOrder: paymentModesOrder,
      PayUCheckoutProConfigKeys.merchantResponseTimeout: 30000,
      PayUCheckoutProConfigKeys.customNotes: customNotes,
      PayUCheckoutProConfigKeys.autoSelectOtp: true,
      // PayUCheckoutProConfigKeys.enforcePaymentList: enforcePaymentList,
      PayUCheckoutProConfigKeys.waitingTime: 30000,
      PayUCheckoutProConfigKeys.autoApprove: true,
      PayUCheckoutProConfigKeys.merchantSMSPermission: true,
      PayUCheckoutProConfigKeys.showCbToolbar: true,
    };
    return payUCheckoutProConfig;
  }
}
