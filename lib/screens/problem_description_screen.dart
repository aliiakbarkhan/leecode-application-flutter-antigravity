import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'code_editor_screen.dart';

class ProblemDescriptionScreen extends StatefulWidget {
  final int problemNumber;
  final String problemTitle;
  final String difficulty;
  final List<String> tags;

  const ProblemDescriptionScreen({
    super.key,
    required this.problemNumber,
    required this.problemTitle,
    required this.difficulty,
    required this.tags,
  });

  @override
  State<ProblemDescriptionScreen> createState() => _ProblemDescriptionScreenState();
}

class _ProblemDescriptionScreenState extends State<ProblemDescriptionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${widget.problemNumber}. ${widget.problemTitle}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border_rounded, color: AppColors.textSecondary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.accent,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.accent,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Description'),
                Tab(text: 'Solutions'),
                Tab(text: 'Submissions'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDescriptionTab(),
                _buildSolutionsTab(),
                _buildSubmissionsTab(),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildDescriptionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.problemNumber}. ${widget.problemTitle}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDifficultyBadge(),
              const SizedBox(width: 16),
              const Row(
                children: [
                  Icon(Icons.thumb_up_outlined, size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 4),
                  Text(
                    '45.2K',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              const Row(
                children: [
                  Icon(Icons.thumb_down_outlined, size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 4),
                  Text(
                    '1.5K',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Row(
                children: [
                  Icon(Icons.check_circle_outline, size: 16, color: AppColors.easy),
                  SizedBox(width: 4),
                  Text(
                    'Solved',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                height: 1.7,
                fontFamily: 'Inter',
              ),
              children: [
                TextSpan(text: 'Given an array of integers '),
                TextSpan(
                  text: '`nums`',
                  style: TextStyle(
                    backgroundColor: Color(0xFFFEF3C7),
                    color: AppColors.accentDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: ' and an integer '),
                TextSpan(
                  text: '`target`',
                  style: TextStyle(
                    backgroundColor: Color(0xFFFEF3C7),
                    color: AppColors.accentDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: ', return '),
                TextSpan(
                  text: 'indices of the two numbers such that they add up to ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: '`target`',
                  style: TextStyle(
                    backgroundColor: Color(0xFFFEF3C7),
                    color: AppColors.accentDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: '.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'You may assume that each input would have exactly one solution, and you may not use the same element twice.',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'You can return the answer in any order.',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 28),
          _buildExample(
            'EXAMPLE 1',
            'Input: nums = [2,7,11,15], target = 9\nOutput: [0,1]\nExplain:Because nums[0] + nums[1] == 9,\n        we return [0, 1].',
          ),
          const SizedBox(height: 20),
          _buildExample(
            'EXAMPLE 2',
            'Input: nums = [3,2,4], target = 6\nOutput: [1,2]',
          ),
          const SizedBox(height: 20),
          _buildExample(
            'EXAMPLE 3',
            'Input: nums = [3,3]\nOutput: [0,1]',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDifficultyBadge() {
    Color bgColor;
    Color textColor;
    switch (widget.difficulty) {
      case 'Easy':
        bgColor = AppColors.easyBg;
        textColor = AppColors.easyText;
        break;
      case 'Medium':
        bgColor = AppColors.mediumBg;
        textColor = AppColors.mediumText;
        break;
      default:
        bgColor = AppColors.hardBg;
        textColor = AppColors.hardText;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        widget.difficulty,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildExample(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontFamily: 'monospace',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lightbulb_outline, size: 48, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          const Text(
            'Solutions coming soon',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 48, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          const Text(
            'No submissions yet',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
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
            // Ask AI button
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
                    Icon(Icons.chat_bubble_outline, size: 18, color: AppColors.textSecondary),
                    SizedBox(width: 8),
                    Text(
                      'Ask AI',
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
            const SizedBox(width: 12),
            // Solve Problem button
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CodeEditorScreen(
                        problemNumber: widget.problemNumber,
                        problemTitle: widget.problemTitle,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '<>',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Solve Problem',
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
            ),
          ],
        ),
      ),
    );
  }
}
