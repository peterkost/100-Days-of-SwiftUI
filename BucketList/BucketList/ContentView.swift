//
//  ContentView.swift
//  BucketList
//
//  Created by Peter Kostin on 2021-06-12.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var authenticationError = false
    @State private var authenticationErrorMessage = ""
    
    var body: some View {
        ZStack {
            if isUnlocked {
                UnlockedView()
            } else {
                Button("Unlock") {
                    authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $authenticationError) {
            Alert(title: Text("Authentication Error"), message: Text(authenticationErrorMessage), dismissButton: .default(Text("ok")))
        }
    }
    
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock Data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { sucess, authenticationError in
                DispatchQueue.main.async {
                    if sucess {
                        isUnlocked = true
                    } else {
                        self.authenticationError = true
                        authenticationErrorMessage = authenticationError?.localizedDescription ?? "unkown error"
                    }
                }
            }
        } else {
            authenticationError = true
            authenticationErrorMessage = "Your device doesn't support TouchID/FaceID"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
