import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CodeEditorScreen extends StatefulWidget {
  final int problemNumber;
  final String problemTitle;

  const CodeEditorScreen({
    super.key,
    required this.problemNumber,
    required this.problemTitle,
  });

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  String _selectedLanguage = 'Python 3';
  int _selectedTab = 0; // 0 = Test Cases, 1 = Console Output

  final String _codeContent = '''
class Solution:
    def trap(self, height: List[int]) -> i
        # Two pointer approach

        if not height:
            return 0
        l, r = 0, len(height) - 1

        leftMax, rightMax = height[l], hei
        res = 0

        while l < r:
            if leftMax < rightMax:
                l += 1
                leftMax = max(leftMax, hei
                res += leftMax - height[l]
            else:
                r -= 1
                rightMax = max(rightMax, h
                res += rightMax - height[r

        return res''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PROBLEM ${widget.problemNumber}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 1.2,
              ),
            ),
            Text(
              widget.problemTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.timer_outlined, color: Colors.white.withOpacity(0.7)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined, color: Colors.white.withOpacity(0.7)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildLanguageBar(),
          Expanded(child: _buildCodeEditor()),
          _buildDragHandle(),
          _buildTestCasesSection(),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildLanguageBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFF252540),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D4A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF3D3D5C)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedLanguage,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.expand_more, color: Colors.white.withOpacity(0.5), size: 18),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.undo, color: Colors.white.withOpacity(0.5), size: 22),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.redo, color: Colors.white.withOpacity(0.5), size: 22),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.format_list_bulleted, color: Colors.white.withOpacity(0.5), size: 22),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCodeEditor() {
    final lines = _codeContent.split('\n');
    return Container(
      color: const Color(0xFF1E1E2E),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(lines.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 44,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        '${index + 1}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.25),
                          fontFamily: 'monospace',
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildSyntaxHighlighted(lines[index]),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSyntaxHighlighted(String line) {
    // Simple syntax highlighting
    final keywords = ['class', 'def', 'if', 'while', 'else', 'return', 'not'];
    final builtins = ['self', 'len', 'max', 'List', 'int'];
    final numbers = RegExp(r'\b\d+\b');

    List<TextSpan> spans = [];
    final words = line.split(RegExp(r'(?<=\s)|(?=\s)|(?<=\()|(?=\()|(?<=\))|(?=\))|(?<=:)|(?=:)|(?<=,)|(?=,)|(?<=\[)|(?=\[)|(?<=\])|(?=\])'));

    for (var word in words) {
      final trimmed = word.trim();
      if (trimmed.startsWith('#')) {
        // Comment - rest of line
        final commentStart = line.indexOf('#');
        if (commentStart >= 0) {
          spans.add(TextSpan(
            text: word,
            style: const TextStyle(color: Color(0xFF6A9955)),
          ));
          continue;
        }
      }

      if (keywords.contains(trimmed)) {
        spans.add(TextSpan(
          text: word,
          style: const TextStyle(color: Color(0xFFC586C0)),
        ));
      } else if (builtins.contains(trimmed)) {
        spans.add(TextSpan(
          text: word,
          style: const TextStyle(color: Color(0xFF4EC9B0)),
        ));
      } else if (numbers.hasMatch(trimmed) && trimmed == trimmed.replaceAll(RegExp(r'[^0-9]'), '')) {
        spans.add(TextSpan(
          text: word,
          style: const TextStyle(color: Color(0xFFB5CEA8)),
        ));
      } else if (trimmed == '->' || trimmed == '=' || trimmed == '<' || trimmed == '>' ||
          trimmed == '+' || trimmed == '-' || trimmed == '*') {
        spans.add(TextSpan(
          text: word,
          style: const TextStyle(color: Color(0xFFD4D4D4)),
        ));
      } else {
        spans.add(TextSpan(
          text: word,
          style: const TextStyle(color: Color(0xFFD4D4D4)),
        ));
      }
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'monospace',
          height: 1.6,
        ),
        children: spans,
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      color: const Color(0xFF252540),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildTestCasesSection() {
    return Container(
      color: AppColors.surface,
      child: Column(
        children: [
          // Tab header
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.cardBorder),
              ),
            ),
            child: Row(
              children: [
                _buildTestTab('Test Cases', 0),
                _buildTestTab('Console Output', 1),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.open_in_full, size: 18, color: AppColors.textTertiary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Content
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'CASE 1',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.easyBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Passed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.easyText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Input: height =',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '[0,1,0,2,1,0,1,3,2,1,2,1]',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'monospace',
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Expected Output:',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.accent : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Debug
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bug_report_outlined, size: 18, color: AppColors.textSecondary),
                    SizedBox(width: 6),
                    Text(
                      'Debug',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Run
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow_rounded, size: 20, color: AppColors.textPrimary),
                    SizedBox(width: 4),
                    Text(
                      'Run',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Submit
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 18, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
