import 'package:flutter/material.dart';
import 'package:volunteer/constants/MainTheme.dart';

class EventInfoFormWidget extends StatelessWidget {
  final String date;
  final String title;
  final String address;
  final double width;
  final double height;
  final String url;

  const EventInfoFormWidget(
      {required this.date,
      required this.title,
      required this.address,
      required this.url,
      this.width = 130,
      this.height = 148,
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
                top: 60,
                child: Container(
                    width: 82,
                    height: 21,
                    decoration: BoxDecoration(
                      color: MainTheme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.6),
                      child: Center(
                        child: Text(
                          "$date",
                          style: MainTheme.of(context).bodyText2,
                        ),
                      ),
                    ))),
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
                      Text(address, style: MainTheme.of(context).bodyText1),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
