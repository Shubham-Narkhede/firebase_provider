import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_provider/modules/home/models/ModelProduct.dart';
import 'package:firebase_provider/widget/WidgetText.dart';
import 'package:flutter/material.dart';

class ScreenProductListing extends StatefulWidget {
  final List<ModelProducts> list;
  ScreenProductListing({required this.list});
  @override
  _ScreenProductListingState createState() => _ScreenProductListingState();
}

class _ScreenProductListingState extends State<ScreenProductListing> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: (itemWidth / itemHeight),
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: widget.list.map<Widget>((value) {
          ModelProducts item = value;
          return Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(offset: const Offset(0, 1), color: Colors.grey.shade300)
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: item.images![0],
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widgetText(item.title!,
                          textStyle: textStyle(
                            fontWeight: FontWeight.w700,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 7),
                        child: widgetText(item.description!,
                            maxLine: 3, textStyle: textStyle(fontSize: 14)),
                      ),
                      Row(
                        children: [
                          widgetText("\$${item.price!.toString()}",
                              textStyle: textStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              )),
                          widgetText(
                              "  ${item.discountPercentage!.toString()}% off",
                              textStyle: textStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                textColor: Colors.greenAccent.shade700,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
