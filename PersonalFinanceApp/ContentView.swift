//
//  ContentView.swift
//  PersonalFinanceApp
//
//  Created by Nicolas Rubert on 7/4/22.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    var demoData: [Double] = [8,3,6,9,0,12]
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    let expenseData =  transactionListVM.accumulateTransactions()
                    let totalExpense = expenseData.last?.1
                    
                    // MARK: Chart
                    // Need to cahnge the Color thing
                    LineChartView(data: <#T##[Double]#>, title: <#T##String#>)
                        
                    
                    // MARK: Recent Transaction List
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM : TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        ContentView()
            .environmentObject(transactionListVM)
    }
}
