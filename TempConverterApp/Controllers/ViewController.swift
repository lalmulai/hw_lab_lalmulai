//
//  ViewController.swift
//  TempConverterApp
//
//  Created by Lujain Almulaifi on 02/09/2026.
//

import Foundation
import Combine


class ViewController: ObservableObject {
    var tempConverter: TempConverter = TempConverter()
    
    @Published var inputTempString: String = "Temp"
    @Published var convertedTempString: String = "Temp"
    @Published var isConvertingCtoF: Bool = true
    
    func setInputTempString(_ tempString: String) {
        inputTempString = tempString
    }
    
    func setConvertedTempString() {
        let convertedTemp = tempConverter.getConvertedTemp()
        if let convertedTemp = convertedTemp {
            convertedTempString = String(convertedTemp)
        } else {
            convertedTempString = "N/A"
        }
    }
    
    func setInputTempUnit() {
        isConvertingCtoF ? tempConverter.setInputUnit(.celsius) : tempConverter.setInputUnit(.fahrenheit)
    }
    
    func convert() {
        let inputTemp = Int(inputTempString) ?? -500
        setInputTempUnit()
        tempConverter.setInputTemp(inputTemp)
        tempConverter.convert()
        setConvertedTempString()
    }
}
