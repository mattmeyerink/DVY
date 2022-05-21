//
//  ImagePicker.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/11/22.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var items: [ReciptItem]
    @Binding var tax: CurrencyObject
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        Coordinator(items: $items, tax: $tax, parent: self)
    }
}

final class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var items: Binding<[ReciptItem]>
    var tax: Binding<CurrencyObject>
    var parent: ImagePicker
    
    init(items: Binding<[ReciptItem]>, tax: Binding<CurrencyObject>, parent: ImagePicker) {
        self.items = items
        self.tax = tax
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let recognitionResponse: TextRecognitionResponse = recognizeText(from: [image.cgImage!])
            items.wrappedValue = recognitionResponse.items
            tax.wrappedValue = recognitionResponse.tax
        }
        
        parent.presentationMode.wrappedValue.dismiss()
    }
}
