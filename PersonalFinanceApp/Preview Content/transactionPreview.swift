//
//  transactionPreview.swift
//  PersonalFinanceApp
//
//  Created by Nicolas Rubert on 7/4/22.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "6/24/2022", institution: "Visa", account: "Personal", merchant: "Apple", amount: 0.99, type: "debit", categoryId: 001, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
