//
//  ScanView.swift
//  PriceCheck
//
//  Created by Lujain Almulaifi on 02/10/2026.
//

import Foundation
import SwiftUI

struct ScanView: View {
  var scan: PriceScan

  var body: some View {
    NavigationLink(destination: ScanDetailView(scan: scan)) {
      HStack {
        Text(scan.item)
        Spacer()
        Text(Helper.asCurrency(scan.price))
          .fontWeight(.bold)
      }
    }
  }
}
