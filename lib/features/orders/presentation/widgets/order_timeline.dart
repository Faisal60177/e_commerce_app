import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_status.dart';
import 'package:e_commerce_app/features/orders/presentation/order_status_style.dart';
import 'package:flutter/material.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({required this.order, super.key});
  final Order order;

@override
Widget build(BuildContext context) {
  final cancelled = order.status == OrderStatus.cancelled;
  final steps = cancelled
  ? const [OrderStatus.pending, OrderStatus.cancelled]
      : OrderStatus.progress;

  return Column(
    children: [
      for(var i = 0; i< steps.length; i++)
        _TimelineStep(
            status: steps[i],
            reached: cancelled || steps[i].index <= order.status.index,
            isCurrent: steps[i] == order.status,
            isLast: i == steps.length - 1,
            time: order.timeFor(steps[i]),
        )
    ],
  );


}
}

class _TimelineStep extends StatelessWidget{
  const _TimelineStep({
    required this.status,
    required this.reached,
    required this.isCurrent,
    required this.isLast,
    required this.time,
  });


  final OrderStatus status;
  final bool reached;
  final bool isCurrent;
  final bool isLast;
  final DateTime? time;

@override
Widget build(BuildContext context) {
  final colors = context.colors;
  final color = status.color(context);

  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: .stretch,
      children: [
        SizedBox(width: 32,
        child: Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: .circle,
                color: reached ? color : colors.surfaceContainerHighest,
              ),
              child: Icon(
                status.icon,
                size: 16,
                color: reached ? Colors.white : colors.outline,
              ),
            ),
            if(!isLast)
              Expanded(child: Center(
                child: Container(
                  width: 2,
                  color: reached ? color : colors.outlineVariant,
                ),
              ))
          ],
        ),),
        const SizedBox(width: 12,),
        Expanded(child: Padding(padding: .only(bottom: isLast ? 0 : 20, top: 4),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              status.timelineTitle,
              style: context.textTheme.titleSmall?.copyWith(
                color: reached ? null : colors.outline,
                fontWeight: isCurrent ? FontWeight.w800 : null,
              ),
            ),
            if(reached && time != null)
              Text(
                Formatters.dateTime(time!),
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              )
          ],
        ),))
      ],
    ),
  );
}
}