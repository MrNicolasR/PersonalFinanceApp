//
//  PersonalFinanceAppApp.swift
//  PersonalFinanceApp
//
//  Created by Nicolas Rubert on 7/4/22.
//

import SwiftUI

@main
struct PersonalFinanceAppApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
