import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  void _goToPage(BuildContext context, Widget page){

  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('SetState'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('ValueNotifier'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('ChangeNotifier'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Bloc Pattern (Streams)'),
          ),
        ],
      ),
    );
  }
}
