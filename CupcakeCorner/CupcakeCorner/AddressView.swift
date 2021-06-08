//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Peter Kostin on 2021-06-08.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderWrap: OrderWrapper
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderWrap.order.name)
                TextField("Street Address", text: $orderWrap.order.streetAddress)
                TextField("City", text: $orderWrap.order.city)
                TextField("Zip", text: $orderWrap.order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(orderWrap: orderWrap)) {
                    Text("Check out")
                }
            }
            .disabled(!orderWrap.order.hasValidAdress)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderWrap: OrderWrapper())
    }
}
