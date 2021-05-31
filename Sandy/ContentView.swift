//
//  ContentView.swift
//  Sandy
//
//  Created by Dave Gumba on 2021-05-30.
//

import SwiftUI
import StockCharts
import Foundation

struct ContentView: View {
    
    let stocks: [Stock] = [
        .init(name: "Apple Inc", symbol: "AAPL", exchange: "NASDAQ", currency: "USD", currentPrice: 124.61, previousPrices: [125.04, 125.06, 125.10, 124.88, 124.32, 129.22]),
        .init(name: "ARK Investment Management LLC - ARK Innovation ETC", symbol: "ARKK", exchange: "NYSE", currency: "USD", currentPrice: 112.10, previousPrices: [112.50, 112.43, 113.12, 113.85, 114.02, 118.22]),
        .init(name: "Mind Medicine Inc", symbol: "MMED", exchange: "AEQUITAS NEO EXCHANGE", currency: "CAD", currentPrice: 4.07, previousPrices: [4.08, 4.09, 4.12, 4.02, 3.93, 3.22]),
        .init(name: "Square Inc (Class A)", symbol: "SQ", exchange: "NYSE", currency: "USD", currentPrice: 222.52, previousPrices: [223.12, 223.18, 223.20, 223.23, 223.19, 223.55]),
        .init(name: "Vanguard S&P 500 Index ETF", symbol: "VFV", exchange: "TSX", currency: "CAD", currentPrice: 90.30, previousPrices: [90.15, 90.32, 90.54, 90.43, 90.43, 90.45]),
        .init(name: "HIVE Blockchain Technologies Ltd", symbol: "HIVE", exchange: "TSX-V", currency: "CAD", currentPrice: 3.04, previousPrices: [3.05, 3.02, 3.03, 3.04, 3.06, 3.07]),
        .init(name: "Ford Motor Co.", symbol: "F", exchange: "NYSE", currency: "USD", currentPrice: 14.53, previousPrices: [14.49, 14.48, 14.34, 13.89, 14.19, 14.35]),
    ]
    
    let packages: [Package] = [
        .init(header: "Package from Nootropicsdepot.com", senderImageName: "genericIcon", senderName: "", statusText: "Waiting for details", itemImageName: "", isDelivered: false),
        .init(header: "Package from Onnit.com", senderImageName: "genericIcon", senderName: "", statusText: "Delivered", itemImageName: "", isDelivered: true),
        .init(header: "Package from idrivefulfillment.com", senderImageName: "genericIcon", senderName: "", statusText: "Delivered", itemImageName: "", isDelivered: true),
        .init(header: "Kindle Paperwhite - Now Waterproof", senderImageName: "amazon", senderName: "Amazon", statusText: "Delivered", itemImageName: "kindlePaperwhite", isDelivered: true),
        .init(header: "2-Year Accident Protection for Kindle Plan", senderImageName: "amazon", senderName: "Amazon", statusText: "Delivered", itemImageName: "kindleWarranty", isDelivered: true),
        .init(header: "ABOX Muscle Massage Gun, 30 Special Ways", senderImageName: "amazon", senderName: "Amazon", statusText: "Delivered", itemImageName: "aboxGun", isDelivered: true),
        .init(header: "Grow Kit", senderImageName: "genericIcon", senderName: "", statusText: "Delivered", itemImageName: "", isDelivered: true),
    ]
    
    var body: some View {
        NavigationView {
            
            PackagesListView(packages: packages)

            // StocksListView(stocks: stocks)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Packages

struct PackagesListView: View {
    var packages: [Package]
    
    var body: some View {
        List {
            Section {
                ForEach(packages, id: \.self) { package in
                    PackageView(package: package)

                }
            }.listStyle(GroupedListStyle())
        }.navigationTitle("Packages")
    }
}

struct PackageView: View {
    var package: Package
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                Image(package.senderImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .clipShape(Circle())
                    .foregroundColor(.white)
                
                if package.isDelivered {
                    Image("checkmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
            
            VStack(alignment: .leading, spacing: 1.0) {
                Text(package.header)
                    .font(.system(size: 13, weight: .bold))
                    .lineLimit(1)
                
                if !package.senderName.isEmpty {
                    Text(package.senderName)
                        .font(.system(size: 12, weight: .medium))
                }
                
                Text(package.statusText)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(package.useGreenText() ? .green : .gray)
            }
            
            Spacer()
            
            Image(package.itemImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
        }
        
        
    }
}

struct Package: Hashable {
    let header, senderImageName, senderName, statusText, itemImageName: String
    let isDelivered: Bool
}

extension Package  {
    func useGreenText() -> Bool {
        return self.isDelivered
    }
}

// Stocks
struct StocksListView: View {
    var stocks: [Stock]
    
    var body: some View {
        List {
            Section {
                ForEach(stocks, id: \.self) { stock in
                    StockView(stock: stock)

                }
            }.listStyle(GroupedListStyle())
        }.navigationTitle("Portfolio")
    }
}


struct StockView: View {
    var stock: Stock
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2.0) {
                Text(stock.symbol)
                    .font(.system(size: 20, weight: .bold))
                Text(stock.exchange)
                    .font(.system(size: 10, weight: .light))
                    .frame(width: 90, alignment: .leading)
            }.padding()
            
            Spacer()
            
            HStack {
                LineChartView(data: stock.previousPrices, dates: ["yyyy-MM-dd", "2021-05-30", "2021-05-29", "2021-05-28", "2021-05-27", "2021-05-26", "2021-05-25"], hours: [], dragGesture: false)
                    .frame(width: 100, height: 40, alignment: .center)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2.0) {
                Text("$\(stock.getCurrentPriceAsString())")
                    .font(.system(size: 20, weight: .bold))
                
                HStack(spacing: 1.05) {
                    Text("\(stock.getMostRecentPriceChangeValue())")
                        .foregroundColor(stock.priceIncreased() ? .green : .gray)
                        .font(.system(size: 10, weight: .light))
                        .lineLimit(1)
                    Text("\(stock.getMostRecentPriceChangePercentage())")
                        .foregroundColor(stock.priceIncreased() ? .green : .gray)
                        .font(.system(size: 10, weight: .light))
                    Text("\(stock.currency)")
                        .font(.system(size: 10, weight: .light))
                }
                    
            }.padding()
        }
    }
    
}

struct Stock: Hashable {
    let name, symbol, exchange, currency: String
    let currentPrice: Double
    let previousPrices: [Double]
    
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
    
    func getMostRecentPriceChangePercentage() -> String {
        let percentageAmount = abs((self.currentPrice - self.previousPrices.first!) / self.previousPrices.first!)
        let amountChanged = String(format: "%.2f", percentageAmount)
        let changeValueString = "(\(amountChanged)%)"
        
        return changeValueString
    }
    
    func priceIncreased() -> Bool {
        return self.currentPrice > self.previousPrices.first!
    }
}

extension Array where Element == Stock {
    func orderAlphabeticallyBySymbol() -> [Stock] {
        return self.sorted { $0.symbol < $1.symbol }
    }
}
