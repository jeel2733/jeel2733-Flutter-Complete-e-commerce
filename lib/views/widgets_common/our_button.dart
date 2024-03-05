import 'package:emart/consts/consts.dart';

Widget ourButton({onPress,String? title,color,textcolor,}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPress,
         child: title!.text.color(textcolor).fontFamily(bold).make());
}