import 'package:flutter/material.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/dashbord/componets/select_business.dart';
import 'package:seed_sales/screens/dashbord/model/dash_menu.dart';
import 'package:seed_sales/screens/user/componets/user_creation_form.dart';
import 'package:seed_sales/sizeconfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardItems extends StatefulWidget {
  const DashBoardItems({ Key? key }) : super(key: key);

  @override
  _DashBoardItemsState createState() => _DashBoardItemsState();
}

class _DashBoardItemsState extends State<DashBoardItems> {
  List<DashBoardMenu> menuItems =[
    DashBoardMenu(title: 'Total Appointments',content: '\$11,500.00',icons: Icons.book_outlined),
    DashBoardMenu(title: 'Total Customers',content: '250+',icons: Icons.person_outline_outlined),
     DashBoardMenu(title: 'Product Listed',content: '1,500+',icons: Icons.menu),
    DashBoardMenu(title: 'Total Sales',content: '1,5000',icons: Icons.category),


       
  ];
    bool left=false;
   Future<int> getSelctedBusiness() async{
      SharedPreferences pref= await SharedPreferences.getInstance();
      int? sel= pref.getInt('selected_business');
      if(sel==null){
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          isDismissible: false,
          enableDrag: false,
          builder: (context) {
            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:  Radius.circular(25.0),
                    topRight:  Radius.circular(25.0),
                  )
              ),
              child:
                const BusinessSelectPopup(),

            );
          },
        );
      }
      return 1;
    }
@override
  void initState() {
    getSelctedBusiness();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection:Axis.vertical,
        itemCount:menuItems.length,
        itemBuilder: (_,index){
            left=!left;
            return DashBordItem(isLeft: left, icon: menuItems[index].icons, title: menuItems[index].title, content: menuItems[index].content); 
        }
        ),
    );
  }
}
class DashBordItem extends StatelessWidget {
  final bool isLeft;
  final IconData icon;
  final String title;
  final String content; 
  const DashBordItem({ Key? key,required this.isLeft,required this.icon,required this.title,required this.content }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,

        child: Stack(
          alignment:isLeft? AlignmentDirectional.topEnd:AlignmentDirectional.topStart,
          children: [
            Positioned(
              
              child: Container(
                width: MediaQuery.of(context).size.width*0.75,
                height: SizeConfig.blockSizeVertical!*18,
                decoration: BoxDecoration(
                  color:secondrayColor,
                  borderRadius:BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,style: TextStyle(fontSize: fontResize(context, 2.5),fontWeight: FontWeight.w500),),
                    spacer(10),
                    Text(content,style: TextStyle(fontSize: fontResize(context, 5),fontWeight: FontWeight.bold,decorationThickness: 1),),
                  ],
                ),
              ),
            ),
           isLeft? Positioned(
             
             right:MediaQuery.of(context).size.width*0.68,
              top: (SizeConfig.blockSizeVertical!*11)/2,
              child: ClipOval(
                child: Container(
                  width: SizeConfig.blockSizeVertical!*8,
                  height: SizeConfig.blockSizeVertical!*8,
                  decoration:   BoxDecoration(
                    color: primaryColor,
                    border: Border.all(
                      color:secondrayColor
                    ),
                    shape:BoxShape.circle
                  ),
                  child:const Icon(Icons.share,color: secondrayColor,)),
              )
              ):
               Positioned(
             
             left:MediaQuery.of(context).size.width*0.68,
              top: (SizeConfig.blockSizeVertical!*11)/2,
              child: ClipOval(
                child: Container(
                  width: SizeConfig.blockSizeVertical!*8,
                  height: SizeConfig.blockSizeVertical!*8,
                  decoration:   BoxDecoration(
                    color: primaryColor,
                    border: Border.all(
                      color:secondrayColor
                    ),
                    shape:BoxShape.circle
                  ),
                  child:const Icon(Icons.share,color: secondrayColor,)),
              )
              )

          ],
        ),
      ),
    );
  }
}