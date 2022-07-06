//
//  TransactionListViewModel.swift
//  PersonalFinanceApp
//
//  Created by Nicolas Rubert on 7/4/22.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    /// Cancellables
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransactions()
    }
    
    /// Get Transaction from Url
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else{
            print("Invalid URL")
            return
        }
        /// Map Response
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{
                (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            /// Check for erros or success
            .sink{ completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transaction:", error.localizedDescription)
                case .finished:
                    print("Finished catching transaction")
                }
            }receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)
        
    }
    
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else {return [:]}
        
        let groupedTransactions = TransactionGroup(grouping: transactions) {$0.month}
        
        return groupedTransactions
    }
    
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
        
        let today = "02/17/2022".dateParsed() // Need to change to current date
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum: BinaryFloatingPoint = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount}
            
            sum += dailyTotal
            cumulativeSum.append((date.formatted(), sum))
        }
        return cumulativeSum
    }
}

