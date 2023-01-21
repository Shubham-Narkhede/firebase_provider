import 'package:firebase_provider/helper/HelperColor.dart';
import 'package:firebase_provider/modules/home/providers/ProviderProducts.dart';
import 'package:firebase_provider/widget/WidgetText.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'ScreenProductListing.dart';

/// ScreenHome this class we are using to show the product listing
class ScreenHome extends StatefulWidget {
  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderProducts>(context, listen: false).getProductsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HelperColor.colorBackGround,
        appBar: AppBar(
          title: widgetText("e-Shop",
              textStyle: textStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ),
        body: Consumer<ProviderProducts>(builder: (context, callBack, child) {
          /// if the list is empty then we show no product message
          if (callBack.getResponse.messageCode == 200) {
            if (callBack.getResponse.list!.isEmpty) {
              return widgetInfo(Icons.warning, "No Product Information Found!");
            } else {
              /// if the list is not empty then we show gridview with the product information
              return RefreshIndicator(
                onRefresh: () async {
                  Provider.of<ProviderProducts>(context, listen: false)
                      .getProductsList();
                },
                child: ScreenProductListing(
                  list: callBack.getResponse.list!,
                ),
              );
            }
          } else if (callBack.getResponse.messageCode == 400) {
            /// If there is an error then we show error message
            return widgetInfo(
                Icons.error, callBack.getResponse.responseMessage);
          }

          /// else we are showing loader
          return Center(
            child: LoadingAnimationWidget.inkDrop(
              color: HelperColor.colorPrimary,
              size: 40,
            ),
          );
        }));
  }

  Widget widgetInfo(IconData iconData, String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 50,
            color: HelperColor.colorPrimary,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: widgetText(title,
                textStyle: textStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
