//
//  ScanDetailView.swift
//  PriceCheck
//
//  Created by Lujain Almulaifi on 02/10/2026.
//

import Foundation
import SwiftUI

struct ScanDetailView: View {
    var scan: PriceScan
    
    var body: some View {
        VStack(spacing: 20) {
            Text(scan.item)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            Text(Helper.asCurrency(scan.price))
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Scanned on \(scan.onDate())")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Scan Details"), displayMode: .inline)
    }
}
