import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'problem_description_screen.dart';
import 'study_plans_screen.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  String _selectedTopic = 'All Topics';
  String _selectedDifficulty = 'Easy';
  final TextEditingController _searchController = TextEditingController();

  final List<String> topics = [
    'All Topics',
    'Arrays & Hashing',
    'Two Pointers',
    'Sliding Window',
    'Stack',
    'Binary Search',
    'Linked List',
  ];

  final List<Map<String, dynamic>> problems = [
    {
      'number': 1,
      'title': 'Two Sum',
      'acceptance': '48.2%',
      'badge': 'Top 100',
      'difficulty': 'Easy',
      'tags': ['Arrays', 'Hash Table'],
      'solved': true,
      'bookmarked': false,
    },
    {
      'number': 200,
      'title': 'Number of Islands',
      'acceptance': '54.1%',
      'badge': 'Blind 75',
      'difficulty': 'Medium',
      'tags': ['Graph', 'BFS'],
      'solved': false,
      'bookmarked': true,
    },
    {
      'number': 42,
      'title': 'Trapping Rain Water',
      'acceptance': '56.8%',
      'badge': 'Daily Challenge',
      'difficulty': 'Hard',
      'tags': ['Two Pointers', 'Stack'],
      'solved': false,
      'bookmarked': true,
    },
    {
      'number': 15,
      'title': '3Sum',
      'acceptance': '31.2%',
      'badge': 'Similar to Two Sum',
      'difficulty': 'Medium',
      'tags': ['Arrays', 'Sorting'],
      'solved': false,
      'bookmarked': true,
    },
    {
      'number': 21,
      'title': 'Merge Two Sorted Lists',
      'acceptance': '61.5%',
      'badge': 'Linked List',
      'difficulty': 'Easy',
      'tags': ['Recursion'],
      'solved': true,
      'bookmarked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildTopicFilters(),
                  const SizedBox(height: 16),
                  _buildDifficultyFilters(),
                  const SizedBox(height: 8),
                  _buildProblemList(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'CP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'CodePrep',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textTertiary, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search problems (e.g. Two Sum)',
                  hintStyle: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Text(
                '⌘K',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicFilters() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          final isSelected = _selectedTopic == topic;
          return GestureDetector(
            onTap: () => setState(() => _selectedTopic = topic),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.darkCard : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: isSelected ? null : Border.all(color: AppColors.cardBorder),
              ),
              child: Center(
                child: Text(
                  topic,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDifficultyFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DIFFICULTY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedDifficulty = ''),
                child: const Text(
                  'Reset Filters',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDifficultyChip('Easy', AppColors.easy),
              const SizedBox(width: 10),
              _buildDifficultyChip('Medium', AppColors.textSecondary),
              const SizedBox(width: 10),
              _buildDifficultyChip('Hard', AppColors.textSecondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyChip(String label, Color dotColor) {
    final isSelected = _selectedDifficulty == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedDifficulty = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.easyBg : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.easy.withOpacity(0.3) : AppColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isSelected
                    ? (label == 'Easy'
                        ? AppColors.easy
                        : label == 'Medium'
                            ? AppColors.medium
                            : AppColors.hard)
                    : AppColors.textTertiary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProblemList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: problems.length,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) => _buildProblemCard(problems[index]),
    );
  }

  Widget _buildProblemCard(Map<String, dynamic> problem) {
    final diffColor = problem['difficulty'] == 'Easy'
        ? AppColors.easy
        : problem['difficulty'] == 'Medium'
            ? AppColors.medium
            : AppColors.hard;
    final diffBg = problem['difficulty'] == 'Easy'
        ? AppColors.easyBg
        : problem['difficulty'] == 'Medium'
            ? AppColors.mediumBg
            : AppColors.hardBg;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProblemDescriptionScreen(
              problemNumber: problem['number'],
              problemTitle: problem['title'],
              difficulty: problem['difficulty'],
              tags: List<String>.from(problem['tags']),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${problem['number']}. ${problem['title']}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (problem['solved'] == true) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.check_circle, color: AppColors.easy, size: 18),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.bookmark_border_rounded,
                  color: AppColors.textTertiary,
                  size: 22,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  'Acceptance: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${problem['acceptance']}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '  •  ${problem['badge']}',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: diffBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    problem['difficulty'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: diffColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ...List.generate(
                  (problem['tags'] as List).length,
                  (i) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      problem['tags'][i],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
