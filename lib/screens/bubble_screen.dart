import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class BubbleScreen extends StatefulWidget {
  const BubbleScreen({super.key});

  @override
  State<BubbleScreen> createState() => _BubbleScreenState();
}

class _BubbleScreenState extends State<BubbleScreen> {
  List coins = [];

  @override
  void initState() {
    super.initState();
    fetchCoins();
  }

  Future fetchCoins() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=price_change_percentage_24h_desc&per_page=50&page=1&sparkline=false';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        coins = json.decode(response.body);
      });
    }
  }

  Future openTwitter(String coin) async {
    final url = 'https://twitter.com/search?q=$coin';

    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Bubble Map"),
      ),

      body: coins.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )

          : SingleChildScrollView(
              padding: const EdgeInsets.all(10),

              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,

                children: coins.map((coin) {

                  final change =
                      (coin['price_change_percentage_24h'] ?? 0)
                          .toDouble();

                  final isGreen = change >= 0;

                  double size =
                      (70 + (change.abs() * 2)).toDouble();

                  // MAX SIZE
                  if (size > 170) {
                    size = 170;
                  }

                  // MIN SIZE
                  if (size < 90) {
                    size = 90;
                  }

                  return TweenAnimationBuilder<double>(

                    tween: Tween<double>(
                      begin: 0.8,
                      end: 1,
                    ),

                    duration: const Duration(seconds: 2),

                    curve: Curves.easeInOut,

                    builder: (context, value, child) {

                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },

                    child: GestureDetector(

                      onTap: () {
                        openTwitter(coin['name']);
                      },

                      child: Container(

                        width: size,
                        height: size,

                        clipBehavior: Clip.hardEdge,

                        decoration: BoxDecoration(

                          shape: BoxShape.circle,

                          color: isGreen
                              ? Colors.greenAccent.withOpacity(0.20)
                              : Colors.redAccent.withOpacity(0.20),

                          border: Border.all(
                            color: isGreen
                                ? Colors.greenAccent
                                : Colors.redAccent,
                            width: 2,
                          ),

                          boxShadow: [

                            BoxShadow(
                              color: isGreen
                                  ? Colors.greenAccent.withOpacity(0.4)
                                  : Colors.redAccent.withOpacity(0.4),

                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),

                        child: Center(

                          child: Padding(
                            padding: const EdgeInsets.all(6),

                            child: FittedBox(

                              fit: BoxFit.scaleDown,

                              child: Column(

                                mainAxisSize: MainAxisSize.min,

                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [

                                  CircleAvatar(

                                    backgroundColor: Colors.transparent,

                                    backgroundImage:
                                        NetworkImage(
                                      coin['image'],
                                    ),

                                    radius: size / 7,
                                  ),

                                  const SizedBox(height: 6),

                                  SizedBox(

                                    width: size * 0.7,

                                    child: Text(

                                      coin['symbol']
                                          .toString()
                                          .toUpperCase(),

                                      maxLines: 1,

                                      overflow:
                                          TextOverflow.ellipsis,

                                      textAlign:
                                          TextAlign.center,

                                      style:
                                          const TextStyle(

                                        color: Colors.white,

                                        fontWeight:
                                            FontWeight.bold,

                                        fontSize: 11,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 2),

                                  SizedBox(

                                    width: size * 0.7,

                                    child: Text(

                                      '${change.toStringAsFixed(1)}%',

                                      maxLines: 1,

                                      overflow:
                                          TextOverflow.ellipsis,

                                      textAlign:
                                          TextAlign.center,

                                      style: TextStyle(

                                        color: isGreen
                                            ? Colors.greenAccent
                                            : Colors.redAccent,

                                        fontWeight:
                                            FontWeight.bold,

                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}