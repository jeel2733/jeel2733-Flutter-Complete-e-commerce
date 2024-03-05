import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/auth_controllers.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:emart/views/chat_screen/messaging_screen.dart';
import 'package:emart/views/profile_screen/components/details_cart.dart';
import 'package:emart/views/profile_screen/edit_profile_screen.dart';
import 'package:emart/views/widgets_common/bg_widget.dart';
import 'package:emart/views/widgets_common/loading_indicator.dart';

import '../orders_screen/orders_screen.dart';
import '../wishlist_screen/wishlist_screen.dart';

class ProflieScreen extends StatelessWidget {
  const ProflieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    // FirestoreServices.getCounts();
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];
          return SafeArea(
            child: Column(
              children: [
                // edit profile button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.edit, color: whiteColor))
                      .onTap(() {
                    controller.nameController.text = data['name'];
                    Get.to(() => EditProfileScreen(data: data));
                  }),
                ),
// use details
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      data['imageUrl'] == ''
                          ? Image.asset(imgProfile2,
                                  width: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make()
                          : Image.network(data['imageUrl'],
                                  width: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                      10.heightBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          "${data['name']}"
                              .text
                              .fontFamily(semibold)
                              .white
                              .make(),
                          "${data['email']}".text.white.make(),
                        ],
                      )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.fontFamily(semibold).white.make())
                    ],
                  ),
                ),
                20.heightBox,

                FutureBuilder(
                    future: FirestoreServices.getCounts(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){
                      if(!snapshot.hasData){
                        return Center(child: loadingIndicator(),);
                      }
                      else{
                        var countData = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCart(
                                count: countData[0].toString(),
                                title: "in your cart",
                                width: context.screenWidth / 3.4),
                            detailsCart(
                                count: countData[1].toString(),
                                title: "in your wishlist",
                                width: context.screenWidth / 3.4),
                            detailsCart(
                                count: countData[2].toString(),
                                title: "your orders",
                                width: context.screenWidth / 3.4),
                          ],
                        );
                      }
                    },),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     detailsCart(
                //         count: data['cart_count'],
                //         title: "in your cart",
                //         width: context.screenWidth / 3.4),
                //     detailsCart(
                //         count: data['wishlist_count'],
                //         title: "in your wishlist",
                //         width: context.screenWidth / 3.4),
                //     detailsCart(
                //         count: data['order_count'],
                //         title: "your orders",
                //         width: context.screenWidth / 3.4),
                //   ],
                // ),
                // button section
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: ProfileButtonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: (){
                        switch(index){
                          case 0:
                            Get.to(()=> const OredrsScreen());
                            break;
                          case 1:
                            Get.to(()=> const WishlistScreen());
                            break;
                          case 2:
                            Get.to(()=> const MessagesScreen());
                            break;

                        }
                      },
                      leading: Image.asset(
                        ProfileButtonIcon[index],
                        width: 22,
                      ),
                      title: "${ProfileButtonList[index]}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                    );
                  },
                )
                    .box
                    .rounded
                    .white
                    .margin(EdgeInsets.all(12))
                    .shadowSm
                    .padding(EdgeInsets.symmetric(horizontal: 16))
                    .make()
                    .box
                    .color(redColor)
                    .make(),
              ],
            ),
          );
        }
      },
    )));
  }
}
