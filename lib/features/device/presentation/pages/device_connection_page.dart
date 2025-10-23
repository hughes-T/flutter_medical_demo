import 'package:flutter/material.dart';
import '../../../../app/routes.dart';

class DeviceConnectionPage extends StatefulWidget {
  const DeviceConnectionPage({super.key});

  @override
  State<DeviceConnectionPage> createState() => _DeviceConnectionPageState();
}

class _DeviceConnectionPageState extends State<DeviceConnectionPage> {
  bool _isSearching = false;
  List<String> _devices = [];

  Future<void> _startSearch() async {
    setState(() {
      _isSearching = true;
      _devices = [];
    });

    // 模拟搜索设备
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _devices = [
        'UD MED 设备 001',
        'UD MED 设备 002',
      ];
      _isSearching = false;
    });
  }

  void _connectDevice(String deviceName) async {
    // 模拟连接设备
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.pop(context);

    // 连接成功，跳转到下一页
    Navigator.pushReplacementNamed(context, AppRoutes.versionSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('设备连接'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // 提示文字
              Text(
                '提示框:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                '打开你的蓝牙，进行设备连接',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 搜索中提示
              if (_isSearching)
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      '搜索中（设计加载圆标）',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )
              else
                const SizedBox.shrink(),

              const SizedBox(height: 40),

              // 搜索到的设备列表
              if (_devices.isNotEmpty) ...[
                Text(
                  '搜索到以下设备',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    itemCount: _devices.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(Icons.bluetooth),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('设备图片'),
                              Text(_devices[index]),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '设备名称编号',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => _connectDevice(_devices[index]),
                                child: const Text('连接'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ] else if (!_isSearching)
                const Expanded(
                  child: Center(
                    child: Text('点击下方按钮开始搜索设备'),
                  ),
                ),

              // 开始搜索按钮
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSearching ? null : _startSearch,
                  child: Text(_isSearching ? '搜索中...' : '开始搜索'),
                ),
              ),
              const SizedBox(height: 16),

              // 跳过按钮
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.versionSelection);
                  },
                  child: const Text('跳过'),
                ),
              ),

              // 底部提示
              const SizedBox(height: 16),
              Text(
                '搜索设备过程需按遥控器的\n联接设备。',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}