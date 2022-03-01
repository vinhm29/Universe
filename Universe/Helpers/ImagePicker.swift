//
//  ImagePicker.swift
//  Universe
//
//  Created by Vincenzo Tipacti Moran on 27/02/22.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var show: Bool
    @Binding var image: Data
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child: ImagePicker
        
        init(child1: ImagePicker) {
            child = child1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage]as! UIImage
            let data = image.jpegData(compressionQuality: 1.0)
            
            self.child.image = data!
            self.child.show.toggle()
        }
    }
}


