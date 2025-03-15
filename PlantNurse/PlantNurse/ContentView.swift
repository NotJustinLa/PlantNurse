//
//  ContentView.swift
//  PlantNurse
//
//  Created by Justin La on 15/3/2025.
//

import SwiftUI

struct ContentView: View {
    @State var isPickerShowing = false
    @State var isCameraViewShowing = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                //show the image picker
                isPickerShowing = true
            } label: {
                Text("Upload a Photo ;D")
            }
            
            Button {
                //show the camera picker
                isCameraViewShowing = true
            } label: {
                Text("Take a Photo")
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            // image picker
            ImagePicker()
        }
        .fullScreenCover(isPresented: $isCameraViewShowing) {
            CameraView()
        }
    }
}

#Preview {
    ContentView()
}
