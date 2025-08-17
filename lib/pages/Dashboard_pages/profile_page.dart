import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/general_components/favourite_component.dart';
import '../../providers/user_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../providers/wishliststream_provider.dart'; // Import your providers here

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  // Use Riverpod state for user data and loading
  late final userDataProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
  late final isLoadingProvider = StateProvider<bool>((ref) => true);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        ref.read(userDataProvider.notifier).state = doc.data();
      } catch (e) {
        _showSnackBar('Error loading user data: $e');
      }
    }
    ref.read(isLoadingProvider.notifier).state = false;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // Invalidate user-dependent providers to clean up state on logout
                ref.invalidate(userEmailProvider);
                ref.invalidate(wishlistStreamProvider);
                ref.invalidate(wishlistProductsProvider);
                // Invalidate additional providers that depend on user here if any

                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushNamedAndRemoveUntil('/signin_page', (route) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
                    await user.delete();
                    Navigator.of(context).pushNamedAndRemoveUntil('/signin_page', (route) => false);
                    _showSnackBar('Account deleted successfully');
                  }
                } catch (e) {
                  _showSnackBar('Error deleting account: $e');
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }

  void _updateProfile() {
    Navigator.of(context).pushNamed('/update-profile');
  }

  Future<void> _resetPassword() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);
        _showSnackBar('Password reset email sent to ${user.email}');
      } catch (e) {
        _showSnackBar('Error sending password reset email: $e');
      }
    }
  }

  void _refreshData() {
    ref.read(isLoadingProvider.notifier).state = true;
    _loadUserData();
  }

  Widget _buildMenuCard(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFF4548).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: const Color(0xFFFF4548)),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'logout':
                  _showLogoutDialog();
                  break;
                case 'delete':
                  _showDeleteAccountDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(value: 'logout', child: Text('Logout')),
              PopupMenuItem(value: 'delete', child: Text('Delete Account')),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome!', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text(userData?['name'] ?? 'User', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text('Email: ${FirebaseAuth.instance.currentUser?.email ?? 'N/A'}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    if (userData?['createdAt'] != null)
                      Text('Member since: ${_formatDate(userData!['createdAt'] as Timestamp)}',
                          style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Menu Options
            Text('Account Settings', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),

            _buildMenuCard(Icons.person, 'Update Profile', 'Edit your personal information', _updateProfile),
            _buildMenuCard(Icons.lock_reset, 'Reset Password', 'Change your account password', _resetPassword),
            _buildMenuCard(Icons.refresh, 'Refresh Data', 'Reload your account information', _refreshData),
          ],
        ),
      ),
    );
  }
}
