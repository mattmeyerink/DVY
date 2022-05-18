//
//  ScanDocumentView.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI
import VisionKit
import Vision

struct ScanDocumentView: UIViewControllerRepresentable {
    @Binding var items: [ReciptItem]
    @Binding var tax: CurrencyObject
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(items: $items, tax: $tax, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}
}

class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
    var items: Binding<[ReciptItem]>
    var tax: Binding<CurrencyObject>
    var parent: ScanDocumentView
    
    init(items: Binding<[ReciptItem]>, tax: Binding<CurrencyObject>, parent: ScanDocumentView) {
        self.items = items
        self.tax = tax
        self.parent = parent
    }
    
    func documentCameraViewController(
        _ controller: VNDocumentCameraViewController,
        didFinishWith scan: VNDocumentCameraScan
    ) {
        let extractedImages = extractImages(from: scan)
        let recognitionResponse: TextRecognitionResponse = recognizeText(from: extractedImages)
        items.wrappedValue = recognitionResponse.items
        tax.wrappedValue = recognitionResponse.tax
        parent.presentationMode.wrappedValue.dismiss()
    }
    
    func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
        var extractedImages: [CGImage] = []
        for index in 0..<scan.pageCount {
            let extractedImage = scan.imageOfPage(at: index)
            guard let cgImage = extractedImage.cgImage else { continue }
            extractedImages.append(cgImage)
        }
        return extractedImages
    }
}
