#!/bin/bash
# 手机终端启动脚本
# 端口: 8083 | 设备: Chrome 窄窗口模拟竖屏
cd "$(dirname "$0")/../apps/cat_phone" && flutter run -d chrome --web-port=8083