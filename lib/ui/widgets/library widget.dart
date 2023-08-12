import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../cubit/library/library_cubit.dart';
import '../../theme/styles.dart';
import '../components/components.dart';

var Selected_date;
Future show({
  required BuildContext context,
  required double height,
  required double width,
  required TextEditingController textcontroller,
  required var item,
  required var press
}){
  return context.showModalFlash(
      builder: (context, controller) => Flash(
        controller: controller,
        dismissDirections: FlashDismissDirection.values,
        slideAnimationCreator: (context, position, parent, curve, reverseCurve) {
          return controller.controller.drive(Tween(begin: Offset(0.1, 0.1), end: Offset.zero));
        },
        child:AlertDialog(
          shadowColor: Colors.blue,
          contentPadding: EdgeInsets.only(left: 24.0, right: 24.0,bottom: 0),
          title: Padding(
            padding:  EdgeInsets.only(bottom: height/55),
            child: Text("Pick Return Date",style: TextStyle(
              fontSize:width/15,color: Colors.blue
            ),),
          ),
          content: Container(
            height: height/3,
            width: width/1.5,
            child: SfDateRangePicker(
              headerHeight: height/20,
              view: DateRangePickerView.month,
              selectionColor: Colors.lightBlue,
              selectionRadius: 30,
              showNavigationArrow: true,
              viewSpacing: 50,
              selectionMode: DateRangePickerSelectionMode.single,
              minDate: DateTime.now(),
              onSelectionChanged: (value){
                Selected_date=DateFormat('yyyy/M/dd').format(value.value);
              },
            ),
            ),
          actions: [
            TextButton(
              onPressed:press,
              child: Text('Reserve'),
            ),
            TextButton(
              onPressed: (){
                controller.dismiss();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      )
  );
}

Widget Library_Cell({
  required double height,
  required double width,
  required BuildContext context,
  required Map<dynamic,dynamic> item,
  required TextEditingController textcontroller
}){
  return Padding(
    padding:  EdgeInsets.only(left: width/15,right: width/15,bottom:  height/30),
    child: Container(
      height: height/5.5,
      decoration: BoxDecoration(
          color:   Colors.white70,//Color.fromARGB(255, 128, 196, 231),
          borderRadius: BorderRadius.circular(25)
      ),
      child: Row(children: [
        small_book(width: width, height: height, ImagePath: item['img']),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width/15,top: height/28,),
              child: SizedBox(
                width: width/2.3,
                child: Text('${item['name']}',
                  maxLines: 1,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: width/20,
                      color: Colors.lightBlue
                  ),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width/15,top: height/70),
              child: Text((item['is_available']==1)?'Tap to reserve it':'Already Reserved',
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    fontSize: width/27,
                    color: (item['is_available']==1)?Colors.lightBlueAccent:
                    Colors.red.shade800
                ),),
            ),
            Padding(
              padding:  EdgeInsets.only(
                  left: (item['is_available']==1)?width/3:width/3.2,
                  top: height/100),
              child: elevatedbutton(Function: (){
                if(item['is_available']==1){
                show(context: context, height: height,
                    width: width,textcontroller: textcontroller,
                    item: item,
                    press: (){
                      if(item['is_available']==1 && Selected_date!=null){
                        Library_cubit.get(context).Booked(
                            return_date: Selected_date.toString(),
                            book_id: item['id'],
                            student_id: 1).then((value) => Library_cubit.get(context).Get_Books());
                        Selected_date=null;
                        Navigator.pop(context, true);
                      }
                      if(Selected_date==null){

                      }
                    });
                }
              }, widthSize: (item['is_available']==1)?width/4.5:width/3.9,
                borderRadius: 80,
                backgroundColor:(item['is_available']==1)?Color.fromARGB(255, 49, 163, 255):
                Color.fromARGB(255, 0, 63, 180),
                heightSize:  width/20,
                text:( item['is_available']==1)?'Reserve':'Unavailable',
              ),
            )
          ],)
      ],),
    ),
  );
}


Widget small_book({
  required double width,
  required double height,
  required var ImagePath
}){
  var ImageBytes;
  if(ImagePath!=null){
    int startIndex = ImagePath.indexOf('images/') + 'images/'.length;
     ImageBytes = ImagePath.substring(startIndex);
    //print(ImageBytes);
  }
  return Transform.rotate(
    angle: -45.0,
    child: Container(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.topCenter,
        height: height/9.5,width: width/3.7,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 0, 40, 72),
              width: 5.0,
            ),
            left: BorderSide(
              color: Colors.white24,
              width: 8.0,
            ),
          ),
          color: Color.fromARGB(255, 0, 80, 180),
          /* boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 10.0,
                spreadRadius: 1,
                offset: Offset(8, 10,),
              ),
              BoxShadow(
                  color: Colors.lightBlue.shade100,
                  blurRadius: 10.0,
                  spreadRadius: 1,
                  offset: Offset(1, 7)
              )
            ]*/
        ),
        child: (ImagePath!=null)?
        Container(
            height: height/10,width: width/4,
            child: RotatedBox(quarterTurns: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CachedNetworkImage(
                fadeInCurve: Curves.easeIn,
                imageUrl: 'http://10.0.2.2:8000/storage/images/$ImageBytes',
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.book),
                fit: BoxFit.fill,
              ),
            ),)
        ):
        Container(
            height: height/10,width: width/4,
            child: RotatedBox(
              quarterTurns: 1,
              child: Image.asset(
                "assets/image/book.jpg",
                fit: BoxFit.fill,
              ),
            )
        )
    ),
  );
}

//http://10.0.2.2:8000/storage/
TextFormField default_TextFromField({
  required double width,
  required double height,
  required TextEditingController controller,
  required TextInputType keyboardtype,
  required String ?hintText,
  ValueChanged<String>?changed,
  ValueChanged<String>?submit,
  var tap,
  List <TextInputFormatter> ?inputformater,
  IconData ?prefixicon,
  Color prefixcolor=Colors.lightBlue,
  Color bordercolor=Colors.blue,
  Color fillColor=const Color.fromARGB(255, 239, 244, 249),
  double borderRadius=20,
  double borderWidth=2,
  bool fill=true,
  bool justread=false,
  bool is_there_border=true,
  bool is_there_prefix=true,
  bool is_email=false,
  bool is_basic_name=false,
  bool is_there_suffix=false,
  Widget ?suffix,
  Color suffixcolor=Colors.blue,
  String Error_Text='Please Fill That Field',
  int maxlines=4,
  int minlines=1,
}){
  return TextFormField(
    style: normal_TextStyle(width: width,color: Colors.black),
    readOnly: justread,
    controller: controller,
    maxLines: maxlines,
    minLines: minlines,
    keyboardType: keyboardtype,
    inputFormatters: inputformater,
    onChanged: changed,
    onFieldSubmitted: submit,
    onTap: tap,
    decoration: InputDecoration(
        hintText: hintText,
        filled: fill,
        prefixIcon: (is_there_prefix)?Icon(prefixicon,color: prefixcolor):null,
        fillColor:fillColor,
        border: (is_there_border)?OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:BorderSide(color: bordercolor,)
        ):InputBorder.none,
        enabledBorder: (is_there_border)?OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:BorderSide(color: bordercolor,width:borderWidth)
        ):InputBorder.none,
        errorBorder: OutlineInputBorder(
            gapPadding: 8,
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:BorderSide(color: Colors.red.shade700,width:borderWidth)
        ),
        suffixIconColor: suffixcolor,
        suffixIcon: (is_there_suffix)?suffix:null
    ),
    validator: (value){
      if(value==null||value.isEmpty) {
        return Error_Text;}
      else
        return null;
    },
  );
}

/*
* showDatePicker(
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.purple, //outer color
                            onPrimary: Colors.white, //text
                            onSurface: Colors.purple,//buttons
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.purple, // button text color
                            ),),),
                        child: child!,
                      );
                    },
                    context: context,firstDate:DateTime(2023) ,
                    initialDate:DateTime.now() ,lastDate:DateTime(2023));*/