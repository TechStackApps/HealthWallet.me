// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignupState {
  SignupStatus get status => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get confirmPassword => throw _privateConstructorUsedError;
  bool get canSignUp => throw _privateConstructorUsedError;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupStateCopyWith<SignupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupStateCopyWith<$Res> {
  factory $SignupStateCopyWith(
          SignupState value, $Res Function(SignupState) then) =
      _$SignupStateCopyWithImpl<$Res, SignupState>;
  @useResult
  $Res call(
      {SignupStatus status,
      String email,
      String firstName,
      String lastName,
      String password,
      String confirmPassword,
      bool canSignUp});

  $SignupStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$SignupStateCopyWithImpl<$Res, $Val extends SignupState>
    implements $SignupStateCopyWith<$Res> {
  _$SignupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? canSignUp = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignupStatus,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      canSignUp: null == canSignUp
          ? _value.canSignUp
          : canSignUp // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignupStatusCopyWith<$Res> get status {
    return $SignupStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignupStateImplCopyWith<$Res>
    implements $SignupStateCopyWith<$Res> {
  factory _$$SignupStateImplCopyWith(
          _$SignupStateImpl value, $Res Function(_$SignupStateImpl) then) =
      __$$SignupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SignupStatus status,
      String email,
      String firstName,
      String lastName,
      String password,
      String confirmPassword,
      bool canSignUp});

  @override
  $SignupStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$SignupStateImplCopyWithImpl<$Res>
    extends _$SignupStateCopyWithImpl<$Res, _$SignupStateImpl>
    implements _$$SignupStateImplCopyWith<$Res> {
  __$$SignupStateImplCopyWithImpl(
      _$SignupStateImpl _value, $Res Function(_$SignupStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? canSignUp = null,
  }) {
    return _then(_$SignupStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignupStatus,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      canSignUp: null == canSignUp
          ? _value.canSignUp
          : canSignUp // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SignupStateImpl implements _SignupState {
  const _$SignupStateImpl(
      {this.status = const SignupStatus.initial(),
      this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.password = '',
      this.confirmPassword = '',
      this.canSignUp = false});

  @override
  @JsonKey()
  final SignupStatus status;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String confirmPassword;
  @override
  @JsonKey()
  final bool canSignUp;

  @override
  String toString() {
    return 'SignupState(status: $status, email: $email, firstName: $firstName, lastName: $lastName, password: $password, confirmPassword: $confirmPassword, canSignUp: $canSignUp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.canSignUp, canSignUp) ||
                other.canSignUp == canSignUp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, email, firstName,
      lastName, password, confirmPassword, canSignUp);

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupStateImplCopyWith<_$SignupStateImpl> get copyWith =>
      __$$SignupStateImplCopyWithImpl<_$SignupStateImpl>(this, _$identity);
}

abstract class _SignupState implements SignupState {
  const factory _SignupState(
      {final SignupStatus status,
      final String email,
      final String firstName,
      final String lastName,
      final String password,
      final String confirmPassword,
      final bool canSignUp}) = _$SignupStateImpl;

  @override
  SignupStatus get status;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get password;
  @override
  String get confirmPassword;
  @override
  bool get canSignUp;

  /// Create a copy of SignupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupStateImplCopyWith<_$SignupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupStatusCopyWith<$Res> {
  factory $SignupStatusCopyWith(
          SignupStatus value, $Res Function(SignupStatus) then) =
      _$SignupStatusCopyWithImpl<$Res, SignupStatus>;
}

/// @nodoc
class _$SignupStatusCopyWithImpl<$Res, $Val extends SignupStatus>
    implements $SignupStatusCopyWith<$Res> {
  _$SignupStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SignupStatusCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SignupStatus.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SignupStatus {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SignupStatusCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SignupStatus.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SignupStatus {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$SignupStatusCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl();

  @override
  String toString() {
    return 'SignupStatus.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements SignupStatus {
  const factory _Success() = _$SuccessImpl;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$SignupStatusCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FailureImpl(
      null == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.error);

  @override
  final Object error;

  @override
  String toString() {
    return 'SignupStatus.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of SignupStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(Object error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(Object error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(Object error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements SignupStatus {
  const factory _Failure(final Object error) = _$FailureImpl;

  Object get error;

  /// Create a copy of SignupStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupEmailChanged {
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of SignupEmailChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupEmailChangedCopyWith<SignupEmailChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupEmailChangedCopyWith<$Res> {
  factory $SignupEmailChangedCopyWith(
          SignupEmailChanged value, $Res Function(SignupEmailChanged) then) =
      _$SignupEmailChangedCopyWithImpl<$Res, SignupEmailChanged>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$SignupEmailChangedCopyWithImpl<$Res, $Val extends SignupEmailChanged>
    implements $SignupEmailChangedCopyWith<$Res> {
  _$SignupEmailChangedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupEmailChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupEmailChangedImplCopyWith<$Res>
    implements $SignupEmailChangedCopyWith<$Res> {
  factory _$$SignupEmailChangedImplCopyWith(_$SignupEmailChangedImpl value,
          $Res Function(_$SignupEmailChangedImpl) then) =
      __$$SignupEmailChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$SignupEmailChangedImplCopyWithImpl<$Res>
    extends _$SignupEmailChangedCopyWithImpl<$Res, _$SignupEmailChangedImpl>
    implements _$$SignupEmailChangedImplCopyWith<$Res> {
  __$$SignupEmailChangedImplCopyWithImpl(_$SignupEmailChangedImpl _value,
      $Res Function(_$SignupEmailChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEmailChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SignupEmailChangedImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignupEmailChangedImpl implements _SignupEmailChanged {
  const _$SignupEmailChangedImpl({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'SignupEmailChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupEmailChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of SignupEmailChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupEmailChangedImplCopyWith<_$SignupEmailChangedImpl> get copyWith =>
      __$$SignupEmailChangedImplCopyWithImpl<_$SignupEmailChangedImpl>(
          this, _$identity);
}

abstract class _SignupEmailChanged implements SignupEmailChanged {
  const factory _SignupEmailChanged({required final String value}) =
      _$SignupEmailChangedImpl;

  @override
  String get value;

  /// Create a copy of SignupEmailChanged
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupEmailChangedImplCopyWith<_$SignupEmailChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupFirstNameChanged {
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of SignupFirstNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupFirstNameChangedCopyWith<SignupFirstNameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupFirstNameChangedCopyWith<$Res> {
  factory $SignupFirstNameChangedCopyWith(SignupFirstNameChanged value,
          $Res Function(SignupFirstNameChanged) then) =
      _$SignupFirstNameChangedCopyWithImpl<$Res, SignupFirstNameChanged>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$SignupFirstNameChangedCopyWithImpl<$Res,
        $Val extends SignupFirstNameChanged>
    implements $SignupFirstNameChangedCopyWith<$Res> {
  _$SignupFirstNameChangedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupFirstNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupFirstNameChangedImplCopyWith<$Res>
    implements $SignupFirstNameChangedCopyWith<$Res> {
  factory _$$SignupFirstNameChangedImplCopyWith(
          _$SignupFirstNameChangedImpl value,
          $Res Function(_$SignupFirstNameChangedImpl) then) =
      __$$SignupFirstNameChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$SignupFirstNameChangedImplCopyWithImpl<$Res>
    extends _$SignupFirstNameChangedCopyWithImpl<$Res,
        _$SignupFirstNameChangedImpl>
    implements _$$SignupFirstNameChangedImplCopyWith<$Res> {
  __$$SignupFirstNameChangedImplCopyWithImpl(
      _$SignupFirstNameChangedImpl _value,
      $Res Function(_$SignupFirstNameChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupFirstNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SignupFirstNameChangedImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignupFirstNameChangedImpl implements _SignupFirstNameChanged {
  const _$SignupFirstNameChangedImpl({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'SignupFirstNameChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupFirstNameChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of SignupFirstNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupFirstNameChangedImplCopyWith<_$SignupFirstNameChangedImpl>
      get copyWith => __$$SignupFirstNameChangedImplCopyWithImpl<
          _$SignupFirstNameChangedImpl>(this, _$identity);
}

abstract class _SignupFirstNameChanged implements SignupFirstNameChanged {
  const factory _SignupFirstNameChanged({required final String value}) =
      _$SignupFirstNameChangedImpl;

  @override
  String get value;

  /// Create a copy of SignupFirstNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupFirstNameChangedImplCopyWith<_$SignupFirstNameChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupLastNameChanged {
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of SignupLastNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupLastNameChangedCopyWith<SignupLastNameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupLastNameChangedCopyWith<$Res> {
  factory $SignupLastNameChangedCopyWith(SignupLastNameChanged value,
          $Res Function(SignupLastNameChanged) then) =
      _$SignupLastNameChangedCopyWithImpl<$Res, SignupLastNameChanged>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$SignupLastNameChangedCopyWithImpl<$Res,
        $Val extends SignupLastNameChanged>
    implements $SignupLastNameChangedCopyWith<$Res> {
  _$SignupLastNameChangedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupLastNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupLastNameChangedImplCopyWith<$Res>
    implements $SignupLastNameChangedCopyWith<$Res> {
  factory _$$SignupLastNameChangedImplCopyWith(
          _$SignupLastNameChangedImpl value,
          $Res Function(_$SignupLastNameChangedImpl) then) =
      __$$SignupLastNameChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$SignupLastNameChangedImplCopyWithImpl<$Res>
    extends _$SignupLastNameChangedCopyWithImpl<$Res,
        _$SignupLastNameChangedImpl>
    implements _$$SignupLastNameChangedImplCopyWith<$Res> {
  __$$SignupLastNameChangedImplCopyWithImpl(_$SignupLastNameChangedImpl _value,
      $Res Function(_$SignupLastNameChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupLastNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SignupLastNameChangedImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignupLastNameChangedImpl implements _SignupLastNameChanged {
  const _$SignupLastNameChangedImpl({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'SignupLastNameChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupLastNameChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of SignupLastNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupLastNameChangedImplCopyWith<_$SignupLastNameChangedImpl>
      get copyWith => __$$SignupLastNameChangedImplCopyWithImpl<
          _$SignupLastNameChangedImpl>(this, _$identity);
}

abstract class _SignupLastNameChanged implements SignupLastNameChanged {
  const factory _SignupLastNameChanged({required final String value}) =
      _$SignupLastNameChangedImpl;

  @override
  String get value;

  /// Create a copy of SignupLastNameChanged
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupLastNameChangedImplCopyWith<_$SignupLastNameChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupPasswordChanged {
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of SignupPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupPasswordChangedCopyWith<SignupPasswordChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupPasswordChangedCopyWith<$Res> {
  factory $SignupPasswordChangedCopyWith(SignupPasswordChanged value,
          $Res Function(SignupPasswordChanged) then) =
      _$SignupPasswordChangedCopyWithImpl<$Res, SignupPasswordChanged>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$SignupPasswordChangedCopyWithImpl<$Res,
        $Val extends SignupPasswordChanged>
    implements $SignupPasswordChangedCopyWith<$Res> {
  _$SignupPasswordChangedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupPasswordChangedImplCopyWith<$Res>
    implements $SignupPasswordChangedCopyWith<$Res> {
  factory _$$SignupPasswordChangedImplCopyWith(
          _$SignupPasswordChangedImpl value,
          $Res Function(_$SignupPasswordChangedImpl) then) =
      __$$SignupPasswordChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$SignupPasswordChangedImplCopyWithImpl<$Res>
    extends _$SignupPasswordChangedCopyWithImpl<$Res,
        _$SignupPasswordChangedImpl>
    implements _$$SignupPasswordChangedImplCopyWith<$Res> {
  __$$SignupPasswordChangedImplCopyWithImpl(_$SignupPasswordChangedImpl _value,
      $Res Function(_$SignupPasswordChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SignupPasswordChangedImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignupPasswordChangedImpl implements _SignupPasswordChanged {
  const _$SignupPasswordChangedImpl({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'SignupPasswordChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupPasswordChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of SignupPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupPasswordChangedImplCopyWith<_$SignupPasswordChangedImpl>
      get copyWith => __$$SignupPasswordChangedImplCopyWithImpl<
          _$SignupPasswordChangedImpl>(this, _$identity);
}

abstract class _SignupPasswordChanged implements SignupPasswordChanged {
  const factory _SignupPasswordChanged({required final String value}) =
      _$SignupPasswordChangedImpl;

  @override
  String get value;

  /// Create a copy of SignupPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupPasswordChangedImplCopyWith<_$SignupPasswordChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupConfirmPasswordChanged {
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of SignupConfirmPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupConfirmPasswordChangedCopyWith<SignupConfirmPasswordChanged>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupConfirmPasswordChangedCopyWith<$Res> {
  factory $SignupConfirmPasswordChangedCopyWith(
          SignupConfirmPasswordChanged value,
          $Res Function(SignupConfirmPasswordChanged) then) =
      _$SignupConfirmPasswordChangedCopyWithImpl<$Res,
          SignupConfirmPasswordChanged>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$SignupConfirmPasswordChangedCopyWithImpl<$Res,
        $Val extends SignupConfirmPasswordChanged>
    implements $SignupConfirmPasswordChangedCopyWith<$Res> {
  _$SignupConfirmPasswordChangedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupConfirmPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupConfirmPasswordChangedImplCopyWith<$Res>
    implements $SignupConfirmPasswordChangedCopyWith<$Res> {
  factory _$$SignupConfirmPasswordChangedImplCopyWith(
          _$SignupConfirmPasswordChangedImpl value,
          $Res Function(_$SignupConfirmPasswordChangedImpl) then) =
      __$$SignupConfirmPasswordChangedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$SignupConfirmPasswordChangedImplCopyWithImpl<$Res>
    extends _$SignupConfirmPasswordChangedCopyWithImpl<$Res,
        _$SignupConfirmPasswordChangedImpl>
    implements _$$SignupConfirmPasswordChangedImplCopyWith<$Res> {
  __$$SignupConfirmPasswordChangedImplCopyWithImpl(
      _$SignupConfirmPasswordChangedImpl _value,
      $Res Function(_$SignupConfirmPasswordChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupConfirmPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SignupConfirmPasswordChangedImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignupConfirmPasswordChangedImpl
    implements _SignupConfirmPasswordChanged {
  const _$SignupConfirmPasswordChangedImpl({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'SignupConfirmPasswordChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupConfirmPasswordChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of SignupConfirmPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupConfirmPasswordChangedImplCopyWith<
          _$SignupConfirmPasswordChangedImpl>
      get copyWith => __$$SignupConfirmPasswordChangedImplCopyWithImpl<
          _$SignupConfirmPasswordChangedImpl>(this, _$identity);
}

abstract class _SignupConfirmPasswordChanged
    implements SignupConfirmPasswordChanged {
  const factory _SignupConfirmPasswordChanged({required final String value}) =
      _$SignupConfirmPasswordChangedImpl;

  @override
  String get value;

  /// Create a copy of SignupConfirmPasswordChanged
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupConfirmPasswordChangedImplCopyWith<
          _$SignupConfirmPasswordChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupButtonPressed {}

/// @nodoc
abstract class $SignupButtonPressedCopyWith<$Res> {
  factory $SignupButtonPressedCopyWith(
          SignupButtonPressed value, $Res Function(SignupButtonPressed) then) =
      _$SignupButtonPressedCopyWithImpl<$Res, SignupButtonPressed>;
}

/// @nodoc
class _$SignupButtonPressedCopyWithImpl<$Res, $Val extends SignupButtonPressed>
    implements $SignupButtonPressedCopyWith<$Res> {
  _$SignupButtonPressedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupButtonPressed
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SignupButtonPressedImplCopyWith<$Res> {
  factory _$$SignupButtonPressedImplCopyWith(_$SignupButtonPressedImpl value,
          $Res Function(_$SignupButtonPressedImpl) then) =
      __$$SignupButtonPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignupButtonPressedImplCopyWithImpl<$Res>
    extends _$SignupButtonPressedCopyWithImpl<$Res, _$SignupButtonPressedImpl>
    implements _$$SignupButtonPressedImplCopyWith<$Res> {
  __$$SignupButtonPressedImplCopyWithImpl(_$SignupButtonPressedImpl _value,
      $Res Function(_$SignupButtonPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupButtonPressed
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignupButtonPressedImpl implements _SignupButtonPressed {
  const _$SignupButtonPressedImpl();

  @override
  String toString() {
    return 'SignupButtonPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupButtonPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _SignupButtonPressed implements SignupButtonPressed {
  const factory _SignupButtonPressed() = _$SignupButtonPressedImpl;
}

/// @nodoc
mixin _$SignupWithGooglePressed {}

/// @nodoc
abstract class $SignupWithGooglePressedCopyWith<$Res> {
  factory $SignupWithGooglePressedCopyWith(SignupWithGooglePressed value,
          $Res Function(SignupWithGooglePressed) then) =
      _$SignupWithGooglePressedCopyWithImpl<$Res, SignupWithGooglePressed>;
}

/// @nodoc
class _$SignupWithGooglePressedCopyWithImpl<$Res,
        $Val extends SignupWithGooglePressed>
    implements $SignupWithGooglePressedCopyWith<$Res> {
  _$SignupWithGooglePressedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupWithGooglePressed
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SignupWithGooglePressedImplCopyWith<$Res> {
  factory _$$SignupWithGooglePressedImplCopyWith(
          _$SignupWithGooglePressedImpl value,
          $Res Function(_$SignupWithGooglePressedImpl) then) =
      __$$SignupWithGooglePressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignupWithGooglePressedImplCopyWithImpl<$Res>
    extends _$SignupWithGooglePressedCopyWithImpl<$Res,
        _$SignupWithGooglePressedImpl>
    implements _$$SignupWithGooglePressedImplCopyWith<$Res> {
  __$$SignupWithGooglePressedImplCopyWithImpl(
      _$SignupWithGooglePressedImpl _value,
      $Res Function(_$SignupWithGooglePressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupWithGooglePressed
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignupWithGooglePressedImpl implements _SignupWithGooglePressed {
  const _$SignupWithGooglePressedImpl();

  @override
  String toString() {
    return 'SignupWithGooglePressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupWithGooglePressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _SignupWithGooglePressed implements SignupWithGooglePressed {
  const factory _SignupWithGooglePressed() = _$SignupWithGooglePressedImpl;
}

/// @nodoc
mixin _$SignupWithApplePressed {}

/// @nodoc
abstract class $SignupWithApplePressedCopyWith<$Res> {
  factory $SignupWithApplePressedCopyWith(SignupWithApplePressed value,
          $Res Function(SignupWithApplePressed) then) =
      _$SignupWithApplePressedCopyWithImpl<$Res, SignupWithApplePressed>;
}

/// @nodoc
class _$SignupWithApplePressedCopyWithImpl<$Res,
        $Val extends SignupWithApplePressed>
    implements $SignupWithApplePressedCopyWith<$Res> {
  _$SignupWithApplePressedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupWithApplePressed
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SignupWithApplePressedImplCopyWith<$Res> {
  factory _$$SignupWithApplePressedImplCopyWith(
          _$SignupWithApplePressedImpl value,
          $Res Function(_$SignupWithApplePressedImpl) then) =
      __$$SignupWithApplePressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignupWithApplePressedImplCopyWithImpl<$Res>
    extends _$SignupWithApplePressedCopyWithImpl<$Res,
        _$SignupWithApplePressedImpl>
    implements _$$SignupWithApplePressedImplCopyWith<$Res> {
  __$$SignupWithApplePressedImplCopyWithImpl(
      _$SignupWithApplePressedImpl _value,
      $Res Function(_$SignupWithApplePressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupWithApplePressed
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignupWithApplePressedImpl implements _SignupWithApplePressed {
  const _$SignupWithApplePressedImpl();

  @override
  String toString() {
    return 'SignupWithApplePressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupWithApplePressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _SignupWithApplePressed implements SignupWithApplePressed {
  const factory _SignupWithApplePressed() = _$SignupWithApplePressedImpl;
}
