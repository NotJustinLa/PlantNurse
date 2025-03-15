//
//  CameraView.swift
//  PlantNurse
//
//  Created by Anna Dang on 15/3/2025.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @State private var showImagePicker = false
    @State private var capturedImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
            
            Button(action: {
                requestCameraPermission { granted in
                    if granted {
                        showImagePicker = true
                    } else {
                        print("Camera access denied.")
                    }
                }
            }) {
                Label("Open Camera", systemImage: "camera")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .sheet(isPresented: $showImagePicker) {
            CameraPicker(processedImage: $capturedImage)
        }
    }
    
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        completion(granted)
                    }
                } else {
                    print("Camera access denied.")
                }
            }
        case .denied, .restricted:
            completion(false)
            print("Camera access restricted or denied.")
        @unknown default:
            print("Unknown camera authorisation status.")
        }
    }
}

struct CameraPicker: UIViewControllerRepresentable {
    
    @Binding var processedImage: UIImage?
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        var parent: CameraPicker
        
        init(parent: CameraPicker) {
                    self.parent = parent
                }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.processedImage = selectedImage
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let view = UIImagePickerController()
        view.sourceType = .camera
        view.cameraCaptureMode = .photo
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates needed for this basic setup
    }
}
