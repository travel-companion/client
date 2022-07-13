import 'package:flutter/material.dart';

@immutable
class MessageData {
  const MessageData({
    required this.senderName,
    required this.message,
    required this.messageDate,
    required this.dateMessage,
    required this.profilePicture,
  });
  final dynamic senderName;
  final dynamic message;
  final DateTime messageDate;
  final dynamic dateMessage;
  final dynamic profilePicture;
}
