//
//  NewPersonView.swift
//  PeopleDB
//
//  Created by Peter Kostin on 2021-06-13.
//

import SwiftUI

struct NewPersonView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var name: String
    
    var body: some View {
            VStack {
                ImagePicker(image: $image)
                
                HStack {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Save") {
                        if name.count > 2 {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding(15)
                }
            }
            .navigationTitle("Add Person")
    }
}
