import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import '../models/racer.dart';
import '../utils/audio_service.dart';
import '../widgets/top_bar.dart';
import '../widgets/moving_background.dart';
import 'result_screen.dart';

class RaceScreen extends StatefulWidget {
  final List<Racer> racers;
  final int totalMoney;

  const RaceScreen({super.key, required this.racers, required this.totalMoney});

  @override
  State<RaceScreen> createState() => _RaceScreenState();
}

class _RaceScreenState extends State<RaceScreen> {
  // Trạng thái cuộc đua: 0 = Chờ, 1 = Đang giằng co (Phase 1), 2 = Rút đích (Phase 2), 3 = Đã Xong
  int racePhase = 0;
  double finishLine = 0.0;
  List<double> racerPositions = [20.0, 20.0, 20.0];

  Timer? _jostleTimer;
  int _jostleSeconds = 0;
  final int _maxJostleSeconds = 8; // Kéo dài cuộc đua bằng 8 giây giằng co

  @override
  void initState() {
    super.initState();
    final random = Random();
    for (var racer in widget.racers) {
      // Giai đoạn rút đích sẽ tốn 2 đến 4 giây (ngẫu nhiên)
      racer.timeToFinish = random.nextInt(2000) + 2000;
    }

    // Ngâm 1 giây sau đó bước vào Phase 1 (Giằng co)
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        _startPhase1();
      }
    });

    // Play looped race background while the race screen is active.
    AudioService.instance.playLoopingSound('race_rev.wav', volume: 0.35);
  }

  void _startPhase1() {
    setState(() {
      racePhase = 1;
    });

    final random = Random();

    // Cứ mỗi 1 giây lại random vị trí 3 chiếc xe để tạo cảm giác tranh giành
    _jostleTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      _jostleSeconds++;

      if (_jostleSeconds >= _maxJostleSeconds) {
        _jostleTimer?.cancel();
        _startPhase2();
      } else {
        setState(() {
          // Các xe nhấp nhô từ đáy lên khoảng tối đa 150px
          racerPositions = [
            20.0 + random.nextInt(150),
            20.0 + random.nextInt(150),
            20.0 + random.nextInt(150),
          ];
        });
      }
    });
  }

  void _startPhase2() {
    setState(() {
      racePhase = 2;
      // Kéo tất cả lao thẳng lên vạch đích
      racerPositions = [finishLine, finishLine, finishLine];
    });

    // Tính xem xe nào đến đích nhanh nhất
    int minTime = widget.racers.map((r) => r.timeToFinish).reduce(min);

    // Sau khi chiếc xe nhanh nhất cán đích, dừng nền cuộn
    Future.delayed(Duration(milliseconds: minTime), () async {
      if (mounted) {
        setState(() {
          racePhase = 3;
        });

        AudioService.instance.stopBgm();

        final winner = widget.racers.reduce(
          (a, b) => a.timeToFinish <= b.timeToFinish ? a : b,
        );

        final newBalance = await Navigator.push<int>(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              racers: widget.racers,
              totalMoney: widget.totalMoney,
              winner: winner,
            ),
          ),
        );

        if (mounted && newBalance != null) {
          Navigator.pop(context, newBalance);
        }
      }
    });
  }

  @override
  void dispose() {
    _jostleTimer?.cancel();
    AudioService.instance.stopBgm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final trackHeight = size.height - (MediaQuery.of(context).padding.top + 60);
    finishLine = trackHeight - 120; // Trừ khoảng hở trên cùng

    return Scaffold(
      body: MovingBackground(
        // Nền chỉ cuộn khi cuộc đua đang diễn ra ở Phase 1 hoặc Phase 2
        isMoving: racePhase == 1 || racePhase == 2,
        child: Column(
          children: [
            TopBar(totalMoney: widget.totalMoney),
            Expanded(
              child: Stack(
                children: [
                  // Vạch đích sọc ca rô trắng đen (vẽ trước để nằm dưới xe)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: finishLine + 55, // Căn ngay mép đầu xe khi cán đích
                    height: 40, // Chiều cao vạch đích
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: List.generate(
                              24,
                              (i) => Expanded(
                                child: Container(
                                  color: i % 2 == 0
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: List.generate(
                              24,
                              (i) => Expanded(
                                child: Container(
                                  color: i % 2 == 0
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: List.generate(widget.racers.length, (index) {
                      final racer = widget.racers[index];

                      // Tính Duration (thời gian diễn ra animation của xe)
                      int currentDuration = 0;
                      if (racePhase == 1) {
                        currentDuration =
                            1000; // Mỗi giây một lần cập nhật giằng co
                      } else if (racePhase == 2) {
                        currentDuration =
                            racer.timeToFinish; // Chạy hết tốc lực lúc rút đích
                      }

                      return Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (index > 0)
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  width: 3,
                                  color: Colors.cyanAccent.withOpacity(0.3),
                                ),
                              ),

                            AnimatedPositioned(
                              duration: Duration(milliseconds: currentDuration),
                              curve: Curves.easeInOut,
                              bottom: racerPositions[index],
                              child: Image.asset(
                                racer.assetPath,
                                width: 60,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
