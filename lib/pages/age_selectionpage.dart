import 'package:flutter/material.dart';

class AgeSelectionPage extends StatefulWidget {
  @override
  State<AgeSelectionPage> createState() => _AgeSelectionPageState();
}

class _AgeSelectionPageState extends State<AgeSelectionPage> with SingleTickerProviderStateMixin {
  String? selectedAgeGroup;
  final List<String> ageGroups = [
    '18–20 years',
    '21–25 years',
    '26–30 years',
    '31–35 years',
    '36–40 years',
    '41+ years',
  ];

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue.shade800),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 20),
                Text(
                  'Tell us about yourself',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Select your age group to help us personalize your experience',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey.shade700,
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: ageGroups.length,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                color: Colors.blue.shade100,
                              ),
                              itemBuilder: (context, index) {
                                final ageGroup = ageGroups[index];
                                return _buildAgeOption(ageGroup);
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: selectedAgeGroup == null
                                  ? null
                                  : () {
                                _showConfirmation(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Colors.blue.shade700,
                                elevation: 5,
                                shadowColor: Colors.blue.shade200,
                              ),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgeOption(String ageGroup) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedAgeGroup = ageGroup;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: selectedAgeGroup == ageGroup
              ? Colors.blue.shade100.withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedAgeGroup == ageGroup
                      ? Colors.blue.shade700
                      : Colors.blueGrey.shade300,
                  width: 2,
                ),
              ),
              child: selectedAgeGroup == ageGroup
                  ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade700,
                  ),
                ),
              )
                  : null,
            ),
            SizedBox(width: 16),
            Text(
              ageGroup,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade900,
                fontWeight: selectedAgeGroup == ageGroup
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                size: 60,
                color: Colors.green.shade400,
              ),
              SizedBox(height: 20),
              Text(
                'Age Group Selected',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You selected: $selectedAgeGroup',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey.shade700,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Here you would typically navigate to the next page
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Age group saved successfully'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue.shade700,
                  ),
                  child: Text(
                    'Confirm Selection',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}