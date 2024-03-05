 import 'package:emart/controllers/auth_controllers.dart';
import 'package:emart/views/home_screen/Home.dart';

import '../../consts/consts.dart';
import '../../consts/lists.dart';
import '../widgets_common/applogo_widgiet.dart';
import '../widgets_common/bg_widget.dart';
import '../widgets_common/custom_textfield.dart';
import '../widgets_common/our_button.dart';

class signupScreen extends StatefulWidget {
   const signupScreen({super.key});



  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // text controller
  var namecontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var passwordRetypecontroller=TextEditingController();

  @override
   Widget build(BuildContext context) {
     return bgWidget(
         child: Scaffold(
           resizeToAvoidBottomInset: false,
           body: Center(
             child: Column( children: [
               (context.screenHeight * 0.1).heightBox,
               applogoWidget(),
               10.heightBox,
               "Join the $appname".text.fontFamily(bold).white.size(18).make(),
               15.heightBox,
               Obx(()=>Column(
                   children: [
                     customTextField(hint: nameHint,title: name,controller: namecontroller,ispass: false),
                     customTextField(hint: emailHint,title: email,controller: emailcontroller,ispass: false),
                     customTextField(hint: passwordHint,title: password,controller: passwordcontroller,ispass: true),
                     customTextField(hint: passwordHint,title: retypePassword,controller: passwordRetypecontroller,ispass: true),

                     Align(
                         alignment: Alignment.centerRight,
                         child: TextButton(onPressed: (){}, child: forgetpassword.text.make())),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: redColor,
                              value: isCheck, onChanged: (newvalue){
                                setState(() {
                                  isCheck=newvalue;
                                });
                          }),
                          10.heightBox,
                          Expanded(
                            child: RichText(text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "I agree to the",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )
                                ),TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    )
                                ),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )
                                ),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    )
                                ),
                              ]
                            )),
                          )

                        ],
                      ),
                     5.heightBox,
                     controller.isloading.value ? const CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation(redColor),
                     ) :   ourButton(color: isCheck == true? redColor : lightGrey ,title: signup,textcolor: whiteColor
                         ,onPress: ()async{
                          if(isCheck!=false){
                            controller.isloading(true);
                            try{
                              await controller.signupMethod(
                                context: context,
                                email: emailcontroller.text,
                                password: passwordcontroller.text,

                              ).then((value){
                                return controller.storeUserData(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  name: namecontroller.text,

                                );
                              }).then((value) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(()=> Home());
                              });
                            }catch (e){
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                    controller.isloading(false);

                            }
                          }

                         }).box.width(context.screenWidth -50).make(),
                     10.heightBox,
                     RichText(text: const TextSpan(
                       children: [
                         TextSpan(
                           text: alreadyHaveAccount,
                           style: TextStyle(fontFamily: bold,color: fontGrey)
                         ),
                         TextSpan(
                             text: login,
                             style: TextStyle(fontFamily: bold,color: redColor)
                         )
                       ]
                     )
                     ).onTap(() {Get.back();})
                   ],
                 ).box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth -70 ).shadowSm.make(),
               ),

             ],
             ),
           ),
         )
     );
   }
}
 