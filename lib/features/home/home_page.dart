import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          // name and search
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // name and description
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello Antony,",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w500)),
                    Text('Find the service you want, and treat yourself')
                  ],
                ),

                Icon(Icons.search)
              ],
            ),
          )
        ],
      ),
    );
  }
}
