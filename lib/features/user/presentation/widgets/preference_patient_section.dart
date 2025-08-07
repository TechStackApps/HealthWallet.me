import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/core/theme/app_insets.dart';
import 'package:health_wallet/core/theme/app_text_style.dart';
import 'package:health_wallet/core/utils/build_context_extension.dart';
import 'package:health_wallet/features/records/domain/entity/patient/patient.dart';
import 'package:health_wallet/features/records/domain/factory/entity_factories/patient_entity_display_factory.dart';
import 'package:health_wallet/features/user/presentation/bloc/user_bloc.dart';
import 'package:health_wallet/features/user/presentation/widgets/animated_reorderable_list.dart';
import 'package:health_wallet/gen/assets.gen.dart';

/// PreferencePatientSection widget that displays a list of patients.
class PreferencePatientSection extends StatefulWidget {
  const PreferencePatientSection({super.key});

  @override
  State<PreferencePatientSection> createState() =>
      _PreferencePatientSectionState();
}

class _PreferencePatientSectionState extends State<PreferencePatientSection> {
  final _patientFactory = PatientEntityDisplayFactory();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(const UserPatientsLoaded());
    });
  }

  void _handlePatientTap(String patientId) {
    final currentState = context.read<UserBloc>().state;
    final isCurrentlyExpanded =
        currentState.expandedPatientIds.contains(patientId);

    if (isCurrentlyExpanded) {
      return;
    }

    context.read<UserBloc>().add(UserPatientReorder(patientId));
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = context.theme.dividerColor;
    final iconColor = context.isDarkMode
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final patients = state.patients;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Patient',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Assets.icons.information.svg(
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: Insets.extraSmall),
                      Text(
                        'Tap to select patient',
                        style: AppTextStyle.labelMedium.copyWith(
                          color: iconColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Insets.small),
              if (patients.isNotEmpty) ...[
                AnimatedReorderableList<Patient>(
                  items: patients,
                  itemKey: (patient) => patient.id,
                  isBeingMoved: (patient) =>
                      state.animationPhase == PatientAnimationPhase.swapping &&
                      state.swappingFromPatientId == patient.id,
                  cardHeight: 120.0,
                  spacing: Insets.small,
                  itemBuilder: (context, patient, index) {
                    final isAnimating = state.animatingPatientId == patient.id;
                    final isCollapsing =
                        state.collapsingPatientId == patient.id;
                    final isExpanding = state.expandingPatientId == patient.id;

                    return GestureDetector(
                      key: ValueKey(patient.id),
                      onTap: () {
                        _handlePatientTap(patient.id);
                      },
                      child: _UnifiedPatientCard(
                        patient: patient,
                        index: index,
                        patientFactory: _patientFactory,
                        borderColor: borderColor,
                        iconColor: iconColor,
                        textColor: textColor,
                        isCollapsing: isCollapsing,
                        isExpanding: isExpanding,
                        isAnimating: isAnimating,
                      ),
                    );
                  },
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(Insets.small),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Assets.icons.user.svg(
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: Insets.small),
                      Text(
                        'No patients found',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: Insets.small),
            ],
          ),
        );
      },
    );
  }
}

class _UnifiedPatientCard extends StatelessWidget {
  final Patient patient;
  final int index;
  final PatientEntityDisplayFactory patientFactory;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final bool isCollapsing;
  final bool isExpanding;
  final bool isAnimating;

  const _UnifiedPatientCard({
    required this.patient,
    required this.index,
    required this.patientFactory,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
    required this.isCollapsing,
    required this.isExpanding,
    required this.isAnimating,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded =
        context.read<UserBloc>().state.expandedPatientIds.contains(patient.id);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
      padding: const EdgeInsets.all(Insets.small),
      margin: const EdgeInsets.only(bottom: Insets.small),
      transform: Matrix4.identity()..scale(isExpanding ? 1.02 : 1.0),
      decoration: BoxDecoration(
        color: _getCardColor(context),
        border: Border.all(color: _getBorderColor(context)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: _getBoxShadow(context),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: borderColor,
                    child: Assets.icons.user.svg(
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: Insets.small),
                  Text(
                    patientFactory.extractPrimaryDisplay(patient),
                    style: AppTextStyle.bodySmall.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
              AnimatedRotation(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                turns: _getRotationTurns(context),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: textColor,
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: Duration(milliseconds: isExpanding ? 1200 : 800),
            curve: Curves.easeInOutCubic,
            child: (isExpanded || isExpanding)
                ? Column(
                    children: [
                      const SizedBox(height: Insets.small),
                      Container(
                        height: 1,
                        color: textColor.withValues(alpha: 0.1),
                      ),
                      const SizedBox(height: Insets.small),
                      AnimatedOpacity(
                        duration: Duration(
                            milliseconds:
                                isExpanding ? 400 : (isCollapsing ? 600 : 200)),
                        opacity: (isExpanding || isCollapsing) ? 0.0 : 1.0,
                        child: Column(
                          children: [
                            _buildPatientInfoRow(
                              context,
                              Assets.icons.identification.svg(
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  iconColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              'ID: ${patientFactory.extractPatientId(patient)}',
                            ),
                            _buildPatientInfoRow(
                              context,
                              Assets.icons.calendar.svg(
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  iconColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              'Age: ${patientFactory.extractPatientAge(patient)}',
                            ),
                          ],
                        ),
                      ),
                      AnimatedOpacity(
                        duration: Duration(
                            milliseconds:
                                isExpanding ? 600 : (isCollapsing ? 400 : 300)),
                        opacity: (isExpanding || isCollapsing) ? 0.0 : 1.0,
                        child: Column(
                          children: [
                            _buildPatientInfoRow(
                              context,
                              Assets.icons.genderMale.svg(
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  iconColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              'Gender: ${patientFactory.extractPatientGender(patient)}',
                            ),
                            _buildPatientInfoRow(
                              context,
                              Assets.icons.drop.svg(
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  iconColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              'Blood type: ${patientFactory.extractBloodType(patient)}',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Insets.small),
                      AnimatedOpacity(
                        duration: Duration(
                            milliseconds:
                                isExpanding ? 800 : (isCollapsing ? 200 : 400)),
                        opacity: (isExpanding || isCollapsing) ? 0.0 : 1.0,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Edit patient details
                            },
                            icon: Assets.icons.edit.svg(
                              width: 16,
                              height: 16,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            label: const Text(
                              'Edit details',
                              style: AppTextStyle.buttonSmall,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Insets.small,
                                vertical: Insets.small,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Color _getCardColor(BuildContext context) {
    if (isCollapsing) return Colors.transparent;
    if (isExpanding) return AppColors.primary.withValues(alpha: 0.05);
    if (context
        .read<UserBloc>()
        .state
        .expandedPatientIds
        .contains(patient.id)) {
      return AppColors.primary.withValues(alpha: 0.1);
    }
    if (isAnimating) return AppColors.primary.withValues(alpha: 0.15);
    return Colors.transparent;
  }

  Color _getBorderColor(BuildContext context) {
    if (isCollapsing) return borderColor;
    if (isExpanding) return AppColors.primary.withValues(alpha: 0.5);
    if (context
        .read<UserBloc>()
        .state
        .expandedPatientIds
        .contains(patient.id)) {
      return AppColors.primary;
    }
    if (isAnimating) return AppColors.primary.withValues(alpha: 0.5);
    return borderColor;
  }

  List<BoxShadow> _getBoxShadow(BuildContext context) {
    if (isCollapsing) return [];
    if (isExpanding) {
      return [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];
    }
    if (context
        .read<UserBloc>()
        .state
        .expandedPatientIds
        .contains(patient.id)) {
      return [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
    }
    if (isAnimating) {
      return [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.2),
          blurRadius: 8,
          offset: const Offset(0, 1),
        ),
      ];
    }
    return [
      BoxShadow(
        color: borderColor.withValues(alpha: 0.1),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ];
  }

  double _getRotationTurns(BuildContext context) {
    if (context
        .read<UserBloc>()
        .state
        .expandedPatientIds
        .contains(patient.id)) {
      return 0.5;
    }
    return 0.0;
  }

  Widget _buildPatientInfoRow(BuildContext context, Widget icon, String text) {
    final textColor =
        context.isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;

    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.small),
      child: Row(
        children: [
          icon,
          const SizedBox(width: Insets.smaller),
          Text(
            text,
            style: AppTextStyle.labelLarge.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
