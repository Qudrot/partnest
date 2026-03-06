/// Partnex Unit Test Suite
/// Tests core business logic in SmeProfileCubit, SmeProfileState,
/// SmeCardData model, and DiscoveryState — using only flutter_test.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:partnex/features/auth/presentation/blocs/sme_profile_cubit/sme_profile_cubit.dart';
import 'package:partnex/features/auth/presentation/blocs/sme_profile_cubit/sme_profile_state.dart';
import 'package:partnex/features/auth/data/models/sme_profile_data.dart';
import 'package:partnex/features/auth/presentation/blocs/discovery_cubit/discovery_state.dart';

// ---------------------------------------------------------------------------
// Test helpers
// ---------------------------------------------------------------------------

SmeCardData _makeCard({
  int score = 75,
  double annualRevenue = 1_200_000,
  double monthlyExpenses = 60_000,
  double liabilities = 100_000,
  String riskLevel = 'LOW',
  String fundingHistory = 'No prior funding',
}) =>
    SmeCardData(
      id: 'test-1',
      companyName: 'Acme Ltd',
      industry: 'Technology',
      location: 'Lagos, Nigeria',
      yearsOfOperation: 3,
      numberOfEmployees: 12,
      annualRevenue: annualRevenue,
      monthlyExpenses: monthlyExpenses,
      liabilities: liabilities,
      fundingHistory: fundingHistory,
      score: score,
      riskLevel: riskLevel,
      generatedAt: DateTime(2024, 6, 1),
    );

void main() {
  // ── SmeCardData Model ─────────────────────────────────────────────────────
  group('SmeCardData.fromMap()', () {
    test('maps snake_case API fields correctly', () {
      final card = SmeCardData.fromMap({
        'id': 42,
        'business_name': 'Beta Corp',
        'industry_sector': 'Agriculture',
        'location': 'Kano',
        'years_of_operation': '5',
        'number_of_employees': '30',
        'annual_revenue_amount_1': '500000',
        'monthly_expenses': '40000',
        'existing_liabilities': '80000',
        'prior_funding_history': 'Bank loan 2022',
        'score': 68,
        'risk_level': 'MEDIUM',
        'created_at': '2024-01-15T00:00:00.000Z',
      });

      expect(card.id, '42');
      expect(card.companyName, 'Beta Corp');
      expect(card.industry, 'Agriculture');
      expect(card.location, 'Kano');
      expect(card.yearsOfOperation, 5);
      expect(card.numberOfEmployees, 30);
      expect(card.annualRevenue, 500000.0);
      expect(card.monthlyExpenses, 40000.0);
      expect(card.liabilities, 80000.0);
      expect(card.score, 68);
      expect(card.riskLevel, 'MEDIUM');
    });

    test('provides safe defaults for missing fields', () {
      final card = SmeCardData.fromMap({});
      expect(card.companyName, 'Unknown SME');
      expect(card.industry, 'Various');
      expect(card.location, 'Unknown');
      expect(card.yearsOfOperation, 1);
      expect(card.numberOfEmployees, 0);
      expect(card.annualRevenue, 0.0);
      expect(card.score, 0);
      expect(card.fundingHistory, 'No prior funding');
    });

    test('parses score from double', () {
      expect(SmeCardData.fromMap({'score': 82.7}).score, 82);
    });

    test('parses score from string', () {
      expect(SmeCardData.fromMap({'score': '91'}).score, 91);
    });
  });

  group('SmeCardData computed getters', () {
    test('expenseRatio: (60k*12)/1.2M = 60%', () {
      final card = _makeCard(annualRevenue: 1_200_000, monthlyExpenses: 60_000);
      expect(card.expenseRatio, closeTo(60.0, 0.01));
      expect(card.expenseRatioSignal, 'Healthy');
    });

    test('expenseRatioSignal is Very High when > 90%', () {
      final card = _makeCard(annualRevenue: 1_200_000, monthlyExpenses: 120_000);
      expect(card.expenseRatioSignal, 'Very High');
    });

    test('liabilitiesRatio: 200k/1M = 20% → Moderate', () {
      final card = _makeCard(annualRevenue: 1_000_000, liabilities: 200_000);
      expect(card.liabilitiesRatio, closeTo(20.0, 0.01));
      expect(card.liabilitiesRatioSignal, 'Moderate');
    });

    test('isGrowthPositive for high-score SME (score 85)', () {
      // prevRevenue = 1M / 1.25 = 800K → growth = (1M-800K)/800K = +25%
      expect(_makeCard(score: 85, annualRevenue: 1_000_000).isGrowthPositive, isTrue);
    });

    test('isGrowthPositive is false for low-score SME (score 30)', () {
      // prevRevenue = 1M / 0.92 → negative growth
      expect(_makeCard(score: 30, annualRevenue: 1_000_000).isGrowthPositive, isFalse);
    });

    test('trustFunded is false for no prior funding', () {
      expect(_makeCard(fundingHistory: 'No prior funding').trustFunded, isFalse);
    });

    test('trustFunded is true when prior funding exists', () {
      expect(_makeCard(fundingHistory: 'Angel investor 2022').trustFunded, isTrue);
    });

    test('employeesText includes count and label', () {
      expect(_makeCard().employeesText, '12 employees');
    });

    test('revenueText includes abbreviated amount', () {
      expect(_makeCard(annualRevenue: 2_500_000).revenueText, contains('2500'));
    });

    test('growthSignal contains direction arrow', () {
      final growing = _makeCard(score: 90).growthSignal;
      expect(growing.startsWith('↑') || growing.startsWith('↓'), isTrue);
    });
  });

  // ── SmeProfileState ────────────────────────────────────────────────────────
  group('SmeProfileState', () {
    test('initial state has correct defaults', () {
      const s = SmeProfileState();
      expect(s.businessName, '');
      expect(s.annualRevenueAmount1, 0.0);
      expect(s.csvProcessingStatus, CsvProcessingStatus.initial);
    });

    test('copyWith changes only specified fields', () {
      const s = SmeProfileState(businessName: 'OldName', industry: 'Tech');
      final updated = s.copyWith(businessName: 'NewName');
      expect(updated.businessName, 'NewName');
      expect(updated.industry, 'Tech'); // unchanged
    });

    test('toMap includes all required keys', () {
      const s = SmeProfileState(
        businessName: 'Gamma Inc',
        annualRevenueYear1: 2023,
        annualRevenueAmount1: 800000,
        monthlyAvgExpenses: 50000,
        totalLiabilities: 120000,
      );
      final map = s.toMap();
      expect(map['businessName'], 'Gamma Inc');
      expect(map['annualRevenueYear1'], 2023);
      expect(map['monthlyAvgExpenses'], 50000.0);
    });

    test('fromMap reconstructs state correctly', () {
      final s = SmeProfileState.fromMap({
        'businessName': 'Delta Ltd',
        'industry': 'Retail',
        'annualRevenueAmount1': 1000000,
        'monthlyAvgExpenses': 70000,
      });
      expect(s.businessName, 'Delta Ltd');
      expect(s.annualRevenueAmount1, 1000000.0);
      expect(s.monthlyAvgExpenses, 70000.0);
    });

    test('equality works (Equatable)', () {
      const a = SmeProfileState(businessName: 'Same');
      const b = SmeProfileState(businessName: 'Same');
      expect(a, equals(b));
    });

    test('inequality detected', () {
      const a = SmeProfileState(businessName: 'AAA');
      const b = SmeProfileState(businessName: 'BBB');
      expect(a, isNot(equals(b)));
    });
  });

  // ── SmeProfileCubit ───────────────────────────────────────────────────────
  group('SmeProfileCubit', () {
    late SmeProfileCubit cubit;

    setUp(() => cubit = SmeProfileCubit());
    tearDown(() => cubit.close());

    test('starts in empty SmeProfileState', () {
      expect(cubit.state, const SmeProfileState());
    });

    test('updateBusinessProfile sets correct fields', () {
      cubit.updateBusinessProfile(
        businessName: 'Zeta Corp',
        industry: 'Manufacturing',
        location: 'Lagos',
        yearsOfOperation: 7,
        numberOfEmployees: 100,
      );
      expect(cubit.state.businessName, 'Zeta Corp');
      expect(cubit.state.industry, 'Manufacturing');
      expect(cubit.state.yearsOfOperation, 7);
      expect(cubit.state.numberOfEmployees, 100);
    });

    test('updateRevenueExpenses sets revenue & expense fields', () {
      cubit.updateRevenueExpenses(
        annualRevenueYear1: 2023,
        annualRevenueAmount1: 1_500_000,
        annualRevenueYear2: 2022,
        annualRevenueAmount2: 1_100_000,
        monthlyAvgExpenses: 80_000,
      );
      expect(cubit.state.annualRevenueYear1, 2023);
      expect(cubit.state.annualRevenueAmount1, 1_500_000.0);
      expect(cubit.state.monthlyAvgExpenses, 80_000.0);
    });

    test('updateLiabilitiesHistory sets liability fields', () {
      cubit.updateLiabilitiesHistory(
        totalLiabilities: 250_000,
        outstandingLoans: 100_000,
        hasPriorFunding: true,
        priorFundingSource: 'Strategic investor',
        repaymentHistory: 'No missed payments',
      );
      expect(cubit.state.totalLiabilities, 250_000.0);
      expect(cubit.state.hasPriorFunding, true);
      expect(cubit.state.priorFundingSource, 'Strategic investor');
    });

    test('reset restores initial state', () {
      cubit.updateBusinessProfile(
        businessName: 'ToReset',
        industry: 'Tech',
        location: 'Lagos',
        yearsOfOperation: 2,
        numberOfEmployees: 10,
      );
      cubit.reset();
      expect(cubit.state, const SmeProfileState());
    });

    test('updateFromMap populates state from map', () {
      cubit.updateFromMap({
        'businessName': 'FromMap Corp',
        'industry': 'Logistics',
        'annualRevenueAmount1': 900000,
        'monthlyAvgExpenses': 55000,
      });
      expect(cubit.state.businessName, 'FromMap Corp');
      expect(cubit.state.annualRevenueAmount1, 900000.0);
    });

    test('csvProcessingStatus starts as initial', () {
      expect(cubit.state.csvProcessingStatus, CsvProcessingStatus.initial);
    });

    test('multiple sequential updates accumulate correctly', () {
      cubit.updateBusinessProfile(
        businessName: 'Acme',
        industry: 'Tech',
        location: 'Abuja',
        yearsOfOperation: 3,
        numberOfEmployees: 20,
      );
      cubit.updateRevenueExpenses(
        annualRevenueYear1: 2023,
        annualRevenueAmount1: 500_000,
        annualRevenueYear2: 2022,
        annualRevenueAmount2: 400_000,
        monthlyAvgExpenses: 30_000,
      );
      // Both updates should coexist
      expect(cubit.state.businessName, 'Acme');
      expect(cubit.state.annualRevenueAmount1, 500_000.0);
    });
  });

  // ── DiscoveryState ─────────────────────────────────────────────────────────
  group('DiscoveryState', () {
    final sme1 = _makeCard(score: 80);
    final sme2 = _makeCard(score: 60);

    test('DiscoveryInitial is not equal to DiscoveryLoading', () {
      expect(DiscoveryInitial(), isNot(equals(DiscoveryLoading())));
    });

    test('DiscoveryLoaded holds correct list', () {
      final state = DiscoveryLoaded(smes: [sme1, sme2]);
      expect(state.smes.length, 2);
      expect(state.smes.first.score, 80);
    });

    test('DiscoveryLoaded equality via props', () {
      final a = DiscoveryLoaded(smes: [sme1]);
      final b = DiscoveryLoaded(smes: [sme1]);
      expect(a, equals(b));
    });

    test('DiscoveryError stores message', () {
      const state = DiscoveryError('Network error');
      expect(state.message, 'Network error');
    });

    test('DiscoveryError is unequal to DiscoveryError with different message', () {
      expect(const DiscoveryError('A'), isNot(equals(const DiscoveryError('B'))));
    });
  });
}
