class Racer {
  final int id;
  final String name;
  final String assetPath;
  int betAmount;
  int timeToFinish; // Tính bằng milli-giây (milliseconds)

  Racer({
    required this.id,
    required this.name,
    required this.assetPath,
    this.betAmount = 0,
    this.timeToFinish = 0,
  });
}
