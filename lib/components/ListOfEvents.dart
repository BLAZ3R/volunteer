import 'package:flutter/material.dart';
import 'package:volunteer/components/EventInfoForm.dart';

class ListOfEventsWidget extends StatelessWidget {
  const ListOfEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext ctx, index) => GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => GymCardPage(
            //       company: companies[index],
            //     ),
            //   ),
            // );
          },
          child: const EventInfoFormWidget(
              date: "11/01/2020",
              title: "Aitu ICODE",
              address: "Кабанбай Батыра 20/1",
              url:
                  "https://tengrinews.kz/userdata/news/2021/news_443753/thumb_m/photo_368541.jpeg"),
        ),
        childCount: 10,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 32,
      ),
    );

    // return ListView.builder(
    //   itemCount: 1,
    //   itemBuilder: (BuildContext context, int index) {
    //     return const EventInfoFormWidget(
    //         date: "11/01/2020",
    //         title: "Aitu ICODE",
    //         address: "Кабанбай Батыра 20/1",
    //         url:
    //             "https://tengrinews.kz/userdata/news/2021/news_443753/thumb_m/photo_368541.jpeg");
    //   },
    // );
  }
}
