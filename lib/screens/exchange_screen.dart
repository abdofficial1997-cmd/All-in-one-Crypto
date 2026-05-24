import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> exchanges = [

      {
        "name": "Binance",
        "url": "https://www.binance.com",
        "color": Colors.yellow,
      },

      {
        "name": "MEXC",
        "url": "https://www.mexc.com",
        "color": Colors.green,
      },

      {
        "name": "Bybit",
        "url": "https://www.bybit.com",
        "color": Colors.orange,
      },

      {
        "name": "KuCoin",
        "url": "https://www.kucoin.com",
        "color": Colors.teal,
      },

      {
        "name": "OKX",
        "url": "https://www.okx.com",
        "color": Colors.white,
      },

      {
        "name": "Gate.io",
        "url": "https://www.gate.io",
        "color": Colors.cyan,
      },

      {
        "name": "Bitget",
        "url": "https://www.bitget.com",
        "color": Colors.blue,
      },

      {
        "name": "HTX",
        "url": "https://www.htx.com",
        "color": Colors.red,
      },
    ];

    return Scaffold(

      backgroundColor:
      const Color(0xFF0D1117),

      appBar: AppBar(

        backgroundColor: Colors.black,

        centerTitle: true,

        title:
        const Text("Exchanges"),
      ),

      body: ListView.builder(

        itemCount: exchanges.length,

        itemBuilder: (context, index) {

          final exchange =
          exchanges[index];

          return Container(

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
                  exchange["color"]
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
                  exchange["color"],

                  child: Text(

                    exchange["name"][0],

                    style: const TextStyle(

                      color: Colors.black,

                      fontWeight:
                      FontWeight.bold,

                      fontSize: 24,
                    ),
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(

                  child: Text(

                    exchange["name"],

                    style:
                    const TextStyle(

                      color: Colors.white,

                      fontSize: 18,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                ElevatedButton(

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    exchange["color"],
                  ),

                  onPressed: () async {

                    await launchUrl(

                      Uri.parse(
                        exchange["url"],
                      ),

                      mode:
                      LaunchMode.externalApplication,
                    );
                  },

                  child: const Text(

                    "Trade Now",

                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}