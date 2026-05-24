import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CryptoniansScreen extends StatefulWidget {
  const CryptoniansScreen({super.key});

  @override
  State<CryptoniansScreen> createState() =>
      _CryptoniansScreenState();
}

class _CryptoniansScreenState
    extends State<CryptoniansScreen> {

  List coins = [];

  List filteredCoins = [];

  Timer? timer;

  @override
  void initState() {
    super.initState();

    fetchCoins();

    timer = Timer.periodic(
      const Duration(seconds: 5),
          (timer) {
        fetchCoins();
      },
    );
  }

  Future openBinance(String symbol) async {

    final url =
        'https://www.binance.com/en/trade/${symbol.toUpperCase()}_USDT';

    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  void searchCoin(String value) {

    setState(() {

      filteredCoins = coins.where((coin) {

        final name =
        coin['name']
            .toString()
            .toLowerCase();

        final symbol =
        coin['symbol']
            .toString()
            .toLowerCase();

        final search =
        value.toLowerCase();

        return name.contains(search)
            || symbol.contains(search);

      }).toList();
    });
  }

  Future fetchCoins() async {

    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=price_change_percentage_24h_desc&per_page=100&page=1&sparkline=false';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {

      setState(() {

        coins = json.decode(response.body);

        filteredCoins = coins;

      });
    }
  }

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0D1117),

      appBar: AppBar(
        title: const Text("Cryptonians"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      body: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(12),

            child: TextField(

              onChanged: searchCoin,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(

                hintText: "Search Coin...",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),

                prefixIcon:
                const Icon(
                  Icons.search,
                  color: Colors.white,
                ),

                filled: true,

                fillColor:
                const Color(0xFF161B22),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(20),

                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(

            child: filteredCoins.isEmpty

                ? const Center(
              child: CircularProgressIndicator(),
            )

                : ListView.builder(

              itemCount: filteredCoins.length,

              itemBuilder: (context, index) {

                final coin = filteredCoins[index];

                final priceChange =
                    coin['price_change_percentage_24h'] ?? 0;

                final isGreen =
                    priceChange >= 0;

                return GestureDetector(

                  onTap: () {

                    openBinance(
                      coin['symbol'],
                    );
                  },

                  child: Container(

                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(

                      color: const Color(0xFF161B22),

                      borderRadius:
                      BorderRadius.circular(20),

                      boxShadow: [

                        BoxShadow(
                          color: isGreen
                              ? Colors.greenAccent
                              .withOpacity(0.2)
                              : Colors.redAccent
                              .withOpacity(0.2),

                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: Row(

                      children: [

                        CircleAvatar(
                          backgroundImage:
                          NetworkImage(
                            coin['image'],
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                coin['name'],

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              Text(
                                coin['symbol']
                                    .toUpperCase(),

                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.end,

                          children: [

                            Text(
                              '\$${coin['current_price']}',

                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            Text(
                              '${priceChange.toStringAsFixed(2)}%',

                              style: TextStyle(
                                color: isGreen
                                    ? Colors.greenAccent
                                    : Colors.redAccent,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            Text(
                              'MC: \$${coin['market_cap']}',

                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}