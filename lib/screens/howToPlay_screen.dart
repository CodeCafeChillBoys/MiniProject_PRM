import 'package:flutter/material.dart';
import 'package:miniproject/widgets/buildHeader.dart';
import 'package:miniproject/widgets/step_card.dart';

class HowToPlayScreen extends StatelessWidget {
  final int totalMoney;

  const HowToPlayScreen({super.key, required this.totalMoney});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F1F1),

      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            buildHeader(
              totalMoney: totalMoney,
              onClosePressed: () {
                Navigator.pop(context);
              },
            ),

            /// line
            Container(height: 3, color: const Color(0xff3B1F1F)),

            /// BODY
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    /// TITLE
                    const Text(
                      "HOW TO PLAY",
                      style: TextStyle(
                        color: Color(0xffC51D1D),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Master the track and build your racing empire. "
                      "Follow these three simple steps to start your high-speed career.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff5B3B3B),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// STEP CARD
                    StepCard(
                      step: "STEP 01",
                      title: "PLACE YOUR BETS",
                      description:
                          "Analyze the race starts and use your currency in currency pool to select your winners. Adjust stakes with the precision control.",
                      color: const Color(0xffFFE6E6),
                      icon: Icons.wallet,
                    ),

                    StepCard(
                      step: "STEP 02",
                      title: "WATCH THE RACE",
                      description:
                          "Hit START and witness the high-stakes action on the track. Keep an eye on the tachometer gauges as racers fight for lead.",
                      color: const Color(0xffE6ECFF),
                      icon: Icons.speed,
                    ),

                    StepCard(
                      step: "STEP 03",
                      title: "COLLECT WINNINGS",
                      description:
                          "Successful bets are rewarded instantly in Trophy Gold. Use your winnings to enter higher-stakes tournaments!",
                      color: const Color(0xffFFF1CC),
                      icon: Icons.emoji_events,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
