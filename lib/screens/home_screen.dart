import 'package:flutter/material.dart';
import '../models/racer.dart';
import 'howToPlay_screen.dart';
import 'race_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalMoney = 1000;

  List<Racer> racers = [
    Racer(id: 1, name: 'Red Mustang', assetPath: 'assets/images/xe1.png'),
    Racer(id: 2, name: 'Yellow Formula', assetPath: 'assets/images/xe2.png'),
    Racer(id: 3, name: 'Green Porsche', assetPath: 'assets/images/xe3.png'),
  ];

  void _increaseBet(Racer racer) {
    setState(() {
      racer.betAmount += 10;
    });
  }

  void _decreaseBet(Racer racer) {
    if (racer.betAmount >= 10) {
      setState(() {
        racer.betAmount -= 10;
      });
    }
  }

  int get _totalBet {
    return racers.fold(0, (sum, item) => sum + item.betAmount);
  }

  void _startRace() {
    int currentTotalBet = _totalBet;

    if (currentTotalBet == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đặt cược trước khi đua!')),
      );
      return;
    }

    if (currentTotalBet > totalMoney) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tổng cược không được vượt quá số tiền hiện có!'),
        ),
      );
      return;
    }

    // Chuyển sang màn hình đua, truyền danh sách xe và tổng tiền sang
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RaceScreen(racers: racers, totalMoney: totalMoney),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PRO RACER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'How to play',
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HowToPlayScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Ô hiển thị tổng tiền
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      size: 28,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'TOTAL MONEY: \$$totalMoney',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Danh sách 3 xe để cá cược
              Expanded(
                child: ListView.builder(
                  itemCount: racers.length,
                  itemBuilder: (context, index) {
                    final racer = racers[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Image.asset(
                              racer.assetPath,
                              width: 80,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                racer.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Ô nhập/chọn tiền cược
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => _decreaseBet(racer),
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    '\$${racer.betAmount}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _increaseBet(racer),
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
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

              // Khu vực tổng cược và Nút Start
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    Text(
                      'Total Bet: \$$_totalBet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _totalBet > totalMoney
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _startRace,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'START RACE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), // Close the Container
    );
  }
}
