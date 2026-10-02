// Created for PriceCheck on 10/10/20 
// Using Swift 5.0 
// Running on macOS 11.0
// Qapla'
//

import Foundation
import SwiftUI

struct Location: Identifiable, Codable, Comparable {
  
    var id = UUID()  // to conform to Identifiable protocol
      var name: String
      var scans: [PriceScan]

      enum CodingKeys: String, CodingKey {
        case id
        case name = "location"
        case scans
      }

      // To conform to Comparable protocol
      static func < (lhs: Location, rhs: Location) -> Bool {
        return lhs.name < rhs.name
      }

      static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name
      }

      // MARK: Example for SwiftUI

    }
