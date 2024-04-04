import 'package:doocar/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doocar/widget/banner_widget.dart';
export 'package:doocar/widget/shopping.dart';

class ShoppingListviewWidget extends StatefulWidget {
  const ShoppingListviewWidget({super.key});

  @override
  State<ShoppingListviewWidget> createState() => ShoppingListviewWidgetState();
}

class ShoppingListviewWidgetState extends State<ShoppingListviewWidget>
    with TickerProviderStateMixin {
  List recorde = [];
  late ShoppingListviewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    imageformdb();
    super.initState();

    _model = createModel(context, () => ShoppingListviewModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  Future<void> imageformdb() async {
    try {
      String uri = "https://doocar.000webhostapp.com/viewimage.php";
      var response = await http.get(Uri.parse(uri));
      setState(() {
        recorde = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        const BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderRadius: 20,
                            borderWidth: 1,
                            buttonSize: 40,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            icon: Icon(
                              Icons.tune_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: BannerWidget(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // ปรับจำนวนคอลัมน์ตามที่ต้องการ
                          mainAxisSpacing: 8, // เพิ่มระยะห่างระหว่างแถว
                          crossAxisSpacing: 8, // เพิ่มระยะห่างระหว่างคอลัมน์
                          childAspectRatio: 1, // สัดส่วนของความสูงต่อความกว้าง
                        ),
                        itemCount: recorde.length,
                        itemBuilder: (BuildContext context, index) {
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    // ตั้งค่าขนาดความสูงของภาพเพื่อให้รูปภาพทั้งหมดอยู่ในขนาดเดียวกัน
                                    height: 40,
                                    width: 40,
                                    child: Image.network(
                                      "https://doocar.000webhostapp.com/viewimage.php" +
                                          recorde[index]["image"],
                                      fit: BoxFit
                                          .cover, // ปรับขนาดภาพให้พอดีกับพื้นที่ที่กำหนด
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
