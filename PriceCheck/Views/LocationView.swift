//
//  LocationView.swift
//  PriceCheck
//
//  Created by Lujain Almulaifi on 02/10/2026.
//

import Foundation
import SwiftUI

struct LocationView: View {
  var location: Location

  var body: some View {
    Section(header: Text(location.name), content: {
      ForEach(location.scans.sorted(by: { $0 < $1 })) { scan in
        ScanView(scan: scan)
      }
    })
  }
}
