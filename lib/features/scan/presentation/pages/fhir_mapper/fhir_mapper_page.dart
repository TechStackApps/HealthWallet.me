import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FhirMapperPage extends StatefulWidget {
  const FhirMapperPage({super.key});

  @override
  State<FhirMapperPage> createState() => _FhirMapperPageState();
}

class _FhirMapperPageState extends State<FhirMapperPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class MappingResultPage extends StatelessWidget {
//   const MappingResultPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     FhirMapperState state = context.watch<FhirMapperBloc>().state;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Review resources", style: AppTextStyle.titleMedium),
//       ),
//       body: Padding(
//         padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
//         child: ListView.builder(
//           itemCount: state.resources.length,
//           itemBuilder: (context, index) {
//             MappingResource resource = state.resources[index];
//             Map<String, TextFieldDescriptor> textFields =
//                 resource.getFieldDescriptors();

//             return Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                       color: AppColors.primary.withValues(alpha: 0.6))),
//               margin: const EdgeInsets.only(bottom: 24),
//               child: Padding(
//                 padding: const EdgeInsetsGeometry.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(resource.label, style: AppTextStyle.bodyLarge),
//                     const SizedBox(height: 24),
//                     ...textFields.entries.map((entry) {
//                       final propertyKey = entry.key;
//                       final descriptor = entry.value;
//                       final borderColor = switch (descriptor.confidenceLevel) {
//                         < 0.6 => Colors.red,
//                         >= 0.6 && < 0.8 => Colors.yellow,
//                         _ => AppColors.border,
//                       };
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         key: ValueKey('${index}_$propertyKey'),
//                         children: [
//                           Text(descriptor.label, style: AppTextStyle.bodySmall),
//                           const SizedBox(height: 4),
//                           TextFormField(
//                             initialValue: descriptor.value,
//                             validator: descriptor.validate,
//                             inputFormatters: descriptor.inputFormatters,
//                             keyboardType: descriptor.keyboardType,
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             style: AppTextStyle.labelLarge,
//                             onChanged: (value) => context
//                                 .read<FhirMapperBloc>()
//                                 .add(FhirMapperResourceChanged(
//                                   index: index,
//                                   propertyKey: propertyKey,
//                                   newValue: value,
//                                 )),
//                             decoration: InputDecoration(
//                               isDense: true,
//                               helperText: ' ',
//                               helperStyle:
//                                   const TextStyle(height: 0, fontSize: 0),
//                               disabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: borderColor),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: borderColor),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: borderColor),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(color: Colors.red),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               focusedErrorBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                     color: Colors.red, width: 1.5),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 10),
//                             ),
//                           ),
//                           if (entry.key != textFields.entries.last.key)
//                             const SizedBox(height: 16),
//                         ],
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
