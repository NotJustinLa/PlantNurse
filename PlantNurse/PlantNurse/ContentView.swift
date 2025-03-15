//
//  ContentView.swift
//  PlantNurse
//
//  Created by Justin La on 15/3/2025.
//

import SwiftUI

struct ContentView: View {
    @State var isPickerShowing = false
    var body: some View {
        VStack{
            Button {
                //show the image picker
                isPickerShowing = true
            } label: {
                Text("Upload a Photo ;D")
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            // image picker
            ImagePicker()
        }
    }
}

#Preview {
    ContentView()
}
