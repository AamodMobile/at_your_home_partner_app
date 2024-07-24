import 'package:at_your_home_partner/constants/colors.dart';
import 'package:at_your_home_partner/core/common_widgets/vertical_calender/utils/date_models.dart';
import 'package:at_your_home_partner/core/common_widgets/vertical_calender/utils/date_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';



enum PaginationDirection {
  up,
  down,
}

class VerticalCalendar extends StatefulWidget {
  VerticalCalendar({
    super.key,
    this.minDate,
    this.maxDate,
    DateTime? initialDate,
    this.monthBuilder,
    this.dayBuilder,
    this.addAutomaticKeepAlives = false,
    this.onDayPressed,
    this.onMonthLoaded,
    this.onPaginationCompleted,
    this.invisibleMonthsThreshold = 1,
    this.physics,
    this.scrollController,
    this.listPadding = EdgeInsets.zero,
    this.startWeekWithSunday = true,
    this.weekdaysToHide = const [], this.indicatorWidget,
  }) : initialDate = initialDate ?? DateTime.now().removeTime();

  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime initialDate;
  final MonthBuilder? monthBuilder;
  final DayBuilder? dayBuilder;
  final bool addAutomaticKeepAlives;
  final ValueChanged<DateTime>? onDayPressed;
  final OnMonthLoaded? onMonthLoaded;
  final ValueChanged<PaginationDirection>? onPaginationCompleted;
  final int invisibleMonthsThreshold;
  final EdgeInsets listPadding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final bool startWeekWithSunday;
  final List<int> weekdaysToHide;
  final Widget? indicatorWidget;
  @override
  State<VerticalCalendar> createState() => _VerticalCalendarState();
}

class _VerticalCalendarState extends State<VerticalCalendar> {
  late PagingController<int, Month> _pagingReplyUpController;
  late PagingController<int, Month> _pagingReplyDownController;

  final Key downListKey = UniqueKey();
  late bool hideUp;

  @override
  void initState() {
    super.initState();

    if (widget.minDate != null &&
        widget.initialDate.isBefore(widget.minDate!)) {
      throw ArgumentError("initialDate cannot be before minDate");
    }

    if (widget.maxDate != null && widget.initialDate.isAfter(widget.maxDate!)) {
      throw ArgumentError("initialDate cannot be after maxDate");
    }

    hideUp = !(widget.minDate == null ||
        !widget.minDate!.isSameMonth(widget.initialDate));

    _pagingReplyUpController = PagingController<int, Month>(
      firstPageKey: 0,
      invisibleItemsThreshold: widget.invisibleMonthsThreshold,
    );
    _pagingReplyUpController.addPageRequestListener(_fetchUpPage);
    _pagingReplyUpController.addStatusListener(paginationStatusUp);

    _pagingReplyDownController = PagingController<int, Month>(
      firstPageKey: 0,
      invisibleItemsThreshold: widget.invisibleMonthsThreshold,
    );
    _pagingReplyDownController.addPageRequestListener(_fetchDownPage);
    _pagingReplyDownController.addStatusListener(paginationStatusDown);
  }

  @override
  void didUpdateWidget(covariant VerticalCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.minDate != oldWidget.minDate) {
      _pagingReplyUpController.refresh();

      hideUp = !(widget.minDate == null ||
          !widget.minDate!.isSameMonth(widget.initialDate));
    }
  }

  void paginationStatusUp(PagingStatus state) {
    if (state == PagingStatus.completed) {
      return widget.onPaginationCompleted?.call(PaginationDirection.up);
    }
  }

  void paginationStatusDown(PagingStatus state) {
    if (state == PagingStatus.completed) {
      return widget.onPaginationCompleted?.call(PaginationDirection.down);
    }
  }

  void _fetchUpPage(int pageKey) async {
    try {
      final month = DateUtils.getMonth(
        DateTime(widget.initialDate.year, widget.initialDate.month - 1, 1),
        widget.minDate,
        pageKey,
        true,
        startWeekWithSunday: widget.startWeekWithSunday,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onMonthLoaded?.call(month.year, month.month),
      );

      final newItems = [month];
      final isLastPage = widget.minDate != null &&
          widget.minDate!.isSameDayOrAfter(month.weeks.first.firstDay);

      if (isLastPage) {
        return _pagingReplyUpController.appendLastPage(newItems);
      }

      final nextPageKey = pageKey + newItems.length;
      _pagingReplyUpController.appendPage(newItems, nextPageKey);
    } catch (_) {
      _pagingReplyUpController.error;
    }
  }

  void _fetchDownPage(int pageKey) async {
    try {
      final month = DateUtils.getMonth(
        DateTime(widget.initialDate.year, widget.initialDate.month, 1),
        widget.maxDate,
        pageKey,
        false,
        startWeekWithSunday: widget.startWeekWithSunday,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onMonthLoaded?.call(month.year, month.month),
      );

      final newItems = [month];
      final isLastPage = widget.maxDate != null &&
          widget.maxDate!.isSameDayOrBefore(month.weeks.last.lastDay);

      if (isLastPage) {
        return _pagingReplyDownController.appendLastPage(newItems);
      }

      final nextPageKey = pageKey + newItems.length;
      _pagingReplyDownController.appendPage(newItems, nextPageKey);
    } catch (_) {
      _pagingReplyDownController.error;
    }
  }

  EdgeInsets _getDownListPadding() {
    final double paddingTop = hideUp ? widget.listPadding.top : 0;
    return EdgeInsets.fromLTRB(widget.listPadding.left, paddingTop,
        widget.listPadding.right, widget.listPadding.bottom);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...[
                "Sun",
                "Mon",
                "Tue",
                "Wed",
                "Thu",
                "Fri",
                "Sat"
              ].map((e) => Text(
                    e,
                    style: TextStyle(
                        fontSize: 15,
                        color:
                            e[0] == "S" ? Colors.red[600] : blackCl,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
        Expanded(
          child: Scrollable(
            controller: widget.scrollController,
            physics: widget.physics,
            viewportBuilder: (BuildContext context, ViewportOffset position) {
              return Viewport(
                offset: position,
                center: downListKey,
                slivers: [
                  if (!hideUp)
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(widget.listPadding.left,
                          widget.listPadding.top, widget.listPadding.right, 0),
                      sliver: PagedSliverList(
                        pagingController: _pagingReplyUpController,
                        builderDelegate: PagedChildBuilderDelegate<Month>(
                          itemBuilder:
                              (BuildContext context, Month month, int index) {
                            return _MonthView(
                              month: month,
                              monthBuilder: widget.monthBuilder,
                              dayBuilder: widget.dayBuilder,
                              onDayPressed: widget.onDayPressed,
                              startWeekWithSunday: widget.startWeekWithSunday,
                              weekDaysToHide: widget.weekdaysToHide,
                              indicatorWidget: widget.indicatorWidget,
                            );
                          },
                        ),
                      ),
                    ),
                  SliverPadding(
                    key: downListKey,
                    padding: _getDownListPadding(),
                    sliver: PagedSliverList(
                      pagingController: _pagingReplyDownController,
                      builderDelegate: PagedChildBuilderDelegate<Month>(
                        itemBuilder:
                            (BuildContext context, Month month, int index) {
                          return _MonthView(
                              month: month,
                              monthBuilder: widget.monthBuilder,
                              dayBuilder: widget.dayBuilder,
                              onDayPressed: widget.onDayPressed,
                              startWeekWithSunday: widget.startWeekWithSunday,
                              weekDaysToHide: widget.weekdaysToHide,
                              indicatorWidget: widget.indicatorWidget,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingReplyUpController.dispose();
    _pagingReplyDownController.dispose();
    super.dispose();
  }
}

class _MonthView extends StatelessWidget {
  const _MonthView({
    required this.month,
    this.monthBuilder,
    this.dayBuilder,
    this.onDayPressed,
    required this.weekDaysToHide,
    required this.startWeekWithSunday,
    this.indicatorWidget,
  });

  final Month month;
  final MonthBuilder? monthBuilder;
  final DayBuilder? dayBuilder;
  final ValueChanged<DateTime>? onDayPressed;
  final bool startWeekWithSunday;
  final List<int> weekDaysToHide;
  final Widget? indicatorWidget;

  @override
  Widget build(BuildContext context) {
    /// if we have weekDaysToHide we need to replace those dates with blank spaces
    final validDates = DateUtils.listOfValidDatesInMonth(month, weekDaysToHide);
    final blankSpaces = DateUtils.getNoOfSpaceRequiredBeforeFirstValidDate(
      weekDaysToHide,
      validDates.isNotEmpty ? validDates.first.weekday : 0,
      startWeekWithSunday,
    );

    return Column(
      children: <Widget>[
        /// display the default month header if none is provided
        Row(
          children: [
            monthBuilder?.call(context, month.month, month.year) ??
                _DefaultMonthView(
                  month: month.month,
                  year: month.year,
                ),
          ],
        ),
        GridView.builder(
          addRepaintBoundaries: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.2,
            crossAxisCount: DateTime.daysPerWeek - weekDaysToHide.length,
          ),
          itemCount: validDates.length + blankSpaces,
          itemBuilder: (BuildContext context, int index) {
            if (index < blankSpaces) return const SizedBox();
            final date = validDates[index - blankSpaces];
            return InkWell(
              onTap: onDayPressed == null ? null : () => onDayPressed!(date),
              child: dayBuilder?.call(context, date) ??
                  _DefaultDayView(date: date),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _DefaultMonthView extends StatelessWidget {
  final int month;
  final int year;

  _DefaultMonthView({required this.month, required this.year});

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
      ),
      child: Text(
        '${months[month - 1]} $year',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _DefaultDayView extends StatelessWidget {
  final DateTime date;

  const _DefaultDayView({required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        date.day.toString(),
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: date.removeTime().compareTo(DateTime.now().removeTime()) == 0
                ? Colors.blue[800]
                : date.removeTime().compareTo(DateTime.now().removeTime()) == -1
                    ? Colors.grey
                    : date.weekday >= 6
                        ? Colors.red[600]
                        : blackCl),
      ),
    );
  }
}

typedef MonthBuilder = Widget Function(
    BuildContext context, int month, int year);
typedef DayBuilder = Widget? Function(BuildContext context, DateTime date);

typedef OnMonthLoaded = void Function(int year, int month);
