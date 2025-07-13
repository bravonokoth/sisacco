import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';
import '../models/user_profile.dart';

class AuthProvider with ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  
  User? _user;
  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  bool get isAdmin => _userProfile?.metadata?['role'] == 'admin';

  AuthProvider() {
    _initializeAuth();
  }

  void _initializeAuth() {
    _user = _supabaseService.currentUser;
    if (_user != null) {
      _loadUserProfile();
    }

    // Listen to auth state changes
    _supabaseService.authStateChanges.listen((data) {
      _user = data.session?.user;
      if (_user != null) {
        _loadUserProfile();
      } else {
        _userProfile = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserProfile() async {
    if (_user == null) return;
    
    try {
      _userProfile = await _supabaseService.getUserProfile(_user!.id);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load user profile: $e';
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _supabaseService.signInWithEmail(email, password);
      
      if (response.user != null) {
        _user = response.user;
        await _loadUserProfile();
        _setLoading(false);
        return true;
      } else {
        _setError('Sign in failed');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Sign in failed: $e');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _supabaseService.signUp(
        email,
        password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );

      if (response.user != null) {
        _user = response.user;
        await _loadUserProfile();
        _setLoading(false);
        return true;
      } else {
        _setError('Sign up failed');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Sign up failed: $e');
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    
    try {
      await _supabaseService.signOut();
      _user = null;
      _userProfile = null;
      _setLoading(false);
    } catch (e) {
      _setError('Sign out failed: $e');
      _setLoading(false);
    }
  }

  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      await _supabaseService.resetPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Password reset failed: $e');
      _setLoading(false);
      return false;
    }
  }

  Future<void> updateProfile(UserProfile updatedProfile) async {
    _setLoading(true);
    _clearError();

    try {
      await _supabaseService.updateUserProfile(updatedProfile);
      _userProfile = updatedProfile;
      _setLoading(false);
    } catch (e) {
      _setError('Profile update failed: $e');
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
