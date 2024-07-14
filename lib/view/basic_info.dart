import 'package:books_system/backend/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../common_widget/constants.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final formkey4 = GlobalKey<FormState>();
  final formkey5 = GlobalKey<FormState>();
  final formkey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>[
    'USD',
    'INR',
    'EUR',
    'JPY',
    'GBP',
    'AED'
  ];
  String selectedCurrency = 'USD';

  bool hasPaid = false;

  Future<void> initPaymentSheet() async {
    try {
      final data = await createPaymentIntent(
        amount: (int.parse(amountController.text) * 100).toString(),
        currency: selectedCurrency,
        name: nameController.text,
        address: addressController.text,
        pin: pincodeController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            hasPaid
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Thanks for your participation",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade400),
                            child: const Text(
                              "Back to Events",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Share your Information",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formkey: formkey,
                                controller: amountController,
                                isNumber: true,
                                title: "Enter Amount",
                                hint: "Enter amount",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownMenu<String>(
                              inputDecorationTheme: InputDecorationTheme(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              initialSelection: currencyList.first,
                              onSelected: (String? value) {
                                setState(() {
                                  selectedCurrency = value!;
                                });
                              },
                              dropdownMenuEntries: currencyList
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextField(
                          formkey: formkey1,
                          title: "Name",
                          hint: "Ex. John Doe",
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextField(
                          formkey: formkey2,
                          title: "Address Line",
                          hint: "Ex. 123 Main St",
                          controller: addressController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: ReusableTextField(
                                  formkey: formkey3,
                                  title: "City",
                                  hint: "Ex. New Delhi",
                                  controller: cityController,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 5,
                                child: ReusableTextField(
                                  formkey: formkey4,
                                  title: "State (Short code)",
                                  hint: "Ex. DL for Delhi",
                                  controller: stateController,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: ReusableTextField(
                                  formkey: formkey5,
                                  title: "Country (Short Code)",
                                  hint: "Ex. IN for India",
                                  controller: countryController,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 5,
                                child: ReusableTextField(
                                  formkey: formkey6,
                                  title: "Pincode",
                                  hint: "Ex. 123456",
                                  controller: pincodeController,
                                  isNumber: true,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade400),
                            child: const Text(
                              "Proceed to Pay",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () async {
                              if (formkey.currentState!.validate() &&
                                  formkey1.currentState!.validate() &&
                                  formkey2.currentState!.validate() &&
                                  formkey3.currentState!.validate() &&
                                  formkey4.currentState!.validate() &&
                                  formkey5.currentState!.validate() &&
                                  formkey6.currentState!.validate()) {
                                await initPaymentSheet();

                                try {
                                  await Stripe.instance.presentPaymentSheet();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Payment Done",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  setState(() {
                                    hasPaid = true;
                                  });
                                  nameController.clear();
                                  addressController.clear();
                                  cityController.clear();
                                  stateController.clear();
                                  countryController.clear();
                                  pincodeController.clear();
                                } catch (e) {
                                  print("payment sheet failed");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Payment Failed",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
