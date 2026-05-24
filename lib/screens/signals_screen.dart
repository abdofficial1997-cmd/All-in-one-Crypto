import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SignalsScreen extends StatefulWidget {
  const SignalsScreen({super.key});

  @override
  State<SignalsScreen> createState() =>
      _SignalsScreenState();
}

class _SignalsScreenState
    extends State<SignalsScreen> {

  List<Map<String, dynamic>> signals = [];

  final List<Map<String, dynamic>> coins = [

  {
    "coin": "BTC",
    "price": 109000,
  },

  {
    "coin": "ETH",
    "price": 2600,
  },

  {
    "coin": "SOL",
    "price": 180,
  },

  {
    "coin": "XRP",
    "price": 2.3,
  },

  {
    "coin": "DOGE",
    "price": 0.22,
  },

  {
    "coin": "BNB",
    "price": 680,
  },

  {
    "coin": "PEPE",
    "price": 0.000012,
  },

  {
    "coin": "ADA",
    "price": 0.75,
  },

  {
    "coin": "AVAX",
    "price": 38,
  },

  {
    "coin": "LINK",
    "price": 17,
  },
];

  final random = Random();

  Timer? timer;

  @override
  void initState() {
    super.initState();

    generateSignals();

    timer = Timer.periodic(

      const Duration(seconds: 30),

          (timer) {

        generateSignals();
      },
    );
  }

  void generateSignals() {

    List<Map<String, dynamic>> newSignals = [];

    for (int i = 0; i < 6; i++) {

      bool isBuy =
          random.nextBool();

    final selectedCoin =
coins[random.nextInt(coins.length)];

double entry =
(selectedCoin["price"] as num)
    .toDouble();
    double movePercent =
(random.nextDouble() * 3) + 1;

double target =
isBuy
? entry + (entry * movePercent / 100)
: entry - (entry * movePercent / 100);

double stoploss =
isBuy
? entry - (entry * 1 / 100)
: entry + (entry * 1 / 100);

      int confidence =
          70 + random.nextInt(30);

      newSignals.add({

       "coin":
selectedCoin["coin"],

        "type":
        isBuy ? "BUY" : "SELL",

        "entry":
        entry.toStringAsFixed(2),

        "target":
        target.toStringAsFixed(2),

        "sl":
        stoploss.toStringAsFixed(2),

        "confidence":
        confidence,
      });
    }

    setState(() {

      signals = newSignals;

    });
  }

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFF0D1117),

      appBar: AppBar(

        backgroundColor: Colors.black,

        centerTitle: true,

        title:
        const Text("Signals"),
      ),

      body: ListView.builder(

        itemCount: signals.length,

        itemBuilder: (context, index) {

          final signal =
          signals[index];

          final isBuy =
              signal["type"] == "BUY";

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
              BorderRadius.circular(22),

              boxShadow: [

                BoxShadow(

                  color: isBuy
                      ? Colors.greenAccent
                      .withOpacity(0.3)
                      : Colors.redAccent
                      .withOpacity(0.3),

                  blurRadius: 15,
                ),
              ],
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    Text(

                      "${signal["type"]} ${signal["coin"]}",

                      style: TextStyle(

                        color: isBuy
                            ? Colors.greenAccent
                            : Colors.redAccent,

                        fontSize: 24,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    Container(

                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.black,

                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      child: Text(

                        "${signal["confidence"]}%",

                        style:
                        const TextStyle(

                          color:
                          Colors.white,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                infoRow(
                  "Entry",
                  signal["entry"],
                ),

                infoRow(
                  "Target",
                  signal["target"],
                ),

                infoRow(
                  "Stop Loss",
                  signal["sl"],
                ),

                const SizedBox(height: 12),

                Text(

                  "ABD Voice Signal",

                  style: TextStyle(

                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget infoRow(
      String title,
      String value,
      ) {

    return Padding(

      padding:
      const EdgeInsets.only(bottom: 10),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(

            title,

            style:
            const TextStyle(

              color: Colors.white70,

              fontSize: 16,
            ),
          ),

          Text(

            value,

            style:
            const TextStyle(

              color: Colors.white,

              fontWeight:
              FontWeight.bold,

              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
