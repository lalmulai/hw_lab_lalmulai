//
//  TempConverter.swift
//  TempConverterApp
//
//  Created by Lujain Almulaifi on 02/09/2026.
//

import Foundation

class TempConverter {
    
    enum TemperatureUnit: String {
        case celsius = "ºC";
        case fahrenheit = "ºF";
    }
    
    var isConvertingCtoF: Bool = true
    var inputTemp: Int = 0
    var convertedTemp: Int?
    
    func isBelowAbsoluteZero() -> Bool {
        if isConvertingCtoF {
            return inputTemp > -273
        } else {
            return Double(inputTemp) > -459.67
        }
    }
    
    func setInputUnit(_ tempunit: TemperatureUnit) {
        switch tempunit {
        case .celsius:
            isConvertingCtoF = true
        case .fahrenheit:
            isConvertingCtoF = false
        }
    }
    
    func setInputTemp(_ temp: Int) {
        inputTemp = temp
    }
    
    func getConvertedTemp() -> Int? {
        return convertedTemp
    }
    
    private func celsiusToFahrenheit() {
        convertedTemp = Int((Double(inputTemp) * 9 / 5) + 32)
    }

    private func fahrenheitToCelsius() {
        convertedTemp = Int((Double(inputTemp) - 32) * 5 / 9)
    }
    
    func convert() {
        guard isBelowAbsoluteZero() else {
            convertedTemp = nil
            return
        }
        
        if isConvertingCtoF {
            celsiusToFahrenheit()
        } else {
            fahrenheitToCelsius()
        }
    }
    
}
