//
//  imagePicker.swift
//  PlantNurse
//
//  Created by Justin La on 15/3/2025.
//
//
//
import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator//image that can receive uiimagepickercontrollerevents
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

//Class to handle methods / actions regarding selecting photos
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Runs code when the user has selected an image
        //INSERT THE CODE YOU WANT WHEN USER SELECTS AN IMAGE HERE
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        //dismiss the picker
        parent.isPickerShowing = false
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // runs code when the user has cancelled the picker UI
        //INSERT CODE YOU WANT WHEN THE USER CANCELS THE PICKER UI
        parent.isPickerShowing = false
    }
}
