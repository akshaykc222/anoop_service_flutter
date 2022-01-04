import 'package:flutter/material.dart';

import '../../../componets.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl=TextEditingController();
    return Column(
      children: [
        columUserTextFileds("search","",TextInputType.name,ctrl),
        spacer(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [Text("sort by"), Icon(Icons.arrow_downward)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [Text("Filter"), Icon(Icons.arrow_downward)],
              ),
            )
          ],
        ),
      ],
    );
  }
}
