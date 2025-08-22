import 'package:equatable/equatable.dart';

class SocketState extends Equatable {
  final bool isConnected;
  final List<Map<String, dynamic>> messages;

  const SocketState({required this.isConnected, required this.messages});

  SocketState copyWith({
    bool? isConnected,
    List<Map<String, dynamic>>? messages,
  }) {
    return SocketState(
      isConnected: isConnected ?? this.isConnected,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [isConnected, messages];
}
