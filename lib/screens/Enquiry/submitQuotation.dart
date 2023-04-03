import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:supplierportal/screens/Enquiry/modification.dart';
import 'package:supplierportal/styles/Responsive.dart';
import 'package:supplierportal/widgets/divider.dart';
import '../../styles/CommonTextStyle.dart';
import '../../styles/common Color.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;
import '../../widgets/mobileShimmer.dart';
import '../../widgets/shimmer.dart';

class SubmitQuotationEnquiry extends StatefulWidget {
  int selectedItem;
  SubmitQuotationEnquiry({Key? key, required this.selectedItem})
      : super(key: key);

  @override
  State<SubmitQuotationEnquiry> createState() => _SubmitQuotationEnquiryState();
}

class _SubmitQuotationEnquiryState extends State<SubmitQuotationEnquiry> {
  String? quotationDate, deliveryDate;
  final ScrollController listScrollController = ScrollController();
  final TextEditingController deliveryController = TextEditingController(),
      quotationController = TextEditingController();
  List data = [
    {
      'id': '1',
      'MaterialCode': '1130110103',
      'MateialName': '9W 840 S-DULUX Cool White',
      'Make': ' OSRAM',
      'Model': 'DE DULUX 26W/840',
      'UOM': 'BOX',
      'Qty': '100.0',
      'rate': '00.00',
      'amt': '00.00',
      'tax': '00.00',
      'taxAmount': '100.00',
      'totalAmount': '5000.00',
      'notAvailable': '---',
      'requiredDate': '--/--/--'
    },
    {
      'id': '2',
      'MaterialCode': '1130110103',
      'MateialName': '9W 840 S-DULUX Cool White',
      'Make': ' OSRAM',
      'Model': 'DE DULUX 26W/840',
      'UOM': 'BOX',
      'Qty': '100.0',
      'rate': '00.00',
      'amt': '00.00',
      'tax': '00.00',
      'taxAmount': '100.00',
      'totalAmount': '5000.00',
      'notAvailable': '---',
      'requiredDate': '--/--/--'
    },
    {
      'id': '3',
      'MaterialCode': '1130110103',
      'MateialName': '9W 840 S-DULUX Cool White',
      'Make': ' OSRAM',
      'Model': 'DE DULUX 26W/840',
      'UOM': 'BOX',
      'Qty': '100.0',
      'rate': '00.00',
      'amt': '00.00',
      'tax': '00.00',
      'taxAmount': '100.00',
      'totalAmount': '5000.00',
      'notAvailable': '---',
      'requiredDate': '--/--/--'
    },
    {
      'id': '4',
      'MaterialCode': '1130110103',
      'MateialName': '9W 840 S-DULUX Cool White',
      'Make': ' OSRAM',
      'Model': 'DE DULUX 26W/840',
      'UOM': 'BOX',
      'Qty': '100.0',
      'rate': '00.00',
      'amt': '00.00',
      'tax': '00.00',
      'taxAmount': '100.00',
      'totalAmount': '5000.00',
      'notAvailable': '---',
      'requiredDate': '--/--/--'
    },
    {
      'id': '5',
      'MaterialCode': '1130110103',
      'MateialName': '9W 840 S-DULUX Cool White',
      'Make': ' OSRAM',
      'Model': 'DE DULUX 26W/840',
      'UOM': 'BOX',
      'Qty': '100.0',
      'rate': '00.00',
      'amt': '00.00',
      'tax': '00.00',
      'taxAmount': '100.00',
      'totalAmount': '5000.00',
      'notAvailable': '---',
      'requiredDate': '--/--/--'
    },
    {
      'id': '6',
      'MaterialCode': '1130110103',
      'MateialName': '9W 840 S-DULUX Cool White',
      'Make': ' OSRAM',
      'Model': 'DE DULUX 26W/840',
      'UOM': 'BOX',
      'Qty': '100.0',
      'rate': '00.00',
      'amt': '00.00',
      'tax': '00.00',
      'taxAmount': '100.00',
      'totalAmount': '5000.00',
      'notAvailable': '---',
      'requiredDate': '--/--/--'
    },
  ];

  void modificationScreen(
      String val, String val1, String val2, String val3, String val4) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            ctx: context,
            inheritTheme: true,
            type: PageTransitionType.rightToLeftWithFade,
            child: ModificationScreen(
              materialName: val,
              uom: val1,
              make: val2,
              model: val3,
              requiredQty: val4,
            )));
  }

  Future<void> datePicker(String val) async {
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
    if (val == 'Delivery') {
      setState(() {
        deliveryDate = date;
        deliveryController.setText(deliveryDate!);
      });
      print('start,$deliveryDate');
    } else {
      setState(() {
        quotationDate = date;
        quotationController.setText(quotationDate!);
      });
      print('currentDate,$quotationDate');
    }
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
            Navigator.of(context).pop();
          },
          icon: const Icon(
            color: primaryColor,
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text('Submit Quotation Bill'),
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
                    controller: listScrollController,
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: DividerWidget(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          enquiryCode(100),
                          enquiryDate(100),
                          quotationCode(110),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const DividerWidget(),
                      refTextField(double.infinity),
                      deliveryTextField(double.infinity),
                      paymentTextField(double.infinity),
                      validityTextField(double.infinity),
                      quotationTextField(double.infinity),
                      remarkTextField(double.infinity),
                      grandTotalTextField(double.infinity),
                      taxTextField(double.infinity),
                      // const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: data.isEmpty
                            ? mobileShimmer(300)
                            : ListView.builder(
                                controller: listScrollController,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (BuildContext Context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: badges.Badge(
                                      badgeStyle: badges.BadgeStyle(
                                        shape: badges.BadgeShape.square,
                                        badgeColor: secondaryColor,
                                        padding: const EdgeInsets.all(5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      onTap: () {
                                        modificationScreen(
                                            data[index]['MateialName'],
                                            data[index]['UOM'],
                                            data[index]['Make'],
                                            data[index]['Model'],
                                            data[index]['Qty']);
                                      },
                                      badgeContent: const Icon(Icons.edit,
                                          color: Colors.white),
                                      child: SizedBox(
                                        height: 330,
                                        width: double.infinity,
                                        child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.grey.shade50,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  left: 8.0,
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Material Code',
                                                          style: commonRoboto),
                                                      Text('Material Name',
                                                          style: commonRoboto),
                                                      Text('Make',
                                                          style: commonRoboto),
                                                      Text('Model',
                                                          style: commonRoboto),
                                                      Text('UOM',
                                                          style: commonRoboto),
                                                      Text('Required Quantity',
                                                          style: commonRoboto),
                                                      Text('Rate',
                                                          style: commonRoboto),
                                                      Text('Amount',
                                                          style: commonRoboto),
                                                      Text('Tax %',
                                                          style: commonRoboto),
                                                      Text('Tax Amount',
                                                          style: commonRoboto),
                                                      Text('Total Amount',
                                                          style: commonRoboto),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 25),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          ': ${data[index]['MaterialCode']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['MateialName']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['Make']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['Model']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['UOM']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['Qty']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['rate']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['amt']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['tax']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['taxAmount']}',
                                                          style: cardValue),
                                                      Text(
                                                          ': ${data[index]['totalAmount']}',
                                                          style: cardValue),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                  );
                                }),
                      ),
                      const SizedBox(height: 10),
                    ]),
                  ),
                )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {},
        label: const Text('Save'),
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
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Submit Quotation Bill',
            style: TextStyle(
                color: secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.2),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                enquiryCode(mediaWidth),
                enquiryDate(mediaWidth),
                refTextField(mediaWidth),
                deliveryTextField(mediaWidth),
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: secondaryColor,
                  ),
                  onPressed: () {},
                  child:
                      const Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                paymentTextField(mediaWidth),
                validityTextField(mediaWidth),
                quotationCode(mediaWidth),
                quotationTextField(mediaWidth),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                remarkTextField(MediaQuery.of(context).size.width * 0.4),
                grandTotalTextField(mediaWidth),
                taxTextField(mediaWidth),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: tableWidget(),
            ),
          ],
        ));
  }

  Widget tableWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: primaryColor,
            ),
            height: 35,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 60, child: Text('Action', style: tileHeader)),
                  SizedBox(
                      width: 100,
                      child: Text('Material Code', style: tileHeader)),
                  SizedBox(
                      width: 135,
                      child: Text('Material Name', style: tileHeader)),
                  SizedBox(width: 90, child: Text('Make', style: tileHeader)),
                  SizedBox(width: 100, child: Text('Model', style: tileHeader)),
                  SizedBox(width: 80, child: Text('UOM', style: tileHeader)),
                  SizedBox(
                      width: 150,
                      child: Text('Required Quantity', style: tileHeader)),
                  SizedBox(width: 100, child: Text('Rate', style: tileHeader)),
                  SizedBox(
                      width: 100, child: Text('Amount', style: tileHeader)),
                  SizedBox(width: 100, child: Text('Tax%', style: tileHeader)),
                  SizedBox(
                      width: 120, child: Text('Tax Amount', style: tileHeader)),
                  SizedBox(
                      width: 100,
                      child: Text('Total Amount', style: tileHeader)),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.33,
              child: data.isEmpty
                  ? webShimmer(double.infinity)
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext Context, index) {
                        return ElasticInRight(
                            child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                            onTap: () {
                                              modificationScreen(
                                                  data[index]['MateialName'],
                                                  data[index]['UOM'],
                                                  data[index]['Make'],
                                                  data[index]['Model'],
                                                  data[index]['Qty']);
                                              // detailView(
                                              //     data[index]['EnquiryID'],
                                              //     data[index]['EnquiryNo'],
                                              //     data[index]['EnquiryDate'],
                                              //     data[index]['RequiredDate'],
                                              //     data[index]['NoOfItem'].toString());
                                            },
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            child: const Icon(Icons.edit,
                                                size: 14,
                                                color: secondaryColor),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${data[index]['MaterialCode'] ?? ''}',
                                          style: cardValue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          '${data[index]['MateialName'] ?? data[index]['MateialName']}',
                                          style: cardValue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          '${data[index]['Make'] ?? data[index]['Make']}',
                                          style: cardValue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${data[index]['Model'] ?? data[index]['Model']}',
                                          style: cardValue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                            '${data[index]['UOM'] ?? data[index]['UOM']}',
                                            style: cardValue),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                            '${data[index]['Qty'] ?? data[index]['Qty']}',
                                            style: cardValue),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${data[index]['rate'] ?? data[index]['rate']}',
                                          style: cardValue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${data[index]['amt'] ?? data[index]['amt']}',
                                          style: cardValue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${data[index]['tax'] ?? data[index]['tax']}',
                                          style: cardValue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                            '${data[index]['taxAmount'] ?? data[index]['taxAmount']}',
                                            style: cardValue),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                            '${data[index]['totalAmount'] ?? data[index]['totalAmount']}',
                                            style: cardValue),
                                      ),
                                    ],
                                  ),
                                )));
                      }),
            ),
          ),
        ),
      ],
    );
  }

  Widget enquiryCode(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
              child: Text(
                'Enquiry Code',
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
                    '1080',
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

  Widget enquiryDate(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
            child: Text('Enquiry Date', style: textInputHeader),
          ),
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
                  child: Text('05-12-2023', style: cardValue),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget quotationCode(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
            child: Text(
              'Quotation Code',
              style: textInputHeader,
            ),
          ),
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
                    'Autogenerated',
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

  Widget refTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Reference Number', style: textInputHeader),
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
              cursorColor: secondaryColor,
              decoration: inputBox('Enter Reference No'),
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveryTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Delivery Date', style: textInputHeader),
          ),
          SizedBox(
            height: 32,
            width: val,
            child: TextFormField(
              onTap: () {
                datePicker('Delivery');
              },
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return "Username should not be empty";
              //   } else {
              //     return null;
              //   }
              // },
              cursorColor: secondaryColor,
              controller: deliveryController,
              decoration: inputDateBox('Enter Delivery Date'),
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Payment Terms', style: textInputHeader),
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
              cursorColor: secondaryColor,
              decoration: inputBox('Enter Payment Terms'),
            ),
          ),
        ],
      ),
    );
  }

  Widget validityTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Validity', style: textInputHeader),
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
              cursorColor: secondaryColor,
              decoration: inputBox('Enter Validity'),
            ),
          ),
        ],
      ),
    );
  }

  Widget quotationTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Quotation Date', style: textInputHeader),
          ),
          SizedBox(
            width: val,
            height: 32,
            child: TextFormField(
              onTap: () {
                datePicker('Quotation');
              },
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return "Username should not be empty";
              //   } else {
              //     return null;
              //   }
              // },
              cursorColor: secondaryColor,
              controller: quotationController,
              decoration: inputDateBox('Enter Quotation Date'),
            ),
          ),
        ],
      ),
    );
  }

  Widget remarkTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Remarks', style: textInputHeader),
          ),
          SizedBox(
            width: val,
            child: TextFormField(
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return "Username should not be empty";
              //   } else {
              //     return null;
              //   }
              // },
              minLines: 2,
              maxLines: 4,
              cursorColor: secondaryColor,
              decoration: inputBox('Enter Remarks'),
            ),
          ),
        ],
      ),
    );
  }

  Widget grandTotalTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Grand Total Amount', style: textInputHeader),
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
              cursorColor: secondaryColor,
              decoration: inputBox('Enter Grand Total Amount'),
            ),
          ),
        ],
      ),
    );
  }

  Widget taxTextField(double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Tax Card', style: textInputHeader),
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
              cursorColor: secondaryColor,
              decoration: inputBox('Enter Tax Card'),
            ),
          ),
        ],
      ),
    );
  }
}
