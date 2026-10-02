// Created for PriceCheck on 10/10/20 
// Using Swift 5.0 
// Running on macOS 11.0
// Qapla'
//

import Foundation
import SwiftUI

struct PriceScan: Identifiable, Codable, Comparable {

  var id = UUID()  // To conform to Identifiable protocol
  var item: String
  var price: Double
  var date: String

  func onDate() -> String {
    return Helper.getShortDate(date)
  }

  // To conform to Comparable protocol
  static func < (lhs: PriceScan, rhs: PriceScan) -> Bool {
    return lhs.date < rhs.date
  }

  // MARK: Example for SwiftUI

}

