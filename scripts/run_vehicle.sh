#!/bin/bash
# 车载终端启动脚本
# 端口: 8081 | 设备: Chrome 横屏模拟 12 寸大屏
cd "$(dirname "$0")/../apps/cat_vehicle" && flutter run -d chrome --web-port=8081