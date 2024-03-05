import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController{
      var isloading=false.obs;
  //textcontroller
  var emailcontroller= TextEditingController();
  var passwordcontroller= TextEditingController();


//login method
  Future<UserCredential?> loginMethod({context}) async{
    UserCredential? usercredential;

    try{
      usercredential=await auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);

    }on FirebaseAuthException catch (e){
      VxToast.show(context, msg: e.toString());
    }
      return usercredential;
  }

//signup method
  Future<UserCredential?> signupMethod({email,password,context}) async{
    UserCredential? usercredential;

    try{
      usercredential=await auth.createUserWithEmailAndPassword(email: email, password: password);

    }on FirebaseAuthException catch (e){
      VxToast.show(context, msg: e.toString());
    }
    return usercredential;
  }
  // storing data method
 storeUserData({name,password,email}) async{
    DocumentReference store= firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({'name': name,
      'password':password,'email':email,'imageUrl':'',
      'id':currentUser!.uid,
       'cart_count':"00",
      'wishlist_count':"00",
      'order_count':"00",

    });
 }
 // signout method
  signoutMethod(context) async{
    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }
}