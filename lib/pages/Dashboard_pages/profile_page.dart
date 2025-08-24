import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../providers/user_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../providers/wishliststream_provider.dart'; // Import your providers here
import '../../providers/order_provider.dart';
import '../../models/order_model.dart';

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
    final profileBox = await Hive.openBox<Map>('profileBox');
    if (user != null) {
      // Load from Hive first
      final cached = profileBox.get(user.uid);
      if (cached != null) {
        ref.read(userDataProvider.notifier).state = Map<String, dynamic>.from(cached);
      }
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        ref.read(userDataProvider.notifier).state = doc.data();
        // Save to Hive (fix type)
        if (doc.data() != null) {
          await profileBox.put(user.uid, Map<dynamic, dynamic>.from(doc.data()!));
        }
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

  void _showUpdateNameDialog() {
    final userData = ref.read(userDataProvider);
    final controller = TextEditingController(text: userData != null && userData['name'] != null ? userData['name'] : '');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null && controller.text.trim().isNotEmpty) {
                  await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'name': controller.text.trim()});
                  // Update Hive cache
                  final profileBox = await Hive.openBox<Map>('profileBox');
                  final current = profileBox.get(user.uid) ?? {};
                  current['name'] = controller.text.trim();
                  await profileBox.put(user.uid, Map<dynamic, dynamic>.from(current));
                  _showSnackBar('Name updated!');
                  _loadUserData();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuCard(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFF4548).withAlpha(25),
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
    final user = FirebaseAuth.instance.currentUser;
    final orders = ref.watch(orderProvider);
    // Fetch orders if user is logged in
    if (user != null) {
      ref.read(orderProvider.notifier).fetchOrders(user.uid);
    }
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
          : ListView(
        padding: const EdgeInsets.all(16.0),
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

          _buildMenuCard(Icons.person, 'Update Profile', 'Edit your personal information', _showUpdateNameDialog),
          _buildMenuCard(Icons.lock_reset, 'Reset Password', 'Change your account password', _resetPassword),
          _buildMenuCard(Icons.refresh, 'Refresh Data', 'Reload your account information', _refreshData),
          const SizedBox(height: 24),
          const Text('Order History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (orders.isEmpty)
            const Text('No orders yet.'),
          ...orders.map((order) => Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ExpansionTile(
                  title: Text('Order #${order.id.substring(0, 8)}'),
                  subtitle: Text('Total: ₹${order.total.toStringAsFixed(2)} | ${order.timestamp.day}/${order.timestamp.month}/${order.timestamp.year}'),
                  children: [
                    ListTile(
                      title: Text('Address: ${order.address}'),
                      subtitle: Text('Payment: ${order.paymentMethod}'),
                    ),
                    ...order.items.map((item) => ListTile(
                          title: Text(item.laptop.name),
                          subtitle: Text('x${item.quantity}'),
                          trailing: Text('₹${(item.laptop.price * item.quantity).toStringAsFixed(2)}'),
                        )),
                  ],
                ),
              )),
          // ...rest of profile widgets...
        ],
      ),
    );
  }
}
