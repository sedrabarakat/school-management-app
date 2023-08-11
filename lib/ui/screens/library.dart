import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:school_app/ui/components/components.dart';
import '../../cubit/library/library_cubit.dart';
import '../../cubit/library/library_states.dart';
import '../widgets/library widget.dart';

class Library extends StatelessWidget {

  //Color.fromARGB(255, 241, 246, 252)
  var Date_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context)=>Library_cubit()..Get_Books(),
      child: BlocConsumer<Library_cubit,Library_state>(
        listener: (context,state){
        },
        builder: (context,state){
          Library_cubit cubit=Library_cubit.get(context);
          List<dynamic>book_list=cubit.Books_list;
          return Scaffold(
              backgroundColor:Color.fromARGB(255, 233, 242, 253),
              body: Column(
                children: [
                  Stack(children: [
                    Padding(
                      padding:  EdgeInsets.only(top: height/20),
                      child: ClipPath(
                        clipper: OvalBottomBorderClipper(),
                        child: Container(height: height/3,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 241, 246, 252),
                                )
                            ),
                            child:Image.asset('assets/image/Education (3).jpeg',
                              width: width,height: height,
                              fit: BoxFit.fill,)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height/10,left: width/20),
                      child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon:Icon(Icons.arrow_back_ios,color: Colors.lightBlue,))
                           )
                  ],),
                  Expanded(
                      child: ConditionalBuilder(
                        condition: book_list.isNotEmpty,
                        builder: (context)=>ListView.separated(
                            padding: EdgeInsets.only(top: height/30),
                            physics:BouncingScrollPhysics() ,
                            shrinkWrap: true,
                            itemBuilder: (context,index)=>Library_Cell(
                                height: height,width: width,context: context,
                                item:book_list[index],
                              textcontroller: Date_controller
                            ),
                            separatorBuilder: (context,index)=>SizedBox(),
                            itemCount: book_list.length),
                        fallback: (context)=>Container(),
                      ))
                ],)
          );
        },
      ),
    );
  }
}

