import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:school_app/ui/widgets/schedule_widget.dart';
import '../../theme/styles.dart';
import '../components/components.dart';

class SchesuleScreen extends StatelessWidget {
  const SchesuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(//Center(child: Text('Program of the week')),
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: blue_gardinaeet,
            ),
          ),
          body: Column(
            children: [
              ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    height: height/8,width: width,
                    decoration:blue_gardinaeet,
                    child: Padding(
                        padding: EdgeInsets.only(left: width/16),
                        child: Animated_Text(width: width, text:'Schedule')),
                  )
              ),
              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Container(color: Colors.white10,
                      height: height/1.35,
                      child: Row(
                          children: [
                            animation_column(height: height, width: width, children: [
                              SizedBox(height: height/25,),
                              days_container(width: width,day:'Sunday', height: height ),
                              days_container(width: width,day:'Monday' ,height:height),
                              days_container(width: width,day:'Tuesday',height:height ),
                              days_container(width: width,day:'Wednsday' ,height:height),
                              days_container(width: width,day:'Thursday' ,height:height),
                            ]),
                            SizedBox(
                              width: width/0.33,
                              child: AlignedGridView.count(
                                crossAxisCount: 7,itemCount: 34,
                                itemBuilder: (context, index) {
                                  return
                                    (index==27)?SizedBox():
                                    /*
                              (index==28)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][27],saf_id: saf_id,last: cubit.available_list[27]):
                              (index==29)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][28],saf_id: saf_id,last:cubit.available_list[28]):
                              (index==30)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][29],saf_id: saf_id,last:cubit.available_list[29]):
                              (index==31)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][30],saf_id: saf_id,last:cubit.available_list[30]):
                              (index==32)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][31],saf_id:saf_id,last:cubit.available_list[31] ):
                              (index==33)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][32],saf_id:saf_id,last:cubit.available_list[32] ):
                              */
                                    sch_container(height: height,width: width,Subject: 'geographyyyyyyyyyy');
                                },
                              ),
                            ),
                            SizedBox(width: width/10,)

                          ])
                  )
              )
            ],
          )
        ),
        Positioned(
            left: width/2,top: height/15,
            child: Image.asset('assets/image/Calendar.png',height: height/4,width: width/2,fit: BoxFit.fill,)),
      ],
    );
  }
}
