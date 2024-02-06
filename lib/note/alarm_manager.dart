import 'package:flutter/material.dart';
import 'package:flutter_osmanli/note/timer_service.dart';
import 'package:flutter_osmanli/utilities/constants.dart';

class AlarmManager extends StatefulWidget {
  const AlarmManager({super.key});

  @override
  State<AlarmManager> createState() => _AlarmManagerState();
}

class _AlarmManagerState extends State<AlarmManager> {
  late TimerService _timerService;

  @override
  void initState() {
    super.initState();
    _timerService = TimerService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Center(child: Text("Pomodoro Vakti")),
        backgroundColor: const Color.fromARGB(255, 46, 204, 113),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Card(
              color: Color.fromARGB(255, 134, 236, 177),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Çalışmanızı Pomodoro Tekniği ile geliştirin. Pomodoro tekniği ile 25 dakika çalışıp 5 dakika dinlenerek çalışma odağınızı arttırın.",
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Geçen Süre:',
              style: TextStyle(fontSize: 20.0),
            ),
            StreamBuilder<int>(
              stream: _timerService.timerStream,
              builder: (context, snapshot) {
                return Text(
                  formatTime(snapshot.data ?? _timerService.elapsedMilliseconds),
                  style: const TextStyle(fontSize: 40.0),
                );
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton(
                  'Başlat',
                  () {
                    _timerService.startTimer();
                  },
                  Colors.green, 
                ),
                const SizedBox(width: 20.0),
                buildButton(
                  'Durdur',
                  () {
                    _timerService.stopTimer();
                  },
                  Colors.green, 
                ),
                const SizedBox(width: 20.0),
                buildButton(
                  'Sıfırla',
                  () {
                    _timerService.resetTimer();
                  },
                  Colors.green, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String label, VoidCallback onPressed, Color backgroundColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
      ),
      child: Text(label),
    );
  }

  String formatTime(int milliseconds) {
    int totalSeconds = (milliseconds / 1000).truncate();
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds ~/ 60) % 60;
    int hours = totalSeconds ~/ 3600;
    int tenths = (milliseconds % 1000) ~/ 10; // Saliseyi 100'e bölelim

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String tenthsStr = tenths.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr.$tenthsStr';
  }
}
