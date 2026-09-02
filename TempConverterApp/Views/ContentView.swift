//
//  ContentView.swift
//  TempConverterApp
//
//  Created by Lujain Almulaifi on 02/09/2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewController = ViewController()
    @State var inputTemp: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all).opacity(0.50)
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.45)
                VStack {
                    HStack{
                        Text(viewController.convertedTempString)
                        Text(viewController.isConvertingCtoF ? "ºF" : "ºC")
                    }
                    Spacer()
                    Text("Enter Temperature:")
                    
                    HStack {
                        TextField("Value", text: $inputTemp).frame(width: 100)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("ºF")
                    }
                    Spacer()
                    HStack(alignment: .center) {
                        Text("ºF -> ºC")
                            .fontWeight(.bold)
                        Toggle(isOn: $viewController.isConvertingCtoF) {
                            Text("")
                        }
                        .labelsHidden()
                        .frame(width: 50)
                        .padding()
                        Text("ºC -> ºF")
                            .fontWeight(.bold)
                    }
                    .padding()
                    Button("Convert") {
                        viewController.setInputTempString(inputTemp)
                        viewController.convert()
                    }
                    .padding().background(Color.white).cornerRadius(10)
                    
                    NavigationLink(destination: infoView()) {
                        Text("Info")
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
