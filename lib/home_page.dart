import 'package:flutter/material.dart';
import 'package:state_manager/setState/imc_setstate_page.dart';
import 'package:state_manager/value_notifier/imc_value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(context, ImcSetstatePage()),
              child: Text('SetState'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, ValueNotifierPage()),
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
      ),
    );
  }
}
