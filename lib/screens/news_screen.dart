import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> newsSites = [

      {
        "name": "CoinMarketCap",
        "url": "https://coinmarketcap.com/community/",
        "icon": Icons.currency_bitcoin,
        "color": Colors.orange,
      },

      {
        "name": "CoinDesk",
        "url": "https://www.coindesk.com/",
        "icon": Icons.newspaper,
        "color": Colors.blue,
      },

      {
        "name": "CoinTelegraph",
        "url": "https://cointelegraph.com/",
        "icon": Icons.language,
        "color": Colors.amber,
      },

      {
        "name": "Decrypt",
        "url": "https://decrypt.co/",
        "icon": Icons.lock,
        "color": Colors.green,
      },

      {
        "name": "CryptoSlate",
        "url": "https://cryptoslate.com/",
        "icon": Icons.trending_up,
        "color": Colors.purple,
      },

      {
        "name": "Binance News",
        "url": "https://www.binance.com/en/news",
        "icon": Icons.account_balance,
        "color": Colors.yellow,
      },
    ];

    return Scaffold(

      backgroundColor:
      const Color(0xFF0D1117),

      appBar: AppBar(

        backgroundColor: Colors.black,

        centerTitle: true,

        title:
        const Text("Crypto News"),
      ),

      body: ListView.builder(

        itemCount: newsSites.length,

        itemBuilder: (context, index) {

          final news = newsSites[index];

          return GestureDetector(

            onTap: () async {

              await launchUrl(
                Uri.parse(news["url"]),
                mode:
                LaunchMode.externalApplication,
              );
            },

            child: Container(

              margin:
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              padding:
              const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color:
                const Color(0xFF161B22),

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color:
                    news["color"]
                        .withOpacity(0.3),

                    blurRadius: 12,
                  ),
                ],
              ),

              child: Row(

                children: [

                  CircleAvatar(

                    radius: 28,

                    backgroundColor:
                    news["color"],

                    child: Icon(

                      news["icon"],

                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(

                    child: Text(

                      news["name"],

                      style:
                      const TextStyle(

                        color: Colors.white,

                        fontSize: 18,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  const Icon(

                    Icons.open_in_new,

                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}