import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/views/cart_screen/payment_method.dart';
import 'package:emart/views/widgets_common/custom_textfield.dart';
import 'package:emart/views/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () {
            if(controller.addressController.text.length > 10){
                Get.to(()=>const PaymentMethods());
            }else
            {
                  VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: redColor,
          textcolor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                ispass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                ispass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                ispass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                ispass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
            customTextField(
                hint: "Phone",
                ispass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
