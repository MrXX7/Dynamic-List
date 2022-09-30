//
//  ContentView.swift
//  Dynamic List
//
//  Created by Oncu Can on 30.09.2022.
//

import SwiftUI

struct Stock: Identifiable {
    var id = UUID()
    let title: String
}

class StocksViewModel: ObservableObject {
    @Published var stocks: [Stock] = [
    Stock(title: "Apple"),
    Stock(title: "Amazon"),
    Stock(title: "Google"),
    Stock(title: "MSFT")
    
    ]
}

struct ContentView: View {
    @StateObject var viewModel = StocksViewModel()
    @State var text = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("Add New Stock")) {
                    TextField("Company name...", text: $text)
                        .padding()
                    Button(action: {
                        self.tryToSddToList()
                    }, label: {
                        Text("Add To List")
                            .frame(width: 250, height: 50, alignment: .center)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                }
                List {
                    ForEach(viewModel.stocks) { stock in
                        StockRow(title: stock.title)
                    }
                }
                }
                .navigationTitle("Stocks")
        }
    }
    func tryToSddToList() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let newStock = Stock(title: text)
        viewModel.stocks.append(newStock)
        text = ""
    }
}
struct StockRow: View {
    let title: String
    
    var body: some View {
        Label(
        title: { Text(title)},
        icon: { Image(systemName: "chart.bar")}
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
