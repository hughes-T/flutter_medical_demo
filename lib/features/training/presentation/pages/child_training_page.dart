import 'package:flutter/material.dart';
import 'dart:async';

class ChildTrainingPage extends StatefulWidget {
  final String version;
  final String trainingType;

  const ChildTrainingPage({
    super.key,
    required this.version,
    required this.trainingType,
  });

  @override
  State<ChildTrainingPage> createState() => _ChildTrainingPageState();
}

class _ChildTrainingPageState extends State<ChildTrainingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _breathAnimation;
  Timer? _trainingTimer;
  int _secondsElapsed = 0;
  bool _isTraining = false;
  int _flagsPlanted = 0;
  double _runnerPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _breathAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _startTraining();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _trainingTimer?.cancel();
    super.dispose();
  }

  void _startTraining() {
    setState(() {
      _isTraining = true;
      _secondsElapsed = 0;
    });

    // Start breathing animation
    _animationController.repeat(reverse: true);

    // Start training timer
    _trainingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _secondsElapsed++;

        // Simulate flag planting for exhale training
        if (widget.trainingType == '呼气训练' && _secondsElapsed % 5 == 0) {
          _flagsPlanted++;
        }

        // Simulate runner movement for inhale training
        if (widget.trainingType == '吸气训练') {
          _runnerPosition = (_secondsElapsed % 10) / 10.0;
        }
      });
    });
  }

  void _endTraining() {
    _trainingTimer?.cancel();
    _animationController.stop();
    Navigator.pop(context);
  }

  String get _formattedTime {
    final minutes = _secondsElapsed ~/ 60;
    final seconds = _secondsElapsed % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Color get _primaryColor {
    if (widget.trainingType == '呼气训练') return const Color(0xFF4FC3F7);
    if (widget.trainingType == '吸气训练') return const Color(0xFF66BB6A);
    return const Color(0xFFFF6B6B);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(widget.trainingType),
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        actions: [
          // Timer display
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                _formattedTime,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Voice guidance prompt
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: _primaryColor.withValues(alpha: 0.1),
              child: Row(
                children: [
                  Icon(Icons.volume_up, color: _primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getVoiceGuidance(),
                      style: TextStyle(
                        color: _primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Training content area
            Expanded(
              child: widget.trainingType == '呼气训练'
                  ? _buildExhaleTraining()
                  : widget.trainingType == '吸气训练'
                      ? _buildInhaleTraining()
                      : _buildOscillationTraining(),
            ),

            // End training button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _endTraining,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    '结束训练',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getVoiceGuidance() {
    if (widget.trainingType == '呼气训练') {
      return '深深地呼气，看看能插多少面旗帜！';
    } else if (widget.trainingType == '吸气训练') {
      return '深深地吸气，帮助小人跑得更快！';
    } else {
      return '保持稳定的呼吸节奏，进行振荡排痰训练。';
    }
  }

  // Exhale training - Flag planting game
  Widget _buildExhaleTraining() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Score display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF4FC3F7).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF4FC3F7),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.flag, color: Color(0xFF4FC3F7), size: 28),
                const SizedBox(width: 8),
                Text(
                  '已插旗: $_flagsPlanted',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4FC3F7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Animated breath indicator
          AnimatedBuilder(
            animation: _breathAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _breathAnimation.value,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4FC3F7).withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4FC3F7),
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.air,
                    size: 80,
                    color: Color(0xFF4FC3F7),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Flag visualization
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _flagsPlanted.clamp(0, 10),
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Container(
                        width: 3,
                        height: 60,
                        color: Colors.brown,
                      ),
                      const Icon(
                        Icons.flag,
                        color: Color(0xFF4FC3F7),
                        size: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Instruction text
          Text(
            '继续深呼气，插更多旗帜！',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Inhale training - Running animation
  Widget _buildInhaleTraining() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Progress display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF66BB6A).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF66BB6A),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.directions_run, color: Color(0xFF66BB6A), size: 28),
                const SizedBox(width: 8),
                Text(
                  '跑步中: ${(_runnerPosition * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF66BB6A),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Animated breath indicator
          AnimatedBuilder(
            animation: _breathAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _breathAnimation.value,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF66BB6A).withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF66BB6A),
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    size: 80,
                    color: Color(0xFF66BB6A),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 48),

          // Running track
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              children: [
                // Track lines
                Center(
                  child: Container(
                    height: 2,
                    color: Colors.grey[400],
                  ),
                ),
                // Runner
                Align(
                  alignment: Alignment(_runnerPosition * 2 - 1, 0),
                  child: const Icon(
                    Icons.directions_run,
                    color: Color(0xFF66BB6A),
                    size: 48,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Instruction text
          Text(
            '深深地吸气，让小人跑得更快！',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Oscillation training
  Widget _buildOscillationTraining() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Training time display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFFF6B6B),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.vibration, color: Color(0xFFFF6B6B), size: 28),
                const SizedBox(width: 8),
                Text(
                  '训练时长: $_formattedTime',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6B6B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Animated vibration indicator
          AnimatedBuilder(
            animation: _breathAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _breathAnimation.value,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B6B).withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF6B6B),
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.vibration,
                    size: 80,
                    color: Color(0xFFFF6B6B),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 48),

          // Instruction text
          Text(
            '保持稳定的振荡呼吸节奏',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}