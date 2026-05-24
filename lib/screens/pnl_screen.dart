import 'package:flutter/material.dart';

class PnlScreen extends StatefulWidget {
  const PnlScreen({super.key});

  @override
  State<PnlScreen> createState() => _PnlScreenState();
}

class _PnlScreenState extends State<PnlScreen> {

  final amountController =
  TextEditingController();

  final entryController =
  TextEditingController();

  final exitController =
  TextEditingController();

  int leverage = 1;

  bool isLong = true;

  void calculatePNL() {

    final amount =
        double.tryParse(
            amountController.text) ?? 0;

    final entry =
        double.tryParse(
            entryController.text) ?? 0;

    final exit =
        double.tryParse(
            exitController.text) ?? 0;

    if (entry == 0 || exit == 0) return;

    double pnlPercent;

    if (isLong) {

      pnlPercent =
          ((exit - entry) / entry) * 100;

    } else {

      pnlPercent =
          ((entry - exit) / entry) * 100;
    }

    final leveragedPercent =
        pnlPercent * leverage;

    final profitUsd =
        (amount * leveragedPercent) / 100;

    final isProfit =
        profitUsd >= 0;

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          backgroundColor: Colors.black,

          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20),
          ),

          title: Text(

            isProfit
                ? "PROFIT"
                : "LOSS",

            style: TextStyle(
              color: isProfit
                  ? Colors.greenAccent
                  : Colors.redAccent,
            ),
          ),

          content: Column(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              Text(

                '${leveragedPercent.toStringAsFixed(2)}%',

                style: TextStyle(
                  color: isProfit
                      ? Colors.greenAccent
                      : Colors.redAccent,

                  fontSize: 28,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(

                '\$${profitUsd.toStringAsFixed(2)}',

                style: TextStyle(
                  color: isProfit
                      ? Colors.greenAccent
                      : Colors.redAccent,

                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 20),

              const Text(

                "ABD Voice Calculation",

                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFF0D1117),

      appBar: AppBar(

        backgroundColor: Colors.black,

        title:
        const Text("PNL Calculator"),

        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Row(

              children: [

                Expanded(

                  child: ElevatedButton(

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      isLong
                          ? Colors.green
                          : Colors.grey,
                    ),

                    onPressed: () {

                      setState(() {

                        isLong = true;
                      });
                    },

                    child:
                    const Text("LONG"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(

                  child: ElevatedButton(

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      !isLong
                          ? Colors.red
                          : Colors.grey,
                    ),

                    onPressed: () {

                      setState(() {

                        isLong = false;
                      });
                    },

                    child:
                    const Text("SHORT"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<int>(

              value: leverage,

              dropdownColor:
              Colors.black,

              decoration:
              inputDecoration(
                "Select Leverage",
              ),

              items: List.generate(

                100,

                    (index) {

                  final value =
                      index + 1;

                  return DropdownMenuItem(

                    value: value,

                    child:
                    Text(
                      "${value}x",
                    ),
                  );
                },
              ),

              onChanged: (value) {

                setState(() {

                  leverage =
                      value!;
                });
              },
            ),

            const SizedBox(height: 20),

            customField(
              amountController,
              "Trade Amount",
            ),

            const SizedBox(height: 20),

            customField(
              entryController,
              "Entry Price",
            ),

            const SizedBox(height: 20),

            customField(
              exitController,
              "Exit Price",
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              height: 55,

              child: ElevatedButton(

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.greenAccent,
                ),

                onPressed: calculatePNL,

                child: const Text(

                  "CALCULATE",

                  style: TextStyle(
                    color: Colors.black,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customField(
      TextEditingController controller,
      String hint,
      ) {

    return TextField(

      controller: controller,

      keyboardType:
      TextInputType.number,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration:
      inputDecoration(hint),
    );
  }

  InputDecoration inputDecoration(
      String hint,
      ) {

    return InputDecoration(

      hintText: hint,

      hintStyle:
      const TextStyle(
        color: Colors.grey,
      ),

      filled: true,

      fillColor:
      const Color(0xFF161B22),

      border: OutlineInputBorder(

        borderRadius:
        BorderRadius.circular(20),

        borderSide: BorderSide.none,
      ),
    );
  }
}