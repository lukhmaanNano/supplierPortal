import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplierportal/screens/PurchaseOrders/purchaseOrderDetail.dart';
import 'package:supplierportal/styles/Responsive.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../../styles/CommonTextStyle.dart';
import '../../styles/common Color.dart';
import '../../widgets/divider.dart';
import '../../widgets/mobileShimmer.dart';
import '../../widgets/shimmer.dart';

class PurchaseOrder extends StatefulWidget {
  const PurchaseOrder({Key? key}) : super(key: key);

  @override
  State<PurchaseOrder> createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {
  int pageIndex = 1, initialPage = 0, rowPerPage = 10;
  late int userId, userGroupId, gTotal;
  String? ip;
  late String selectedItem,
      purchaseOrderNo,
      purchaseOrderDate,
      deliveryPlace,
      deliveryDate,
      referenceNo;
  List<dynamic> data = [];

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
    purchaseApi();
  }

  Future<void> purchaseApi() async {
    const service = ApiConfig.api;
    final url = Uri.parse('$ip$service');
    final headers = {
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    final json =
        '{"data": {"p1": $userId,"p2": 0,"p3": 0,"p4": 0,"p5": 0,"p6": "","p7": "","p8": "","p9": "","p10": "","p11": $pageIndex,"p12": $rowPerPage,"p13": "POLIST","p14": "$userGroupId","p15": "$userId"}}';
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

  void detailView(String val, String pOrderNo, String pOrderDate, String dPlace,
      String dDate, String rNo, int gT) {
    setState(() {
      selectedItem = val;
      purchaseOrderNo = pOrderNo;
      purchaseOrderDate = pOrderDate;
      deliveryPlace = dPlace;
      deliveryDate = dDate;
      referenceNo = rNo;
      gTotal = gT;
    });
    Navigator.push(
        context,
        PageTransition(
            ctx: context,
            inheritTheme: true,
            type: PageTransitionType.rightToLeftWithFade,
            child: PurchaseOrderDetails(
                selectedItem: selectedItem,
                purchaseOrderNo: purchaseOrderNo,
                purchaseOrderDate: purchaseOrderDate,
                deliveryPlace: deliveryPlace,
                deliveryDate: deliveryDate,
                referenceNo: referenceNo,
                gTotal: gTotal)));
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
        title: const Text('Purchase Orders'),
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
                      height: MediaQuery.of(context).size.height * 0.70,
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
                                    height: 140,
                                    width: double.infinity,
                                    child: InkWell(
                                      onTap: () {
                                        detailView(
                                            data[index]['PurchaseOrderIDPK']
                                                .toString(),
                                            data[index]['PurchaseOrderNo'],
                                            data[index]['PurchaseOrderDate'],
                                            data[index]['DeliveryPlace'],
                                            data[index]['DeliveryDate'],
                                            data[index]['ReferenceNo'],
                                            data[index]['GrandTotal']);
                                      },
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
                                                    Text('Purchase Order No',
                                                        style: commonRoboto),
                                                    Text('Purchase Order Date',
                                                        style: commonRoboto),
                                                    Text('Delivery Place',
                                                        style: commonRoboto),
                                                    Text('Delivery Date',
                                                        style: commonRoboto),
                                                    Text('Reference Number',
                                                        style: commonRoboto),
                                                    Text('Grand Total',
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
                                                        ': ${data[index]['PurchaseOrderNo']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['PurchaseOrderDate']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['DeliveryPlace']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['DeliveryDate']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['ReferenceNo']}',
                                                        style: cardValue),
                                                    Text(
                                                        ': ${data[index]['GrandTotal']}',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget web() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Purchase Orders', style: pageHeaderWeb),
                    ),
                    const Icon(Icons.cached, size: 22, color: secondaryColor),
                  ],
                ),
              ),
              SizedBox(
                width: 450,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, bottom: 8.0),
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
                      const SizedBox(width: 10),
                      const Icon(Icons.filter_list, color: secondaryColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: primaryColor,
            ),
            height: 35,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 80,
                      child: Center(child: Text('Action', style: tileHeader))),
                  SizedBox(
                      width: 180,
                      child: Text('Purchase Order No', style: tileHeader)),
                  SizedBox(
                      width: 180,
                      child: Text('Purchase Order Date', style: tileHeader)),
                  SizedBox(
                      width: 160,
                      child: Text('Delivery Place', style: tileHeader)),
                  SizedBox(
                      width: 160,
                      child: Text('Reference No', style: tileHeader)),
                  SizedBox(
                      width: 160,
                      child: Text('Grand Total', style: tileHeader)),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 320,
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
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {
                                          detailView(
                                              data[index]['PurchaseOrderIDPK']
                                                  .toString(),
                                              data[index]['PurchaseOrderNo'],
                                              data[index]['PurchaseOrderDate'],
                                              data[index]['DeliveryPlace'],
                                              data[index]['DeliveryDate'],
                                              data[index]['ReferenceNo'],
                                              data[index]['GrandTotal']);
                                        },
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        child: const Icon(Icons.remove_red_eye,
                                            size: 14, color: secondaryColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                          '${data[index]['PurchaseOrderNo'] ?? data[index]['PurchaseOrderNo']}',
                                          style: cardValue),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                          '${data[index]['PurchaseOrderDate'] ?? data[index]['PurchaseOrderDate']}',
                                          style: cardValue),
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                          '${data[index]['DeliveryPlace'] ?? data[index]['DeliveryPlace']}',
                                          style: cardValue),
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                          '${data[index]['ReferenceNo'] ?? data[index]['ReferenceNo']}',
                                          style: cardValue),
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                          '${data[index]['GrandTotal'] ?? data[index]['GrandTotal']}',
                                          style: cardValue),
                                    ),
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
      ],
    );
  }
}
