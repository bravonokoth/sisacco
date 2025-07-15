# Sisacco App

A Flutter-based mobile application for financial management and banking services.

## Features

- **User Authentication**: Secure login and registration system
- **Account Management**: View and manage multiple bank accounts
- **Transaction History**: Track all financial transactions
- **Loan Management**: Apply for and manage loans
- **Money Transfers**: Send money between accounts
- **Admin Dashboard**: Administrative tools for managing users and transactions
- **Real-time Updates**: Live updates for account balances and transactions

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Supabase (PostgreSQL + Real-time subscriptions)
- **Authentication**: Supabase Auth
- **State Management**: Provider pattern
- **UI Components**: Custom Flutter widgets with Material Design

## Getting Started

### Prerequisites

- Flutter SDK (3.24.1 or higher)
- Dart SDK (3.5.1 or higher)
- Android Studio / VS Code
- Android SDK (API level 34)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/bravonokoth/sisacco.git
   cd sisacco
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   - Create a Supabase project at [supabase.com](https://supabase.com)
   - Update the Supabase configuration in `lib/config/supabase_config.dart`
   - Set up your database tables and authentication

4. **Run the application**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── config/           # Configuration files
├── models/           # Data models
├── providers/        # State management
├── screens/          # UI screens
│   ├── admin/        # Admin-specific screens
│   ├── auth/         # Authentication screens
│   └── user/         # User screens
├── services/         # API services
├── theme/            # App theming
├── utils/            # Utility functions
└── widgets/          # Reusable widgets
```

## Key Dependencies

- `supabase_flutter`: Backend and authentication
- `provider`: State management
- `google_maps_flutter`: Location services
- `image_picker`: Image selection
- `mobile_scanner`: QR code scanning
- `firebase_messaging`: Push notifications
- `local_auth`: Biometric authentication

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email bravonorwa@gmail.com or create an issue in this repository.

## Screenshots



Screenshot 1
![App Screenshot 1](assets/images/Screenshot from 2025-07-15 06-39-49.png "Sisacco App View 1")

Screenshot 2
![App Screenshot 2](assets/images/Screenshot from 2025-07-15 06-38-39.png "Sisacco App View 2")

Screenshot 3
![App Screenshot 3](assets/images/Screenshot from 2025-07-15 06-32-11.png "Sisacco App View 3")

Screenshot 4
![App Screenshot 4](assets/images/Screenshot from 2025-07-15 06-32-03.png "Sisacco App View 4")

Screenshot 5
![App Screenshot 5](assets/images/Screenshot from 2025-07-15 06-31-55.png "Sisacco App View 5")

Screenshot 6
![App Screenshot 6](assets/images/Screenshot from 2025-07-15 06-31-48.png "Sisacco App View 6")

Screenshot 7
![App Screenshot 7](assets/images/Screenshot from 2025-07-15 06-31-25.png "Sisacco App View 7")

Screenshot 8
![App Screenshot 8](assets/images/Screenshot from 2025-07-15 06-31-18.png "Sisacco App View 8")

Screenshot 9
![App Screenshot 9](assets/images/Screenshot from 2025-07-15 06-31-05.png "Sisacco App View 9")

Screenshot 10
![App Screenshot 10](assets/images/Screenshot from 2025-07-15 06-30-57.png "Sisacco App View 10")

Screenshot 11
![App Screenshot 11](assets/images/Screenshot from 2025-07-15 06-30-51.png "Sisacco App View 11")

Screenshot 12
![App Screenshot 12](assets/images/Screenshot from 2025-07-15 06-30-43.png "Sisacco App View 12")

Screenshot 13
![App Screenshot 13](assets/images/Screenshot from 2025-07-15 06-30-27.png "Sisacco App View 13")

Screenshot 14
![App Screenshot 14](assets/images/Screenshot from 2025-07-15 06-29-00.png "Sisacco App View 14")

Note: This is a development version. Some features may be in progress or subject to change.

---

**Note**: This is a development version. Some features may be in progress or subject to change.
