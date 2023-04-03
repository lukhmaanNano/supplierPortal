import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplierportal/styles/Responsive.dart';
import 'package:supplierportal/widgets/divider.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../styles/CommonTextStyle.dart';
import '../../styles/common Color.dart';
import '../../widgets/mobileShimmer.dart';
import '../../widgets/shimmer.dart';

class PurchaseOrderDetails extends StatefulWidget {
  String? selectedItem,
      purchaseOrderNo,
      purchaseOrderDate,
      deliveryPlace,
      deliveryDate,
      referenceNo;
  int? gTotal;
  PurchaseOrderDetails(
      {Key? key,
      required this.selectedItem,
      this.purchaseOrderNo,
      this.purchaseOrderDate,
      this.deliveryPlace,
      this.deliveryDate,
      this.referenceNo,
      this.gTotal})
      : super(key: key);

  @override
  State<PurchaseOrderDetails> createState() => _PurchaseOrderDetailsState();
}

class _PurchaseOrderDetailsState extends State<PurchaseOrderDetails> {
  List<dynamic> data = [];
  String? ip;
  int pageIndex = 1, initialPage = 0, rowPerPage = 10;
  late int userId, userGroupId;

  @override
  void initState() {
    super.initState();
    local();
  }

  Future<void> local() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      ip = prefs.getString('ip');
      userGroupId = prefs.getInt('UserGroupID')!;
      userId = prefs.getInt('UserID')!;
    });
    purchaseDetailApi();
  }

  Future<void> purchaseDetailApi() async {
    const service = ApiConfig.api;
    final url = Uri.parse('$ip$service');
    final headers = {
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    final json =
        '{"data": {"p1": $userId,"p2": 0,"p3": 0,"p4": 0,"p5": 0,"p6": "","p7": "","p8": "","p9": "","p10": "","p11": $pageIndex,"p12": $rowPerPage,"p13": "PODETAILS","p14": "$userGroupId","p15": "$userId"}}';
    final response =
        await http.post(url, headers: headers, body: json.toString());
    if (response.statusCode == 400) {
      String err = 'something went wrong!';
    } else {
      final String jsonString = jsonEncode(response.body);
      var decodedJson = jsonDecode(jsonString);
      Map<String, dynamic> map = jsonDecode(decodedJson);
      var result = map['Output']['data'];
      setState(() {
        data = result;
      });
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
        title: const Text('Purchase Order Details'),
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
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: DividerWidget(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [purchaseOrderCount(), purchaseOrderDate()],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [deliveryPlace(), deliveryDate()],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [referenceNo(), grandTotal()],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xffAAAAAA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              padding: const EdgeInsets.all(4.5),
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 10,
                                          spreadRadius: 10)
                                    ]),
                                width: double.infinity,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Center(
                                        child: Icon(
                                          Icons.search,
                                          size: 25,
                                          color: grey100,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(color: grey100),
                                          border: InputBorder.none,
                                          hintText: 'Search',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const DividerWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.48,
                      width: double.infinity,
                      child: data.isEmpty
                          ? mobileShimmer(300)
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: SizedBox(
                                    height: 330,
                                    width: double.infinity,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Card(
                                          elevation: 1,
                                          shadowColor: Colors.grey.shade50,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Material Code',
                                                        style: commonRoboto),
                                                    Text('Material Name',
                                                        style: commonRoboto),
                                                    Text('Qty',
                                                        style: commonRoboto),
                                                    Text('UOM',
                                                        style: commonRoboto),
                                                    Text('Receipt Qty',
                                                        style: commonRoboto),
                                                    Text('Rate/Unit',
                                                        style: commonRoboto),
                                                    Text('Sub Total',
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        ': ${data[index]['MaterialCode']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['MaterialName']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['UOM']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['Qty']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['ReceiptQty']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['Rate']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['SubTotal']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['Tax']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['TaxAmount']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['TotalAmount']}',
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
                  )
                ])),
      ),
    );
  }

  Widget web() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            'Purchase Order Details',
            style: TextStyle(
                color: secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.2),
          ),
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
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: purchaseOrderCount(),
                        ),
                        purchaseOrderDate(),
                        deliveryPlace(),
                        deliveryDate(),
                        referenceNo(),
                        grandTotal()
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xffAAAAAA),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            padding: const EdgeInsets.all(4.5),
                            child: Container(
                              padding: EdgeInsets.zero,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10,
                                        spreadRadius: 10)
                                  ]),
                              width: 200,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, bottom: 8.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintStyle:
                                              TextStyle(color: secondaryColor),
                                          border: InputBorder.none,
                                          hintText: 'Search',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Icon(
                                      Icons.search,
                                      size: 25,
                                      color: secondaryColor,
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const Icon(Icons.filter_list, color: secondaryColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  color: primaryColor,
                ),
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 110,
                          child: Text('Material Code', style: tileHeader)),
                      SizedBox(
                          width: 180,
                          child: Text('Material Name', style: tileHeader)),
                      SizedBox(
                          width: 40, child: Text('UOM', style: tileHeader)),
                      SizedBox(
                          width: 40, child: Text('Qty', style: tileHeader)),
                      SizedBox(
                          width: 40,
                          child: Text('Receipt Qty', style: tileHeader)),
                      SizedBox(
                          width: 35,
                          child: Text('Rate/Unit', style: tileHeader)),
                      SizedBox(
                          width: 35,
                          child: Text('Sub Total', style: tileHeader)),
                      SizedBox(
                          width: 35, child: Text('Tax%', style: tileHeader)),
                      SizedBox(
                          width: 35,
                          child: Text('TaxAmount', style: tileHeader)),
                      SizedBox(
                          width: 35,
                          child: Text('Total Amount%', style: tileHeader)),
                    ],
                  ),
                ),
              ),
            ),
            Stack(alignment: AlignmentDirectional.bottomCenter, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.70,
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
                                          horizontal: 15.0, vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 110,
                                            child: Text(
                                              '${data[index]['MaterialCode'] ?? data[index]['MaterialCode']}',
                                              style: cardValue,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: Text(
                                                '${data[index]['MaterialName'] ?? data[index]['MaterialName']}',
                                                style: cardValue),
                                          ),
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                              '${data[index]['UOM'] ?? data[index]['UOM']}',
                                              style: cardValue,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                              '${data[index]['Qty'] ?? data[index]['Qty']}',
                                              style: cardValue,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                              '${data[index]['ReceiptQty'] ?? data[index]['ReceiptQty']}',
                                              style: cardValue,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                            child: Text(
                                                '${data[index]['Rate'] ?? data[index]['Rate']}',
                                                style: cardValue),
                                          ),
                                          SizedBox(
                                            width: 35,
                                            child: Text(
                                                '${data[index]['SubTotal'] ?? data[index]['SubTotal']}',
                                                style: cardValue),
                                          ),
                                          SizedBox(
                                            width: 35,
                                            child: Text(
                                                '${data[index]['Tax'] ?? data[index]['Tax']}',
                                                style: cardValue),
                                          ),
                                          SizedBox(
                                            width: 35,
                                            child: Text(
                                                '${data[index]['TaxAmount'] ?? data[index]['TaxAmount']}',
                                                style: cardValue),
                                          ),
                                          SizedBox(
                                            width: 35,
                                            child: Text(
                                                '${data[index]['TotalAmount'] ?? data[index]['TotalAmount']}',
                                                style: cardValue),
                                          )
                                        ],
                                      ),
                                    )));
                          }),
                ),
              ),
              SizedBox(
                height: 35,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton(
                      constraints:
                          const BoxConstraints.expand(width: 55, height: 200),
                      child: TextButton.icon(
                        label: Text('$rowPerPage'),
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: null,
                      ),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                            child: const Text('10', style: cardBody),
                            onTap: () => {
                                  setState(() {
                                    rowPerPage = 10;
                                  }),
                                }),
                        PopupMenuItem(
                            child: const Text('20', style: cardBody),
                            onTap: () => {
                                  setState(() {
                                    rowPerPage = 20;
                                  }),
                                }),
                        PopupMenuItem(
                            child: const Text('50', style: cardBody),
                            onTap: () => {
                                  setState(() {
                                    rowPerPage = 50;
                                  }),
                                }),
                        PopupMenuItem(
                            child: const Text('100', style: cardBody),
                            onTap: () => {
                                  setState(() {
                                    rowPerPage = 100;
                                  }),
                                }),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 5.09,
                          child: NumberPaginator(
                            numberPages: 10,
                            onPageChange: (int index) {
                              setState(() {
                                pageIndex = index;
                              });
                              if (pageIndex != 0) {
                                pageIndex++;
                              } else {
                                pageIndex = 1;
                              }
                            },
                            initialPage: initialPage,
                            config: NumberPaginatorUIConfig(
                              buttonSelectedForegroundColor: Colors.white,
                              buttonUnselectedForegroundColor: secondaryColor,
                              buttonSelectedBackgroundColor: secondaryColor,
                              buttonShape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ));
  }

  Widget purchaseOrderCount() {
    return Column(
      children: [
        const Text('Purchase Order Number'),
        SizedBox(
          width: 120,
          child: Card(
            elevation: 0,
            color: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Center(
                child: Text(
                  '${widget.purchaseOrderNo}',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget purchaseOrderDate() {
    return Column(
      children: [
        const Text('Purchase Order Date'),
        SizedBox(
          width: 120,
          child: Card(
            elevation: 0,
            color: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Center(
                child: Text(
                  '${widget.purchaseOrderDate}',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget deliveryPlace() {
    return Column(
      children: [
        const Text('Delivery Place'),
        SizedBox(
          width: 120,
          child: Card(
            elevation: 0,
            color: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Center(
                child: Text(
                  '${widget.deliveryPlace}',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget deliveryDate() {
    return Column(
      children: [
        const Text('Delivery Date'),
        SizedBox(
          width: 120,
          child: Card(
            elevation: 0,
            color: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Center(
                child: Text(
                  '${widget.deliveryDate}',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget referenceNo() {
    return Column(
      children: [
        const Text('Reference Number'),
        SizedBox(
          width: 120,
          child: Card(
            elevation: 0,
            color: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Center(
                child: Text(
                  '${widget.referenceNo}',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget grandTotal() {
    return Column(
      children: [
        const Text('Grand Total'),
        SizedBox(
          width: 120,
          child: Card(
            elevation: 0,
            color: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Center(
                child: Text(
                  '${widget.gTotal}',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
