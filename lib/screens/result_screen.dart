import 'package:flutter/material.dart';

import '../models/racer.dart';
import '../widgets/top_bar.dart';
import '../widgets/sfx_button.dart';
import '../utils/audio_service.dart';

class ResultScreen extends StatefulWidget {
  final List<Racer> racers;
  final int totalMoney;
  final Racer winner;

  const ResultScreen({
    super.key,
    required this.racers,
    required this.totalMoney,
    required this.winner,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Racer> get racers => widget.racers;
  Racer get winner => widget.winner;
  int get totalMoney => widget.totalMoney;

  @override
  void initState() {
    super.initState();
    AudioService.instance.startBgmLoop();
  }

  int _moneyChangeOf(Racer racer) {
    if (racer.id == winner.id) {
      return racer.betAmount;
    }

    return -racer.betAmount;
  }

  int get _totalChange {
    int totalChange = 0;

    for (final racer in racers) {
      totalChange += _moneyChangeOf(racer);
    }

    return totalChange;
  }

  int get _newBalance => totalMoney + _totalChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F1F1),
      body: Column(
        children: [
          TopBar(totalMoney: _newBalance),
          Container(height: 3, color: const Color(0xff3B1F1F)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWinnerCard(),
                  const SizedBox(height: 12),
                  const Text(
                    'RACE SUMMARY',
                    style: TextStyle(
                      color: Color(0xff3B1F1F),
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...racers.map(_buildSummaryRow),
                  const SizedBox(height: 14),
                  _buildFinalResultCard(),
                  const SizedBox(height: 14),
                  _buildPlayAgainButton(context),
                  const SizedBox(height: 10),
                  _buildBackHomeButton(context),
                ],
              ),
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildWinnerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xffFFF1F1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff3B1F1F), width: 4),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xffFFE475),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xff3B1F1F), width: 3),
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Color(0xff3B1F1F),
              size: 46,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'WINNER: ${winner.name.toUpperCase()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xffC51D1D),
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Victory at the finish line! The race results are in.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff5B3B3B),
              fontSize: 13,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(Racer racer) {
    final bool isWinner = racer.id == winner.id;
    final int moneyChange = _moneyChangeOf(racer);
    final Color borderColor = isWinner
        ? const Color(0xffFFD600)
        : moneyChange < 0
        ? const Color(0xffC51D1D)
        : const Color(0xffE0B4B4);
    final Color backgroundColor = isWinner
        ? const Color(0xff5C3535)
        : moneyChange < 0
        ? const Color(0xff5B7075)
        : const Color(0xffF8E5E5);
    final Color textColor = isWinner || moneyChange < 0
        ? Colors.white
        : const Color(0xff3B1F1F);
    final String resultText = moneyChange == 0
        ? '-'
        : moneyChange > 0
        ? '+\$$moneyChange'
        : '-\$${moneyChange.abs()}';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 3),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 38,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Image.asset(racer.assetPath, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  racer.name.toUpperCase(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Bet: \$${racer.betAmount}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isWinner
                    ? 'WIN'
                    : racer.betAmount > 0
                    ? 'LOST'
                    : '',
                style: TextStyle(
                  color: isWinner
                      ? const Color(0xffFFD600)
                      : moneyChange < 0
                      ? Colors.white
                      : const Color(0xff8A6A6A),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                resultText,
                style: TextStyle(
                  color: isWinner
                      ? const Color(0xffFFD600)
                      : moneyChange < 0
                      ? Colors.white
                      : const Color(0xff8A6A6A),
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          if (isWinner) ...[
            const SizedBox(width: 6),
            const Icon(Icons.flag, color: Colors.white, size: 22),
          ],
        ],
      ),
    );
  }

  Widget _buildFinalResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffC51D1D),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xff7A1010), width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FINAL RESULT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'New Balance:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Text(
                '\$$_newBalance',
                style: const TextStyle(
                  color: Color(0xffFFD54F),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffFFD54F),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayAgainButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: SfxElevatedButton(
        onPressed: () {
          Navigator.pop(context, _newBalance);
          AudioService.instance.playSfx('click.wav', volume: 0.6);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffC51D1D),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          'PLAY AGAIN',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildBackHomeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: SfxOutlinedButton(
        onPressed: () {
          Navigator.pop(context, _newBalance);
          AudioService.instance.playSfx('click.wav', volume: 0.6);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.home, size: 18),
            SizedBox(width: 8),
            Text(
              'BACK TO HOME',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xff3B1F1F),
          side: const BorderSide(color: Color(0xff3B1F1F), width: 3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xffFFE6E6),
        border: Border(top: BorderSide(color: Color(0xff3B1F1F), width: 2)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavItem(icon: Icons.garage, label: 'GARAGE'),
          _BottomNavItem(icon: Icons.sports_motorsports, label: 'RACE'),
          _BottomNavItem(
            icon: Icons.bar_chart,
            label: 'HISTORY',
            isSelected: true,
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? Colors.white : const Color(0xffC51D1D);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffC51D1D) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
