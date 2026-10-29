import 'package:flutter/material.dart';
import 'agent_chat_page.dart';

/// Agent AI 对话页面的路由入口
///
/// 包装 [AgentChatPage]，提供与路由系统兼容的接口。
class AgentPage extends StatelessWidget {
  final String title;
  const AgentPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const AgentChatPage();
  }
}