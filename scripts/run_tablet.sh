#!/bin/bash
# 平板终端启动脚本
# 端口: 8082 | 设备: Chrome 可拖拽窗口模拟横竖屏切换
cd "$(dirname "$0")/../apps/cat_tablet" && flutter run -d chrome --web-port=8082