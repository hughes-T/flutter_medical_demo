import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:async';
import 'dart:math' as math;
import 'training_score_page.dart';

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
  // 视频播放器
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;
  bool _hasVideoError = false;

  // 动画控制器
  late AnimationController _animationController;
  late Animation<double> _breathAnimation;

  // 训练状态
  Timer? _trainingTimer;
  int _secondsElapsed = 0;
  bool _isTraining = false;
  int _flagsPlanted = 0;
  double _runnerPosition = 0.0;

  // 儿童呼吸素材视频URL
  static const String _videoUrl =
      'https://image.waiqin365.com/9198326415823622030/customFields/202510/202510241319855_9d964b90f1f746a4b462d7a35ed5a6ff.mp4';

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _initVideoPlayer();
    _startTraining();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _trainingTimer?.cancel();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _initAnimation() {
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

    _animationController.repeat(reverse: true);
  }

  Future<void> _initVideoPlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(_videoUrl),
      );

      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  '视频加载失败',
                  style: TextStyle(color: Colors.red[300]),
                ),
                const SizedBox(height: 8),
                Text(
                  errorMessage,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
        placeholder: Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('视频初始化错误: $e');
      if (mounted) {
        setState(() {
          _hasVideoError = true;
        });
      }
    }
  }

  void _startTraining() {
    setState(() {
      _isTraining = true;
      _secondsElapsed = 0;
    });

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
    _videoPlayerController?.pause();

    // 计算得分（这里使用简单的算法，实际应该根据真实训练数据计算）
    int score = _calculateScore();

    // 跳转到得分页面
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingScorePage(
          version: widget.version,
          trainingType: widget.trainingType,
          score: score,
          duration: _secondsElapsed,
          extraData: {
            'flagsPlanted': _flagsPlanted,
            'runnerPosition': _runnerPosition,
          },
        ),
      ),
    );
  }

  // 计算得分
  int _calculateScore() {
    // 基础分数
    int baseScore = 60;

    // 根据训练时长加分（最多20分）
    int timeBonus = math.min((_secondsElapsed ~/ 10), 20);

    // 根据训练类型的特定指标加分
    int performanceBonus = 0;
    if (widget.trainingType == '呼气训练') {
      // 根据插旗数量加分（最多20分）
      performanceBonus = math.min(_flagsPlanted * 2, 20);
    } else if (widget.trainingType == '吸气训练') {
      // 根据跑步进度加分（最多20分）
      performanceBonus = (_runnerPosition * 20).toInt();
    } else {
      // 振荡排痰根据时长加分
      performanceBonus = math.min((_secondsElapsed ~/ 15), 20);
    }

    // 总分 = 基础分 + 时长加分 + 表现加分
    int totalScore = baseScore + timeBonus + performanceBonus;

    // 限制在 0-100 之间
    return totalScore.clamp(0, 100);
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
            // 视频播放区域
            _buildVideoPlayer(),

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

  // 视频播放器组件
  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.black,
      child: _hasVideoError
          ? _buildVideoError()
          : _isVideoInitialized && _chewieController != null
              ? Chewie(controller: _chewieController!)
              : _buildVideoLoading(),
    );
  }

  Widget _buildVideoLoading() {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              '正在加载视频...',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoError() {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              '视频加载失败',
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _hasVideoError = false;
                  _isVideoInitialized = false;
                });
                _initVideoPlayer();
              },
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text('重试', style: TextStyle(color: Colors.white)),
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
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Score display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF4FC3F7).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF4FC3F7),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.flag, color: Color(0xFF4FC3F7), size: 24),
                  const SizedBox(width: 8),
                  Text(
                    '已插旗: $_flagsPlanted',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4FC3F7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Animated breath indicator
            AnimatedBuilder(
              animation: _breathAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _breathAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
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
                      size: 60,
                      color: Color(0xFF4FC3F7),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Flag visualization
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _flagsPlanted.clamp(0, 10),
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      children: [
                        Container(
                          width: 2,
                          height: 50,
                          color: Colors.brown,
                        ),
                        const Icon(
                          Icons.flag,
                          color: Color(0xFF4FC3F7),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Instruction text
            Text(
              '继续深呼气，插更多旗帜！',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Inhale training - Running animation
  Widget _buildInhaleTraining() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF66BB6A).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF66BB6A),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.directions_run,
                      color: Color(0xFF66BB6A), size: 24),
                  const SizedBox(width: 8),
                  Text(
                    '跑步中: ${(_runnerPosition * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF66BB6A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Animated breath indicator
            AnimatedBuilder(
              animation: _breathAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _breathAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
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
                      size: 60,
                      color: Color(0xFF66BB6A),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Running track
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(35),
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
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Instruction text
            Text(
              '深深地吸气，让小人跑得更快！',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Oscillation training
  Widget _buildOscillationTraining() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Training time display
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B6B).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFFF6B6B),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.vibration,
                      color: Color(0xFFFF6B6B), size: 24),
                  const SizedBox(width: 8),
                  Text(
                    '训练时长: $_formattedTime',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B6B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Animated vibration indicator
            AnimatedBuilder(
              animation: _breathAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _breathAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
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
                      size: 60,
                      color: Color(0xFFFF6B6B),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // Instruction text
            Text(
              '保持稳定的振荡呼吸节奏',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
