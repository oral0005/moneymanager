import 'package:flutter/material.dart';
import '../theme/style_constants.dart';
import '../widgets/styled_list_tile.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
        style: TextStyle(
          color: Colors.white, // Ensure the title is visible against the background
        )),
        centerTitle: true, // Optional: center the title
        backgroundColor: const Color(0xFF27282D), // Optional
      ),
      body: Container(
        color: const Color(0xFF27282D), // Match the app's background color
        child: ListView(
          children: [
            const StyledListTile(icon: Icons.calculate, title: 'CalcBox'),
            const StyledListTile(icon: Icons.computer, title: 'PC Manager'),
            const StyledListTile(icon: Icons.help_outline, title: 'Help'),
            const StyledListTile(icon: Icons.feedback, title: 'Feedback'),
            const StyledListTile(icon: Icons.star_rate, title: 'Rate It'),
            const StyledListTile(icon: Icons.remove_circle_outline, title: 'Remove Ads'),
            
            sectionTitle('Trans.'),
            const StyledListTile(icon: Icons.tune, title: 'Transaction Settings'),
            const StyledListTile(icon: Icons.repeat, title: 'Repeat Setting'),
            const StyledListTile(icon: Icons.copy, title: 'Copy-Paste Setting'),

            sectionTitle('Category/Accounts'),
            const StyledListTile(icon: Icons.category, title: 'Income Category Setting'),
            const StyledListTile(icon: Icons.category_outlined, title: 'Expenses Category Setting'),
            const StyledListTile(icon: Icons.account_balance_wallet, title: 'Accounts Setting'),
            const StyledListTile(icon: Icons.pie_chart, title: 'Budget Setting'),

            sectionTitle('Settings'),
            const StyledListTile(icon: Icons.backup, title: 'Backup'),
            const StyledListTile(icon: Icons.lock, title: 'Passcode'),
            const StyledListTile(icon: Icons.attach_money, title: 'Main Currency Setting'),
            const StyledListTile(icon: Icons.money, title: 'Sub Currency Setting'),
            const StyledListTile(icon: Icons.alarm, title: 'Alarm Setting'),
            const StyledListTile(icon: Icons.format_paint, title: 'Style'),
            const StyledListTile(icon: Icons.apps, title: 'Application Icon'),
            const StyledListTile(icon: Icons.language, title: 'Language Setting'),
            const StyledListTile(icon: Icons.privacy_tip, title: 'Allow Ad Tracking'),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
      decoration: BoxDecoration(
        color: kSectionBackgroundColor,
        border: const Border(
          top: BorderSide(color: Color.fromARGB(255, 116, 116, 116), width: 0.5),
          bottom: BorderSide(color: Color.fromARGB(255, 116, 116, 116), width: 0.5),
        ),
      ),
      child: Text(title, style: kSectionTitleStyle),
    );
  }
}
