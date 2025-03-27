import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/custom_textfield.dart';
import 'package:flutter_amazon/constants/global_variables.dart';
import 'package:flutter_amazon/constants/utils.dart';
import 'package:flutter_amazon/features/address/services/address_services.dart';
import 'package:flutter_amazon/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";

  PaymentConfiguration? _gpayConfig;
  final String _paymentConfigurationAsset = 'gpay.json';

  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    _loadGPayConfig();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  Future<void> _loadGPayConfig() async {
    try {
      final config = await PaymentConfiguration.fromAsset(
        _paymentConfigurationAsset,
      );
      setState(() {
        _gpayConfig = config;
      });
    } catch (e) {
      print('Error loading Google Pay config: $e');
    }
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void onGooglePayResult(Map<String, dynamic> paymentResult) {
    if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm =
        flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(address, style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('OR', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextfield(
                      controller: flatBuildingController,
                      hintText: "Flat/House number, Building",
                    ),
                    const SizedBox(height: 14),
                    CustomTextfield(
                      controller: areaController,
                      hintText: "Area, Street",
                    ),
                    const SizedBox(height: 14),
                    CustomTextfield(
                      controller: pincodeController,
                      hintText: "Pincode",
                    ),
                    const SizedBox(height: 14),
                    CustomTextfield(
                      controller: cityController,
                      hintText: "Town/City",
                    ),
                    const SizedBox(height: 20),
                    _gpayConfig == null
                        ? const CircularProgressIndicator()
                        : GooglePayButton(
                          onPressed: () => payPressed(address),
                          paymentConfiguration: _gpayConfig!,
                          paymentItems: paymentItems,
                          height: 50,
                          type: GooglePayButtonType.pay,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: onGooglePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
