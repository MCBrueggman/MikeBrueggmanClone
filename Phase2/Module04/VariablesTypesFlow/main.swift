// ============================================================
// MODULE 4: Swift Programming Fundamentals
// LAB — PNC Banking Domain Model
// Enterprise Mobile Application Development Bootcamp
// ============================================================

import Foundation


/* ============================================================
  SECTION 1: Enumerations
  ============================================================*/

enum TransactionType: String, CaseIterable, Codable{
    case credit
    case debit
    case transfer
    case fee
    
    var isExpense: Bool {
        switch self {
        case .debit, .fee:
            return true
        default:
            return false
        }
    }
}

// 1B: TransactionStatus
enum TransactionStatus: String, Codable {
    case pending
    case completed
    case failed
    case cancelled
    
    var isTerminal: Bool {
        switch self {
        case .completed, .failed, .cancelled:
            return true
        case .pending:
            return false
        }
    }
}

// ============================================================
// SECTION 2: Transaction Struct
// ============================================================

struct Transaction: Identifiable, Codable, Equatable, Hashable, Summarizable {
    var id: String = UUID().uuidString
    var date: Date
    var amount: Double //(always positive — type determines direction)
    var description: String
    var type: TransactionType
    var status: TransactionStatus = .completed
    var category: String?
    var merchantName: String?
    
    //from summarizable protocol
    var summary: String {
        "\(description): \(formattedAmount) on \(formattedDate)"
    }
    func printSummary() {
        print(summary)
    }
    
    var formattedAmount: String{
        if type.isExpense {
            return String(format: "-$%.2f", amount)
        }
        else {
            return String(format: "+$%.2f", amount)
        }
    }
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    var resolvedCategory: String{
        return category ?? "Uncategorized"
    }
    
    init (date: Date, amount: Double, description: String, type: TransactionType, status: TransactionStatus = .completed, category: String? = nil, merchantName: String? = nil) {
        self.date = date
        self.amount = amount
        self.description = description
        self.type = type
        self.status = status
        self.category = category
        self.merchantName = merchantName
    }
}

// ============================================================
// SECTION 3: Account Class
// ============================================================

class BankAccount: Identifiable, AccountOperations, Summarizable{
    
    var id: String
    var accountNumber: String
    var accountType: String
    var nickname: String?
    var balance: Double
    var availableBalance: Double
    let currency: String
    let isActive: Bool
    var transactions: [Transaction]
    
    var displayName: String {
        nickname ?? accountType.capitalized
    }
    var maskedAccountNumber: String {
        "****" + String(accountNumber.suffix(4))
    }
    var formattedBalance: String {
        String(format: "$%.2f", balance)
    }
    var recentTransactions: [Transaction] {
        Array(transactions.sorted { $0.date > $1.date }.prefix(5))
    }
    var pendingCount: Int {
        transactions.filter { $0.status == .pending }.count
    }
    var summary: String {
        "\(displayName): \(formattedBalance)"
    }
    func printSummary() {
        print(summary)
    }
    func deposit(amount: Double) throws {
        guard isActive else {
            throw AccountOperationsError.accountInactive
        }

        guard amount > 0 else {
            throw AccountOperationsError.invalidAmount
        }

        balance += amount
        availableBalance += amount
    }
    func withdraw(amount: Double) throws {
        guard isActive else {
            throw AccountOperationsError.accountInactive
        }

        guard amount > 0 else {
            throw AccountOperationsError.invalidAmount
        }

        guard amount <= availableBalance else {
            throw AccountOperationsError.insufficientFunds(available: availableBalance,required: amount)
        }

        balance -= amount
        availableBalance -= amount
    }
    func transfer(amount: Double, to destination: BankAccount) throws {
        guard isActive else {
            throw AccountOperationsError.accountInactive
        }
        
        guard destination.isActive else {
            throw AccountOperationsError.accountInactive
        }
        
        guard destination !== self else {
            throw AccountOperationsError.transferToSameAccount
        }
        
        guard amount > 0 else {
            throw AccountOperationsError.invalidAmount
        }
        
        guard amount <= availableBalance else {
            throw AccountOperationsError.insufficientFunds(available: availableBalance,required: amount)
        }
        
        balance -= amount
        availableBalance -= amount
        
        destination.balance += amount
        destination.availableBalance += amount
    }

    func addTransaction(_ transaction: Transaction) {
        if transaction.type.isExpense {
            balance -= transaction.amount
            availableBalance -= transaction.amount
        } else {
            balance += transaction.amount
            availableBalance += transaction.amount
        }

        transactions.append(transaction)
    }
    init(id: String, accountNumber: String, accountType: String, nickname: String?, initialBalance: Double, currency: String = "USD", isActive: Bool = true)
    {
        self.id = id
        self.accountNumber = accountNumber
        self.accountType = accountType
        self.nickname = nickname
        self.balance = initialBalance
        self.availableBalance = initialBalance
        self.currency = currency
        self.isActive = isActive
        self.transactions = []
    }
}

// ============================================================
// SECTION 4: Protocols
// ============================================================

protocol Summarizable{
    var summary: String { get }
    func printSummary()
}

protocol AccountOperations{
    func deposit(amount: Double) throws
    func withdraw(amount: Double) throws
    func transfer(amount: Double, to destination: BankAccount) throws
}

enum AccountOperationsError: Error, LocalizedError{
    case invalidAmount
    case insufficientFunds(available: Double, required: Double)
    case accountInactive
    case transferToSameAccount
    case dailyLimitExceeded(limit: Double)
    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return "Invalid amount"
        case .insufficientFunds(available: let available, required: let required):
            return "Insufficient funds. Available: \(available), required: \(required)"
        case .accountInactive:
            return "Account is inactive"
        case .transferToSameAccount:
            return "Cannot transfer to the same account"
        case .dailyLimitExceeded(let limit):
            return "Daily limit exceeded. Limit: \(limit)"
        }
    }
    
}

// ============================================================
// SECTION 5: Analytics
// ============================================================

protocol AnalyticsProvider{
    var totalCredits: Double { get }
    var totalDebits: Double { get }
    var netFlow: Double { get }
    var largestTransaction: Transaction? { get }
    func monthlyTotal(month: Int, year: Int) -> Double
    func transactionsByCategory() -> [String: [Transaction]]
}

struct AccountAnalytics: AnalyticsProvider{
    var transactions: [Transaction]
    var totalCredits: Double {
        return transactions.filter { !$0.type.isExpense }.reduce(0) { $0 + $1.amount }
    }
    var totalDebits: Double {
        return transactions.filter { $0.type.isExpense }.reduce(0) { $0 + $1.amount }
    }
    var netFlow: Double {
        return totalCredits - totalDebits
    }
    var largestTransaction: Transaction? {
        .some(transactions.max(by: { $0.amount < $1.amount })!)
    }
    func monthlyTotal(month: Int, year: Int) -> Double {
        let calendar = Calendar.current
        return transactions.filter {
            let components = calendar.dateComponents([.month, .year], from: $0.date)
            return components.month == month && components.year == year
        }
        .filter { $0.type.isExpense }
        .reduce(0) { $0 + $1.amount }
    }
    func transactionsByCategory() -> [String : [Transaction]] {
        Dictionary(grouping: transactions){
            $0.resolvedCategory
        }
    }
}

// ============================================================
// SECTION 6: Generic Result Reporter
// ============================================================

func reportResults<T: Summarizable>(_ items: [T], title: String) {
    print("\(title)")
    print("\(items.count) items")
    for item in items {
        item.printSummary()
    }
    print("End of \(title)")
}

// ============================================================
// SECTION 7: INTEGRATION TEST — Tie it all together
// ============================================================

func runlabDemo() {
    let checking = BankAccount (
        id: UUID().uuidString,
        accountNumber: "529846",
        accountType: "checking",
        nickname: "Life Expenditures",
        initialBalance: 3_500
    )
    let savings = BankAccount (
        id: UUID().uuidString,
        accountNumber: "840637",
        accountType: "savings",
        nickname: "Emergencies",
        initialBalance: 12_000
    )
    savings.addTransaction(Transaction(date: Date(), amount: 1_487.34, description: "Paycheck", type: .credit, category: "Income"))
    checking.addTransaction(Transaction(date: Date(), amount: 85.92, description: "Groceries", type: .debit, category: "Groceries"))
    checking.addTransaction(Transaction(date: Date(), amount: 32.11, description: "Gasoline", type: .debit, category: "Automotive"))
    checking.addTransaction(Transaction(date: Date(), amount: 15, description: "Account retention fee", type: .fee, category: "Fee"))
    
    let aTransferVal = 1_000.00
    do{
        try savings.transfer(amount: aTransferVal, to: checking)
    } catch let error as AccountOperationsError {
        switch error{
        case .invalidAmount:
            print ("Error: Transfer amount is invalid: \(aTransferVal)")
        default:
            print("Error: \(error.localizedDescription)")
        }
    } catch {
        print("Error: \(error.localizedDescription)")
    }
    print("Checking balance: \(checking.formattedBalance)")
    print("Savings balance: \(savings.formattedBalance)")
    
    let superExpensiveCar = 1_000_000.00
    do{
        try checking.withdraw(amount: superExpensiveCar)
            checking.addTransaction(Transaction(date: Date(), amount: superExpensiveCar, description: "New car", type: .debit, category: "Automotive"))
    } catch let error as AccountOperationsError {
        switch error {
        case .insufficientFunds (checking.balance, superExpensiveCar):
            print("Error: Funds not available: \(String(format: "+$%.2f", checking.balance)) < \(superExpensiveCar)")
        default :
            print("Error: \(error.localizedDescription)")
        }
    } catch {
        print("Error: \(error.localizedDescription)")
    }
    
    savings.addTransaction(Transaction(date: Date(), amount: -592, description: "Totally not illegal gambling winnings", type: .credit, category: "Income"))
    do {
        try savings.transfer(amount: aTransferVal, to: savings)
    } catch let error as AccountOperationsError {
        switch error{
        case .transferToSameAccount:
            print("Error: Cannot transfer to same account")
        default:
            print("Error: \(error.localizedDescription)")
        }
    } catch {
        print ("Error: \(error.localizedDescription)")
    }
    let analytics = AccountAnalytics(transactions: checking.transactions)

    print("Checking Account Analytics")
    print("Total credits: \(String(format: "$%.2f", analytics.totalCredits))")
    print("Total debits: \(String(format: "$%.2f", analytics.totalDebits))")
    print("Net flow: \(String(format: "$%.2f", analytics.netFlow))")

    if let largest = analytics.largestTransaction {
        print("Largest transaction: \(largest.description) - \(largest.formattedAmount)")
    }

    print("Transactions by category:")
    for (category, transactions) in analytics.transactionsByCategory() {
        print("\(category): \(transactions.count)")
    }
    
    reportResults(checking.transactions, title: "Checking Transactions")
    reportResults([checking, savings], title: "All Accounts")
    
    let originalTransaction = checking.transactions[0]
    var copiedTransaction = originalTransaction

    copiedTransaction.description = "Modified Copy"

    print("Modified Descriptions")
    print("Original description: \(originalTransaction.description)")
    print("Copied description: \(copiedTransaction.description)")
    
    
    let checkingDuplicate = checking
    do {
        try checkingDuplicate.deposit(amount: 100)
    } catch {
        print("Error: \(error.localizedDescription)")
    }
    print("Modified Accounts")
    print("Original checking balance: \(checking.formattedBalance)")
    print("Alias checking balance: \(checkingDuplicate.formattedBalance)")
    
}

runlabDemo()


/*Output:
 Checking balance: $4366.97
 Savings balance: $12487.34
 Error: Funds not available: +$4366.97 < 1000000.0
 Error: Cannot transfer to same account
 Checking Account Analytics
 Total credits: $0.00
 Total debits: $133.03
 Net flow: $-133.03
 Largest transaction: Groceries - -$85.92
 Transactions by category:
 Automotive: 1
 Groceries: 1
 Fee: 1
 Checking Transactions
 3 items
 Groceries: -$85.92 on Sep 3, 2026 at 4:24 PM
 Gasoline: -$32.11 on Sep 3, 2026 at 4:24 PM
 Account retention fee: -$15.00 on Sep 3, 2026 at 4:24 PM
 End of Checking Transactions
 All Accounts
 2 items
 Life Expenditures: $4366.97
 Emergencies: $11895.34
 End of All Accounts
 Modified Descriptions
 Original description: Groceries
 Copied description: Modified Copy
 Modified Accounts
 Original checking balance: $4466.97
 Alias checking balance: $4466.97
 Program ended with exit code: 0*/
