import 'dart:io';

import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/views/widgets_common/bg_widget.dart';
import 'package:emart/views/widgets_common/custom_textfield.dart';
import 'package:emart/views/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false, // emart use
          appBar: AppBar(),
      body: Obx(
        () => Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textcolor: whiteColor,
                title: "Change"),
            Divider(),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                ispass: false),
            10.heightBox,
            customTextField(
                controller: controller.oldpasswordController,
                hint: passwordHint,
                title: oldpassword,
                ispass: true),
            10.heightBox,
            customTextField(
                controller: controller.newpasswordController,
                hint: passwordHint,
                title: newpassword,
                ispass: true),
            20.heightBox,
            controller.isloading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redColor,
                        onPress: () async {
                          controller.isloading(true);
                          //if image is not selected
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImgLink = data['imageUrl'];
                          }
                          //old password match is data base
                          if (data['password'] ==
                              controller.oldpasswordController.text) {
                            await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpasswordController.text,
                                newPassword:
                                    controller.newpasswordController.text);
                            await controller.updateProfile(
                              imgUrl: controller.profileImgLink,
                              name: controller.nameController.text,
                              password: controller.newpasswordController.text,
                            );
                            VxToast.show(context, msg: 'Updated');
                          } else {
                            VxToast.show(context, msg: 'Wrong Old Password');
                            controller.isloading(false);
                          }
                        },
                        textcolor: whiteColor,
                        title: "Save")),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(EdgeInsets.all(16))
            .rounded
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}
