// lib/core/utils/date_formatter.dart

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

/// Utility class for date and time formatting and operations.
/// 
/// Contains both formatting methods, date utility functions,
/// and real-time stream functionality for live updates.
class DateFormatter {
  DateFormatter._();

  // =============================================================================
  // REAL-TIME STREAM FUNCTIONALITY
  // =============================================================================
  
  static final BehaviorSubject<DateTime> _currentTime = BehaviorSubject<DateTime>();
  static Timer? _timer;

  /// Stream that emits current time every second
  static Stream<DateTime> get currentTimeStream => _currentTime.stream;

  /// Initialize the real-time timer (call once in main.dart)
  static void initialize() {
    _currentTime.add(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime.add(DateTime.now());
    });
  }

  /// Dispose the timer and stream (call in app disposal)
  static void dispose() {
    _timer?.cancel();
    _currentTime.close();
  }
  
  // =============================================================================
  // FORMATTING METHODS
  // =============================================================================
  
  /// Returns formatted current date with day name
  /// Format: "Jan 15, 2024 - Monday"
  static String getFormattedCurrentDateWithDay() {
    return DateFormat('MMM dd, yyyy - EEEE').format(DateTime.now());
  }

  /// Returns formatted current date
  /// Format: "Jan 15, 2024"
  static String getFormattedCurrentDate() {
    return DateFormat('MMM dd, yyyy').format(DateTime.now());
  }

  /// Returns formatted time from DateTime
  /// Format: "02:30" or "--:--" if null
  static String getFormattedTime(DateTime? time) {
    return time != null ? DateFormat('hh:mm').format(time) : '--:--';
  }

  /// Returns formatted time for Waqt view
  /// Format: "02:30" or "--:--" if null
  static String getFormattedTimeForWaqtView(DateTime? time) {
    return time != null ? DateFormat('hh:mm').format(time) : '--:--';
  }

  /// Returns formatted time with AM/PM for fasting
  /// Format: "02:30 AM" or "--:--" if null
  static String getFormattedTimeForFasting(DateTime? time) {
    return time != null ? DateFormat('hh:mm a').format(time) : '--:--';
  }

  /// Returns formatted date with custom format
  /// Default format: "Jan 15, 2024"
  static String getFormattedDate(DateTime? date, {String format = 'MMM dd, yyyy'}) {
    if (date == null) return '';
    return DateFormat(format).format(date);
  }

  /// Returns formatted duration
  /// Format: "2h 30m" or "--:--" if null
  static String getFormattedDuration(Duration? duration) {
    if (duration == null) return '--:--';
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
  }

  // =============================================================================
  // DATE UTILITY METHODS
  // =============================================================================

  /// Returns current DateTime
  static DateTime get now => DateTime.now();

  /// Returns current date (without time)
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Checks if the given date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  /// Checks if the given date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
           date.month == yesterday.month &&
           date.day == yesterday.day;
  }

  /// Checks if the given date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
           date.month == tomorrow.month &&
           date.day == tomorrow.day;
  }

  /// Returns start of day (00:00:00)
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Returns end of day (23:59:59)
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Returns the number of days between two dates
  static int daysBetween(DateTime start, DateTime end) {
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);
    return endDate.difference(startDate).inDays;
  }

  /// Checks if a date is in the same week as today
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
           date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Checks if a date is in the same month as today
  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Checks if a date is in the same year as today
  static bool isThisYear(DateTime date) {
    return date.year == DateTime.now().year;
  }

  /// Returns relative time string (e.g., "2 hours ago", "Tomorrow")
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (isToday(date)) {
      if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      } else {
        return 'Just now';
      }
    }

    if (isYesterday(date)) {
      return 'Yesterday';
    }

    if (isTomorrow(date)) {
      return 'Tomorrow';
    }

    if (difference.inDays.abs() < 7) {
      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      } else {
        return 'In ${difference.inDays.abs()} day${difference.inDays.abs() == 1 ? '' : 's'}';
      }
    }

    return getFormattedDate(date);
  }
}
