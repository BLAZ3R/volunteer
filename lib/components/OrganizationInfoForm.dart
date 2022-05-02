import 'package:flutter/material.dart';
import 'package:volunteer/constants/MainTheme.dart';

class OrganizationInfoFormWidget extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final String url;

  const OrganizationInfoFormWidget(
      {required this.title,
      required this.url,
      this.width = 130,
      this.height = 100,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: [
            Image.network(
              url,
              fit: BoxFit.cover,
            ),
            Positioned(
                bottom: 0,
                left: 8,
                child: Container(
                  width: width,
                  height: 70,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: MainTheme.of(context).title3,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
