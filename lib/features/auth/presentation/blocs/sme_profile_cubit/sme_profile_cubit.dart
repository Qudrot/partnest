import 'package:flutter/foundation.dart';
import 'package:csv/csv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sme_profile_state.dart';

class SmeProfileCubit extends Cubit<SmeProfileState> {
  SmeProfileCubit() : super(const SmeProfileState());

  void updateBusinessProfile({
    required String businessName,
    required String industry,
    required String location,
    required int yearsOfOperation,
    required int numberOfEmployees,
  }) {
    emit(state.copyWith(
      businessName: businessName,
      industry: industry,
      location: location,
      yearsOfOperation: yearsOfOperation,
      numberOfEmployees: numberOfEmployees,
    ));
  }

  void updateRevenueExpenses({
    required int annualRevenueYear1,
    required double annualRevenueAmount1,
    required int annualRevenueYear2,
    required double annualRevenueAmount2,
    int? annualRevenueYear3,
    double? annualRevenueAmount3,
    double? monthlyAvgRevenue,
    required double monthlyAvgExpenses,
    String? documentFileName,
  }) {
    emit(state.copyWith(
      annualRevenueYear1: annualRevenueYear1,
      annualRevenueAmount1: annualRevenueAmount1,
      annualRevenueYear2: annualRevenueYear2,
      annualRevenueAmount2: annualRevenueAmount2,
      annualRevenueYear3: annualRevenueYear3,
      annualRevenueAmount3: annualRevenueAmount3,
      monthlyAvgRevenue: monthlyAvgRevenue,
      monthlyAvgExpenses: monthlyAvgExpenses,
      documentFileName: documentFileName,
    ));
  }

  void updateLiabilitiesHistory({
    required double totalLiabilities,
    required double outstandingLoans,
    bool? hasPriorFunding,
    double? priorFundingAmount,
    String? priorFundingSource,
    int? fundingYear,
    String? repaymentHistory,
  }) {
    emit(state.copyWith(
      totalLiabilities: totalLiabilities,
      outstandingLoans: outstandingLoans,
      hasPriorFunding: hasPriorFunding,
      priorFundingAmount: priorFundingAmount,
      priorFundingSource: priorFundingSource,
      fundingYear: fundingYear,
      repaymentHistory: repaymentHistory,
    ));
  }

  void updateFromMap(Map<String, dynamic> map) {
    emit(SmeProfileState.fromMap(map));
  }

  Future<void> processCsv(String csvString, String fileName) async {
    emit(state.copyWith(
      csvProcessingStatus: CsvProcessingStatus.processing,
      csvErrorMessage: null,
      documentFileName: fileName,
    ));

    try {
      final result = await compute(_parseCsvIsolate, csvString);

      if (result.containsKey('error')) {
        emit(state.copyWith(
          csvProcessingStatus: CsvProcessingStatus.error,
          csvErrorMessage: result['error'].toString(),
        ));
        return;
      }

      final yearlyRevMap = result['yearlyRevenue'] as Map<int, double>;
      final sortedYears = yearlyRevMap.keys.toList()..sort((a, b) => b.compareTo(a)); // Descending
      
      int y1 = DateTime.now().year;
      double a1 = 0.0;
      int y2 = DateTime.now().year - 1;
      double a2 = 0.0; // Defaults to 0 if CSV only has 1 year of data!
      
      if (sortedYears.isNotEmpty) {
        y1 = sortedYears[0];
        a1 = yearlyRevMap[y1]!;
        if (sortedYears.length > 1) {
          y2 = sortedYears[1];
          a2 = yearlyRevMap[y2]!;
        } else {
          y2 = y1 - 1;
        }
      }
      
      // Calculate realistic monthly expenses based on rows of data
      double mths = result['estimatedMonths'] as double;
      if (mths < 1) mths = 1;
      double monthlyExp = (result['totalExpenses'] as double) / mths;

      emit(state.copyWith(
        annualRevenueYear1: y1,
        annualRevenueAmount1: a1,
        annualRevenueYear2: y2,
        annualRevenueAmount2: a2, 
        monthlyAvgExpenses: monthlyExp,
        totalLiabilities: (result['totalDebt'] as double),
        outstandingLoans: (result['totalDebt'] as double),
        priorFundingSource: "Extracted from CSV",
        onTimePayments: 12, 
        latePayments: 0,
        numDocumentsSubmitted: 1, 
        areDocumentsRecent: true,
        areDocumentsComplete: true,
        areDocumentsConsistent: true,
        csvProcessingStatus: CsvProcessingStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        csvProcessingStatus: CsvProcessingStatus.error,
        csvErrorMessage: e.toString(),
      ));
    }
  }

  // --- THE BULLETPROOF PARSER HELPER ---
  static double _sanitizeAmount(String rawValue) {
    if (rawValue.isEmpty) return 0.0;

    // 1. Remove commas, spaces, and currency symbols
    String cleanString = rawValue
        .replaceAll(',', '')
        .replaceAll(' ', '')
        .replaceAll('₦', '')
        .replaceAll('N', '')
        .trim();

    // 2. Parse it safely (defaults to 0.0 if it's text)
    double parsedValue = double.tryParse(cleanString) ?? 0.0;

    // 3. FORCE ABSOLUTE VALUE to prevent negative debits from ruining the math
    return parsedValue.abs(); 
  }

  static Map<String, dynamic> _parseCsvIsolate(String csvString) {
    try {
      // Decode the raw CSV string
      final rows = CsvCodec().decoder.convert(csvString);
      if (rows.isEmpty) return {'error': 'The uploaded file appears to be empty.'};

      int headerRowIndex = -1;
      int creditIdx = -1, debitIdx = -1, descIdx = -1, dateIdx = -1;

      // 1. Find the Headers
      for (int i = 0; i < rows.length; i++) {
        final rowStrs = rows[i].map((e) => e.toString().toLowerCase()).toList();
        if (rowStrs.any((s) => s.contains("credit") || s.contains("deposit")) ||
            rowStrs.any((s) => s.contains("debit") || s.contains("withdrawal"))) {
          headerRowIndex = i;
          for (int j = 0; j < rowStrs.length; j++) {
            if (rowStrs[j].contains("credit") || rowStrs[j].contains("deposit")) creditIdx = j;
            else if (rowStrs[j].contains("debit") || rowStrs[j].contains("withdrawal")) debitIdx = j;
            else if (rowStrs[j].contains("narration") || rowStrs[j].contains("desc") || rowStrs[j].contains("details")) descIdx = j;
            else if (rowStrs[j].contains("date") || rowStrs[j].contains("time")) dateIdx = j;
          }
          break;
        }
      }

      if (headerRowIndex == -1 || (creditIdx == -1 && debitIdx == -1)) {
        return {'error': 'We couldn\'t recognize the bank statement format. Please ensure it\'s a standard CSV export.'};
      }

      Map<int, double> yearlyRevenue = {};
      double totalExpenses = 0.0;
      double totalDebt = 0.0;
      int fallbackYear = DateTime.now().year;

      // 2. Extract Data Grouped By Year (Using Bulletproof Parser)
      for (int i = headerRowIndex + 1; i < rows.length; i++) {
        final row = rows[i];
        int rowYear = fallbackYear;

        // Smart Date Extraction
        if (dateIdx != -1 && dateIdx < row.length) {
          String dateStr = row[dateIdx].toString();
          final match4 = RegExp(r'\b(20\d{2})\b').firstMatch(dateStr);
          if (match4 != null) {
            rowYear = int.parse(match4.group(1)!);
          } else {
            final match2 = RegExp(r'[/-](\d{2})(?:\s|$)').firstMatch(dateStr);
            if (match2 != null) {
              rowYear = 2000 + int.parse(match2.group(1)!);
            }
          }
        }

        // Credit / Revenue Extraction
        if (creditIdx != -1 && creditIdx < row.length) {
          final val = _sanitizeAmount(row[creditIdx].toString());
          if (val > 0) {
            yearlyRevenue[rowYear] = (yearlyRevenue[rowYear] ?? 0.0) + val;
          }
        }

        // Debit / Expenses & Debt Extraction
        if (debitIdx != -1 && debitIdx < row.length) {
          final val = _sanitizeAmount(row[debitIdx].toString());
          if (val > 0) {
            totalExpenses += val;
            
            if (descIdx != -1 && descIdx < row.length) {
              final desc = row[descIdx].toString().toLowerCase();
              if (desc.contains("loan") || desc.contains("repayment") || desc.contains("carbon") || desc.contains("fairmoney") || desc.contains("branch")) {
                totalDebt += val;
              }
            }
          }
        }
      }
      
      return {
        'yearlyRevenue': yearlyRevenue,
        'totalExpenses': totalExpenses,
        'totalDebt': totalDebt,
        'estimatedMonths': (rows.length - headerRowIndex) / 30, // rough assumption of 1 trans per day
      };
    } catch(e) {
      return {'error': 'We encountered an issue processing this file. Please try again or use a different statement.'};
    }
  }
  
  void reset() {
    emit(const SmeProfileState());
  }
}