import 'package:flutter/material.dart';
import 'package:volunteer/components/OrganizationInfoForm.dart';

class ListOfOrganizations extends StatelessWidget {
  const ListOfOrganizations({Key? key}) : super(key: key);

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
          child: const OrganizationInfoFormWidget(
              title: "Astana Jastary",
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
  }
}
