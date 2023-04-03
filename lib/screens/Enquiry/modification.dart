import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:supplierportal/screens/Enquiry/submitQuotation.dart';
import 'package:supplierportal/styles/Responsive.dart';
import 'package:supplierportal/widgets/divider.dart';
import '../../styles/CommonTextStyle.dart';
import '../../styles/common Color.dart';

class ModificationScreen extends StatefulWidget {
  String? materialName, uom, make, model, requiredQty;
  ModificationScreen(
      {Key? key,
      this.materialName,
      this.uom,
      this.make,
      this.model,
      this.requiredQty})
      : super(key: key);

  @override
  State<ModificationScreen> createState() => _ModificationScreenState();
}

class _ModificationScreenState extends State<ModificationScreen> {
  bool notAvailable = false;
  String taxLabel = 'None';
  double? tax = 0;
  late int rateUnit, amount = 0, taxValue = 0, totalAmt = 0;
  final TextEditingController requiredDateController = TextEditingController();

  void saveAnGoBack() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            ctx: context,
            inheritTheme: true,
            type: PageTransitionType.rightToLeftWithFade,
            child: SubmitQuotationEnquiry(selectedItem: 0)));
  }

  void sumFunc() {
    int amt = rateUnit * 100;
    var sum1 = (amt / 100) * tax!;
    setState(() {
      amount = amt;
      taxValue = sum1.toInt();
    });
    var sum2 = amount + taxValue;
    setState(() {
      totalAmt = sum2;
    });
  }

  Future<void> datePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: secondaryColor,
              onPrimary: buttonForeground,
              onSurface: secondaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: secondaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    String date = DateFormat('dd-MM-yyyy').format(pickedDate!);

    requiredDateController.setText(date);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: mobile(), desktop: web());
  }

  Widget mobile() {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: secondaryColor,
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
          ),
          onPressed: () {
            // Navigator.of(context).pop();
            saveAnGoBack();
          },
          icon: const Icon(
            color: primaryColor,
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text('Modifications'),
      ),
      body: DraggableScrollableSheet(
        snap: true,
        minChildSize: 0.75,
        initialChildSize: 1,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) =>
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: DividerWidget(),
                      ),
                      materialTextField(double.infinity),
                      uomTextField(double.infinity),
                      makeTextField(double.infinity),
                      modelTextField(double.infinity),
                      requiredQuantityTextField(double.infinity),
                      requiredDateTextField(double.infinity),
                      recUnitTextField(double.infinity),
                      amountTextField(double.infinity),
                      taxTextField(double.infinity),
                      taxAmountTextField(double.infinity),
                      totalAmountTextField(double.infinity),
                      const SizedBox(height: 20),
                    ]),
                  ),
                )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          saveAnGoBack();
        },
        label: const Text('Modify'),
      ),
    );
  }

  Widget web() {
    final mediaWidth = MediaQuery.of(context).size.width * 0.2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(
            color: secondaryColor,
            Icons.arrow_back,
          ),
          onPressed: () {
            saveAnGoBack();
          },
        ),
        title: const Text(
          'Modifications',
          style: TextStyle(
              color: secondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.2),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              materialTextField(mediaWidth),
              uomTextField(mediaWidth),
              makeTextField(mediaWidth),
              modelTextField(mediaWidth),
              requiredQuantityTextField(mediaWidth),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: VerticalDivider(
              width: 10,
              thickness: 0.4,
              indent: 20,
              endIndent: 20,
              color: Colors.grey.shade400,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    requiredDateTextField(mediaWidth),
                    recUnitTextField(mediaWidth),
                    amountTextField(mediaWidth),
                    taxTextField(mediaWidth),
                    taxAmountTextField(mediaWidth),
                    totalAmountTextField(mediaWidth),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Not Available',
                        style: textInputHeader,
                      ),
                      Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          value: notAvailable,
                          onChanged: (value) {
                            setState(() {
                              notAvailable = !notAvailable;
                            });
                          }),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(80, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: secondaryColor,
                        ),
                        onPressed: () {
                          saveAnGoBack();
                        },
                        child: const Text("Modify",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget materialTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Material Name',
                style: textInputHeader,
              )),
          SizedBox(
            width: val,
            child: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: disableField,
              child: Container(
                decoration: disableDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    '${widget.materialName}',
                    style: cardValue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget uomTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'UOM',
                style: textInputHeader,
              )),
          SizedBox(
            width: val,
            child: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: disableField,
              child: Container(
                decoration: disableDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    '${widget.uom}',
                    style: cardValue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget makeTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Make',
                style: textInputHeader,
              )),
          SizedBox(
            width: val,
            child: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: disableField,
              child: Container(
                decoration: disableDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    '${widget.make}',
                    style: cardValue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget modelTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Model',
                style: textInputHeader,
              )),
          SizedBox(
            width: val,
            child: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: disableField,
              child: Container(
                decoration: disableDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    '${widget.model}',
                    style: cardValue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget requiredDateTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Required Date', style: inputHeader),
          ),
          SizedBox(
            height: 32,
            width: val,
            child: TextFormField(
              onTap: () {
                datePicker();
              },
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return "Username should not be empty";
              //   } else {
              //     return null;
              //   }
              // },
              controller: requiredDateController,
              cursorColor: secondaryColor,
              decoration: inputDateBox('Enter Required Date'),
            ),
          ),
        ],
      ),
    );
  }

  Widget requiredQuantityTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Required Quantity',
                style: textInputHeader,
              )),
          SizedBox(
            width: val,
            child: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: disableField,
              child: Container(
                decoration: disableDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    '${widget.requiredQty}',
                    style: cardValue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget recUnitTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Rec.Rate/Unit', style: inputHeader),
          ),
          SizedBox(
            height: 32,
            width: val,
            child: TextFormField(
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return "Username should not be empty";
              //   } else {
              //     return null;
              //   }
              // },
              onChanged: (value) {
                taxValue = 0;
                totalAmt = 0;
                if (value.isEmpty) {
                  setState(() {
                    amount = 0;
                  });
                } else {
                  setState(() {
                    rateUnit = int.parse(value);
                  });
                  sumFunc();
                }
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              cursorColor: secondaryColor,
              decoration: inputBox('Enter Rec.Rate/Unit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget amountTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Amount',
                style: textInputHeader,
              )),
          SizedBox(
            width: val,
            child: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: disableField,
              child: Container(
                decoration: disableDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    amount.toString(),
                    style: cardValue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget taxTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Tax',
                style: textInputHeader,
              )),
          Container(
            decoration: disableDecoration,
            width: val,
            height: 32,
            child: PopupMenuButton(
              color: Colors.white,
              offset: const Offset(0, 32),
              constraints: BoxConstraints.expand(width: val, height: 130),
              shape: disableField,
              padding: const EdgeInsets.all(0.0),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                    height: 10,
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: const Text('None', style: cardBody),
                    onTap: () => {
                          setState(() => {
                                tax = 0,
                                taxLabel = 'None',
                              }),
                          sumFunc()
                        }),
                PopupMenuItem(
                    height: 10,
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: const Text('VAT 5%', style: cardBody),
                    onTap: () => {
                          setState(() => {
                                tax = 5,
                                taxLabel = 'VAT 5%',
                              }),
                          sumFunc()
                        }),
                PopupMenuItem(
                    height: 10,
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: const Text('VAT 10%', style: cardBody),
                    onTap: () => {
                          setState(() => {
                                tax = 10,
                                taxLabel = 'VAT 10%',
                              }),
                          sumFunc()
                        }),
                PopupMenuItem(
                    height: 10,
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: const Text('VAT 0%', style: cardBody),
                    onTap: () => {
                          setState(() => {
                                tax = 0,
                                taxLabel = 'VAT 0%',
                              }),
                          sumFunc()
                        }),
                PopupMenuItem(
                    height: 10,
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: const Text('GST @ 18%', style: cardBody),
                    onTap: () => {
                          setState(() => {
                                tax = 18,
                                taxLabel = 'GST @ 18%',
                              }),
                          sumFunc()
                        }),
                PopupMenuItem(
                    height: 10,
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Text('GST @ 12%', style: cardBody),
                    onTap: () => {
                          setState(() => {
                                tax = 12,
                                taxLabel = 'GST @ 12%',
                              }),
                          sumFunc()
                        }),
              ],
              child: TextButton(
                onPressed: null,
                child: SizedBox(
                    // color: Colors.grey.shade100,
                    width: val,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tax.toString(), style: cardValue),
                        const Icon(Icons.keyboard_arrow_down_rounded,
                            color: secondaryColor),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget taxAmountTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Tax Amount',
                style: textInputHeader,
              )),
          SizedBox(
            width: val,
            child: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: disableField,
              child: Container(
                decoration: disableDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    '${taxValue.toString()}.00',
                    style: cardValue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget totalAmountTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Total Amount',
                style: textInputHeader,
              )),
          SizedBox(
            width: val,
            child: Card(
              elevation: 0,
              color: Colors.grey.shade200,
              shape: disableField,
              child: Container(
                decoration: disableDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    '${totalAmt.toString()}.00',
                    style: cardValue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
