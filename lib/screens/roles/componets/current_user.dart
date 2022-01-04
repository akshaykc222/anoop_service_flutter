import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class CurrentUser extends StatelessWidget {
  const CurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
       const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            currentuser,
            style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
        ),
        InkWell(
            onTap: (){
              Navigator.pushNamed(context, roleList);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/edit.svg',color: textColor,),
            ))
      ],
    );
  }
}
