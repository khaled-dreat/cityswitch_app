import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/edit_keywords_cubit/edit_keywords_cubit.dart';

class EditBuildKeywordChip extends StatelessWidget {
  const EditBuildKeywordChip({
    super.key,
    required this.keyword,
    required this.index,
  });

  final String keyword;
  final int index;

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Arial Unicode MS',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            keyword,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
              fontFamily: 'Arial Unicode MS',
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () {
              context.read<EditKeywordsCubit>().removeKeyword(index);
              _showSnackBar(
                context,
                'The keyword has been removed.',
                Colors.orange,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.close, size: 14, color: Colors.red.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
