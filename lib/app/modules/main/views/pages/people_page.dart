import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:tit/app/core/src/app_size.dart';
import 'package:tit/app/core/src/app_spacing.dart';
import 'package:tit/app/data/models/person_model.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../../../../widgets/profile_image_widget.dart';
import '../../../home/controllers/home_controller.dart';
import '../../controllers/pages/people_controller.dart';

class PeoplePage extends GetView<PeopleController> {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("People"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(52.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchBar(
              hintText: "Search",
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading
            ? Container()
            : StreamBuilder<QuerySnapshot>(
                stream: controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final itemDoc =
                            snapshot.data?.docs[index].data() as PersonModel;

                        return ListTile(
                          onTap: () {
                            Get.toNamed(Routes.CHAT, arguments: itemDoc);
                          },
                          title: Text(itemDoc.displayName!),
                          leading: ProfileImageWidget(
                            size: 46,
                            url: itemDoc.photoUrl!,
                          ),
                        );
                      },
                      itemCount: snapshot.data?.docs.length ?? 0,
                    );
                  }
                }),
      ),
    );
  }
}
