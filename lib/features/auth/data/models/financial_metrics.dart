import 'package:equatable/equatable.dart';

enum MetricStatus { positive, moderate, concerning, critical }

class ScoreDriver extends Equatable {
  final String name;
  final double scoreValue; // The 0-100 score mapped to this driver
  final String rawDisplayValue; // e.g., "+25% YoY" or "86.2% margin"
  final MetricStatus status; // High, Medium, Low, Critical status
  final double weight; // The percentage weight of this driver

  const ScoreDriver({
    required this.name,
    required this.scoreValue,
    required this.rawDisplayValue,
    required this.status,
    required this.weight,
  });

  @override
  List<Object?> get props => [name, scoreValue, rawDisplayValue, status, weight];
}

class FinancialMetrics extends Equatable {
  // Category 1: Revenue Metrics
  final double yoyGrowth;
  final double cagr;
  final double revenuePerEmployee;

  // Category 2: Profitability Metrics
  final double expenseRatio;
  final double profitMargin;
  final double monthlyProfit;

  // Category 3: Debt & Liabilities Metrics
  final double liabilitiesToRevenueRatio;
  final double debtServiceRatio;
  final double liabilitiesPerEmployee;
  final double liabilitiesCoverageRatio;

  // Category 4: Maturity Metrics
  final int yearsOfOperation;
  final double employeesPerYear;

  // Category 5: Efficiency Metrics
  final double revenueGrowthPerEmployee;

  // Final Derived Output (The Top 5 Drivers)
  final List<ScoreDriver> rankedDrivers;

  const FinancialMetrics({
    required this.yoyGrowth,
    required this.cagr,
    required this.revenuePerEmployee,
    required this.expenseRatio,
    required this.profitMargin,
    required this.monthlyProfit,
    required this.liabilitiesToRevenueRatio,
    required this.debtServiceRatio,
    required this.liabilitiesPerEmployee,
    required this.liabilitiesCoverageRatio,
    required this.yearsOfOperation,
    required this.employeesPerYear,
    required this.revenueGrowthPerEmployee,
    required this.rankedDrivers,
  });

  @override
  List<Object?> get props => [
        yoyGrowth, cagr, revenuePerEmployee,
        expenseRatio, profitMargin, monthlyProfit,
        liabilitiesToRevenueRatio, debtServiceRatio, liabilitiesPerEmployee, liabilitiesCoverageRatio,
        yearsOfOperation, employeesPerYear, revenueGrowthPerEmployee,
        rankedDrivers,
      ];
}