//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Peter Kostin on 2021-06-08.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orderWrap = OrderWrapper()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderWrap.order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $orderWrap.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(orderWrap.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $orderWrap.order.specialRequestEnabled.animation()){
                        Text("Add special requests")
                    }
                    
                    if orderWrap.order.specialRequestEnabled {
                        Toggle(isOn: $orderWrap.order.extraFrosting){
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $orderWrap.order.addSprinkles){
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(orderWrap: orderWrap)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
