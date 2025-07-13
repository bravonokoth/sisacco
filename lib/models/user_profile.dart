class UserProfile {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final String kycStatus; // pending, verified, rejected
  final Map<String, dynamic>? metadata;

  UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.profileImageUrl,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    required this.kycStatus,
    this.metadata,
  });

  String get fullName => '$firstName $lastName';

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      profileImageUrl: json['profile_image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      isActive: json['is_active'] ?? true,
      kycStatus: json['kyc_status'] ?? 'pending',
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'profile_image_url': profileImageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_active': isActive,
      'kyc_status': kycStatus,
      'metadata': metadata,
    };
  }

  UserProfile copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
    DateTime? updatedAt,
    bool? isActive,
    String? kycStatus,
    Map<String, dynamic>? metadata,
  }) {
    return UserProfile(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      kycStatus: kycStatus ?? this.kycStatus,
      metadata: metadata ?? this.metadata,
    );
  }
}
