import 'package:flutter/material.dart';

import 'cryptonians_screen.dart';
import 'pnl_screen.dart';
import 'news_screen.dart';
import 'bubble_screen.dart';
import 'exchange_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> items = [

      {
        "title": "Cryptonians",
        "icon": Icons.currency_bitcoin,
        "color": Colors.orange,
      },

      {
        "title": "Crypto News",
        "icon": Icons.newspaper,
        "color": Colors.blue,
      },

      {
        "title": "PnL Calculator",
        "icon": Icons.calculate,
        "color": Colors.green,
      },

     

      {
        "title": "Exchanges",
        "icon": Icons.account_balance,
        "color": Colors.red,
      },

      {
        "title": "Bubble Map",
        "icon": Icons.bubble_chart,
        "color": Colors.cyan,
      },
    ];

    return Scaffold(

      backgroundColor: const Color(0xFF0D1117),

      appBar: AppBar(

        backgroundColor: Colors.black,

        centerTitle: true,

        title: const Text(

          "ABDvoice Trading",

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: GridView.builder(

          itemCount: items.length,

          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,

            crossAxisSpacing: 15,

            mainAxisSpacing: 15,

            childAspectRatio: 1,
          ),

          itemBuilder: (context, index) {

            final item = items[index];

            return GestureDetector(

              onTap: () {

                if (item["title"] == "Cryptonians") {

                  Navigator.push(

                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                      const CryptoniansScreen(),
                    ),
                  );

                } else if (item["title"] == "PnL Calculator") {

                  Navigator.push(

                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                      const PnlScreen(),
                    ),
                  );

                } else if (item["title"] == "Crypto News") {

                  Navigator.push(

                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                      const NewsScreen(),
                    ),
                  );

                } else if (item["title"] == "Bubble Map") {

                  Navigator.push(

                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                      const BubbleScreen(),
                    ),
                  );

                } else if (item["title"] == "Exchanges") {

                  Navigator.push(

                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                      const ExchangeScreen(),
                    ),
                  );

                } 
              },

              child: Container(

                decoration: BoxDecoration(

                  color: const Color(0xFF161B22),

                  borderRadius:
                  BorderRadius.circular(25),

                  boxShadow: [

                    BoxShadow(

                      color:
                      item["color"]
                          .withOpacity(0.4),

                      blurRadius: 15,
                    ),
                  ],
                ),

                child: Column(

                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    Icon(

                      item["icon"],

                      size: 55,

                      color: item["color"],
                    ),

                    const SizedBox(height: 20),

                    Text(

                      item["title"],

                      textAlign: TextAlign.center,

                      style: const TextStyle(

                        color: Colors.white,

                        fontSize: 18,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}