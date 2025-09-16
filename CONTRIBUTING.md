# Contributing to HealthWallet.me

Thank you for your interest in contributing to HealthWallet.me! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

Before creating an issue, please:

1. **Search existing issues** to avoid duplicates
2. **Use the issue templates** provided in the repository
3. **Provide detailed information** including:
   - Flutter/Dart version
   - Platform (iOS/Android)
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots or logs if applicable

### Suggesting Features

We welcome feature suggestions! Please:

1. **Check the roadmap** in the README to see if it's already planned
2. **Create a detailed issue** describing the feature
3. **Explain the use case** and benefits
4. **Consider implementation complexity** and impact

### Code Contributions

#### Getting Started

1. **Fork the repository**
2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/health-wallet.git
   cd health-wallet
   ```
3. **Set up development environment**
   ```bash
   # Install FVM
   dart pub global activate fvm
   fvm install
   fvm use
   
   # Install dependencies
   flutter pub get
   
   # Generate code
   flutter packages pub run build_runner build
   ```

#### Development Workflow

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the coding standards below
   - Add tests for new functionality
   - Update documentation if needed

3. **Test your changes**
   ```bash
   # Run tests
   flutter test
   
   # Run linter
   flutter analyze
   
   # Run on device/emulator
   flutter run
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **Push and create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

## 📋 Coding Standards

### Dart/Flutter Style

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use [Flutter Lints](https://pub.dev/packages/flutter_lints) rules
- Run `dart format .` before committing
- Use meaningful variable and function names

### Code Organization

#### File Structure
```
lib/features/[feature_name]/
├── data/
│   ├── datasources/       # Data sources (API, local storage)
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
├── domain/
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository interfaces
│   └── usecases/        # Business logic use cases
└── presentation/
    ├── bloc/            # BLoC state management
    ├── pages/           # Screen widgets
    └── widgets/         # Reusable widgets
```

#### Naming Conventions

- **Files**: Use snake_case (e.g., `user_profile_page.dart`)
- **Classes**: Use PascalCase (e.g., `UserProfilePage`)
- **Variables/Functions**: Use camelCase (e.g., `userProfile`)
- **Constants**: Use SCREAMING_SNAKE_CASE (e.g., `API_BASE_URL`)

### State Management

We use **BLoC** for state management:

```dart
// Event
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String userId;
  
  const LoadUser(this.userId);
  
  @override
  List<Object> get props => [userId];
}

// State
abstract class UserState extends Equatable {
  const UserState();
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final User user;
  
  const UserLoaded(this.user);
  
  @override
  List<Object> get props => [user];
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;
  
  UserBloc({required this.getUserUseCase}) : super(UserLoading()) {
    on<LoadUser>(_onLoadUser);
  }
  
  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final user = await getUserUseCase(event.userId);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
```

### Dependency Injection

We use **GetIt** with **Injectable**:

```dart
@injectable
class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;
  
  UserRepositoryImpl(this.dataSource);
  
  @override
  Future<User> getUser(String id) async {
    return await dataSource.getUser(id);
  }
}
```

### Error Handling

Use custom exceptions and proper error handling:

```dart
// Custom exceptions
class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

// Error handling in repositories
@override
Future<User> getUser(String id) async {
  try {
    return await remoteDataSource.getUser(id);
  } on DioException catch (e) {
    throw NetworkException('Failed to get user: ${e.message}');
  }
}
```

### Testing

#### Unit Tests
- Test business logic in use cases
- Test BLoC state changes
- Test repository implementations
- Aim for >80% code coverage

```dart
// Example unit test
group('UserBloc', () {
  late UserBloc userBloc;
  late MockGetUserUseCase mockGetUserUseCase;
  
  setUp(() {
    mockGetUserUseCase = MockGetUserUseCase();
    userBloc = UserBloc(getUserUseCase: mockGetUserUseCase);
  });
  
  test('should emit UserLoaded when LoadUser is added', () async {
    // Arrange
    const userId = '123';
    const user = User(id: userId, name: 'Test User');
    when(() => mockGetUserUseCase(userId)).thenAnswer((_) async => user);
    
    // Act
    userBloc.add(const LoadUser(userId));
    
    // Assert
    expectLater(
      userBloc.stream,
      emitsInOrder([
        UserLoading(),
        const UserLoaded(user),
      ]),
    );
  });
});
```

#### Widget Tests
- Test UI components
- Test user interactions
- Test navigation

```dart
// Example widget test
testWidgets('UserProfilePage displays user information', (tester) async {
  // Arrange
  const user = User(id: '123', name: 'Test User');
  when(() => mockUserBloc.state).thenReturn(const UserLoaded(user));
  
  // Act
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<UserBloc>(
        create: (_) => mockUserBloc,
        child: const UserProfilePage(),
      ),
    ),
  );
  
  // Assert
  expect(find.text('Test User'), findsOneWidget);
});
```

### Documentation

#### Code Documentation
- Document public APIs with dartdoc comments
- Explain complex business logic
- Provide examples for complex functions

```dart
/// Retrieves a user by their unique identifier.
/// 
/// Returns a [User] object if found, throws [UserNotFoundException] if not found.
/// 
/// Example:
/// ```dart
/// final user = await userRepository.getUser('123');
/// print(user.name);
/// ```
Future<User> getUser(String id);
```

#### README Updates
- Update README.md for new features
- Add installation instructions for new dependencies
- Update examples and usage guides

## 🔍 Code Review Process

### Pull Request Guidelines

1. **Create a descriptive title** and description
2. **Link related issues** using keywords like "Fixes #123"
3. **Add screenshots** for UI changes
4. **Ensure all checks pass** (tests, linting, CI)
5. **Request review** from maintainers

### Review Checklist

#### For Contributors
- [ ] Code follows style guidelines
- [ ] Tests are added/updated
- [ ] Documentation is updated
- [ ] No breaking changes (or properly documented)
- [ ] Performance impact considered

#### For Reviewers
- [ ] Code quality and style
- [ ] Test coverage and quality
- [ ] Security implications
- [ ] Performance impact
- [ ] Documentation completeness

## 🏗️ Architecture Guidelines

### Clean Architecture

Follow Clean Architecture principles:

```
Presentation Layer (UI)
    ↓
Domain Layer (Business Logic)
    ↓
Data Layer (Data Sources)
```

### SOLID Principles

- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Derived classes must be substitutable for base classes
- **Interface Segregation**: No client should depend on methods it doesn't use
- **Dependency Inversion**: Depend on abstractions, not concretions

### Design Patterns

- **Repository Pattern**: Abstract data access
- **BLoC Pattern**: State management
- **Dependency Injection**: Loose coupling
- **Factory Pattern**: Object creation
- **Observer Pattern**: Event handling

## 🚀 Release Process

### Versioning

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist

- [ ] All tests pass
- [ ] Documentation updated
- [ ] Version bumped in pubspec.yaml
- [ ] CHANGELOG.md updated
- [ ] Release notes prepared
- [ ] Tag created

## 🐛 Bug Reports

When reporting bugs, please include:

1. **Environment**:
   - Flutter version (`flutter --version`)
   - Dart version
   - Platform (iOS/Android)
   - Device/Emulator details

2. **Steps to Reproduce**:
   - Clear, numbered steps
   - Expected behavior
   - Actual behavior

3. **Additional Context**:
   - Screenshots or videos
   - Logs or error messages
   - Related issues

## 💡 Feature Requests

When suggesting features:

1. **Problem Statement**: What problem does this solve?
2. **Proposed Solution**: How should it work?
3. **Alternatives**: What other approaches were considered?
4. **Additional Context**: Any other relevant information

## 📞 Getting Help

- **GitHub Discussions**: For questions and general discussion
- **GitHub Issues**: For bug reports and feature requests
- **Email**: support@healthwallet.me for private matters

## 🎯 Areas for Contribution

### High Priority
- 🐛 Bug fixes
- 📱 UI/UX improvements
- 🧪 Test coverage
- 📚 Documentation

### Medium Priority
- ⚡ Performance optimizations
- 🔒 Security enhancements
- 🌍 Internationalization
- 📊 Analytics and monitoring

### Low Priority
- 🎨 UI polish
- 🔧 Developer tools
- 📈 Metrics and insights

## 🙏 Recognition

Contributors will be recognized in:

- **README.md**: Contributors section
- **Release Notes**: For significant contributions
- **GitHub**: Contributor statistics

Thank you for contributing to HealthWallet.me! Together, we're building a better future for healthcare technology.

---

*This contributing guide is a living document. Please suggest improvements via issues or pull requests.*
