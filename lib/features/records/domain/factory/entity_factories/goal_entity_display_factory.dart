import 'package:health_wallet/features/records/domain/entity/goal/goal.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for Goal resources
class GoalEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Goal';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final goal = entity as Goal;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            goal.description);
    if (displayText != null) return displayText;

    return 'Goal ${goal.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final goal = entity as Goal;

    final lifecycleStatus = goal.lifecycleStatus?.toString();
    final achievementStatus = goal.achievementStatus?.toString();

    return BaseEntityDisplayFactory.joinNonNull(
        [lifecycleStatus, achievementStatus], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final goal = entity as Goal;
    return goal.lifecycleStatus?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Goals don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Simplified for now (startX is complex union type)
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final goal = entity as Goal;
    final additionalInfo = <String>[];

    // Lifecycle Status
    final lifecycleStatus = goal.lifecycleStatus?.toString();
    if (lifecycleStatus != null) {
      additionalInfo.add('Status: $lifecycleStatus');
    }

    // Achievement Status
    final achievementStatus = goal.achievementStatus?.toString();
    if (achievementStatus != null) {
      additionalInfo.add('Achievement: $achievementStatus');
    }

    // Start Date - simplified for now (startX is complex union type)
    // final startDate = goal.startX?.toString();
    // if (startDate != null) {
    //   additionalInfo.add('Start: $startDate');
    // }

    // Target Date
    final targetDate = goal.target?.firstOrNull?.dueDate?.toString();
    if (targetDate != null) {
      additionalInfo.add('Target: $targetDate');
    }

    // Priority
    final priority = goal.priority?.toString();
    if (priority != null) {
      additionalInfo.add('Priority: $priority');
    }

    return additionalInfo;
  }
}
