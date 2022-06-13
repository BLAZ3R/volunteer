import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:volunteer/constants/MainTheme.dart';

class OrganizationInfoFormWidget extends StatelessWidget {
  String? title;
  final double width;
  final double height;
  final String url;

  OrganizationInfoFormWidget(
      {this.title,
      required this.url,
      this.width = 300,
      this.height = 148,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UriData? data = Uri.parse(url).data;
    Uint8List? myImage = data?.contentAsBytes();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: Image.memory(
                myImage!,
                fit: BoxFit.cover,
              ),
            ),

            Container(
              width: width,
              height: 70,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title!,
                      style: MainTheme.of(context).title3,
                    ),
                  ),
                ],
              ),
            )

            // Container(
            //   width: width,
            //   height: 70,
            //   color: Colors.white,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         title!,
            //         style: MainTheme.of(context).title3,
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
