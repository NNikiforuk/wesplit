//
//  ContentView.swift
//  WeSplitMine
//
//  Created by Natalia Nikiforuk on 17/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var tipPercentage = 20
    @State private var people = 2
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: (totalSum: Double, sumPerPerson: Double) {
        let peopleCount = Double(people + 2)
        let tipCount = Double(tipPercentage)
        let tipSum = (tipCount * amount) / 100
        let totalSum = amount + tipSum
        let sumPerPerson = totalSum / peopleCount
        
        return (totalSum, sumPerPerson)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("Do you want to give a tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount") {
                    Text(totalPerPerson.totalSum, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson.sumPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
