//
//  ContentView.swift
//  Sandy
//
//  Created by Dave Gumba on 2021-05-30.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    let stocks: [Stock] = [
        .init(name: "Apple Inc", symbol: "AAPL", exchange: "NASDAQ", currency: "USD", currentPrice: 124.61, previousPrices: [125.04, 125.06, 125.10, 124.88, 124.32, 129.22]),
        .init(name: "ARK Investment Management LLC - ARK Innovation ETC", symbol: "ARKK", exchange: "NYSE", currency: "USD", currentPrice: 112.10, previousPrices: [112.50, 112.43, 113.12, 113.85, 114.02, 118.22]),
        .init(name: "Mind Medicine Inc", symbol: "MMED", exchange: "AEQUITAS NEO EXCHANGE", currency: "CAD", currentPrice: 4.07, previousPrices: [4.08, 4.09, 4.12, 4.02, 3.93, 3.22]),
        .init(name: "Square Inc (Class A)", symbol: "SQ", exchange: "NYSE", currency: "USD", currentPrice: 222.52, previousPrices: [223.12, 223.18, 223.20, 223.23, 223.19, 223.55]),
        .init(name: "Vanguard S&P 500 Index ETF", symbol: "VFV", exchange: "AEQUITAS NEO EXCHANGE", currency: "CAD", currentPrice: 90.30, previousPrices: [90.45, 90.32, 90.54, 90.43, 90.43, 90.45]),
        .init(name: "HIVE Blockchain Technologies Ltd", symbol: "HIVE", exchange: "TSX-V", currency: "CAD", currentPrice: 3.04, previousPrices: [3.05, 3.02, 3.03, 3.04, 3.06, 3.07]),
        .init(name: "Ford Motor Co.", symbol: "F", exchange: "NYSE", currency: "USD", currentPrice: 14.53, previousPrices: [14.56, 14.48, 14.34, 13.89, 14.19, 14.35]),
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(stocks, id: \.self) { stock in
                HStack {
                    VStack(alignment: .leading) {
                        Text(stock.symbol)
                            .font(.system(size: 20, weight: .bold))
                        Text(stock.exchange)
                            .font(.system(size: 10, weight: .light))
                    }.padding()
                    
                    Spacer()
                    
                    Spacer()
                    
                    VStack {
                        Text("$\(stock.getCurrentPriceAsString())")
                            .font(.system(size: 20, weight: .bold))
                        Text("\(stock.getMostRecentPriceChangeValue())")
                            
                    }.padding()
                }
                
                Divider()
            }
        }.navigationTitle("Portfolio")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Stock: Hashable {
    let name, symbol, exchange, currency: String
    let currentPrice: Float
    let previousPrices: [Float]
    
}

extension Stock {
    func getCurrentPriceAsString() -> String {
        let twoDecimalPlacesFormat = "%.2f"
        return String(format: twoDecimalPlacesFormat, currentPrice)
    }
    
    func getMostRecentPriceChangeValue() -> String {
        let gainOrLoss = self.currentPrice > previousPrices.first! ? "+" : "-"
        let amountChanged = String(format: "%.2f", abs(self.currentPrice - previousPrices.first!))
        let changeValueString = "\(gainOrLoss)\(amountChanged)"
        
        return changeValueString
    }
    
    func priceIncreased() -> Bool {
        return self.currentPrice > self.previousPrices.first!
    }
}
