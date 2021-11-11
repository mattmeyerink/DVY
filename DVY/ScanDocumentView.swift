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
    @Binding var total: CurrencyObject
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(items: $items, total: $total, tax: $tax, parent: self)
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
    var total: Binding<CurrencyObject>
    var tax: Binding<CurrencyObject>
    var parent: ScanDocumentView
    
    init(items: Binding<[ReciptItem]>, total: Binding<CurrencyObject>, tax: Binding<CurrencyObject>, parent: ScanDocumentView) {
        self.items = items
        self.total = total
        self.tax = tax
        self.parent = parent
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        let extractedImages = extractImages(from: scan)
        let processedText = recognizeText(from: extractedImages)
        items.wrappedValue = processedText
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
    
    func recognizeText(from images: [CGImage]) -> [ReciptItem] {
        var recognizedItems: [ReciptItem] = []
        let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
            guard error == nil else { return }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            let maximumRecognitionCandidates = 1
            var currentItemName: String? = nil
            var currentItemPrice: Double? = nil
            for observation in observations {
                let candidate = observation.topCandidates(maximumRecognitionCandidates).first
                if (candidate != nil) {
                    if (currentItemName != nil) {
                        currentItemPrice = Double(candidate!.string.replacingOccurrences(of: "$", with: ""))
                        if (currentItemPrice != nil) {
                            if (currentItemName!.localizedCaseInsensitiveContains("total")) {
                                self.total.wrappedValue = CurrencyObject(price: currentItemPrice!)
                            } else if (currentItemName!.localizedCaseInsensitiveContains("tax")) {
                                self.tax.wrappedValue = CurrencyObject(price: currentItemPrice!)
                            } else {
                                recognizedItems.append(ReciptItem(name: currentItemName!, price: currentItemPrice!))
                            }
                        }
                        currentItemName = nil
                        currentItemPrice = nil
                    } else {
                        currentItemName = candidate!.string
                    }
                }
            }
        }
        
        recognizeTextRequest.recognitionLevel = .accurate
        
        for image in images {
            let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
            try? requestHandler.perform([recognizeTextRequest])
        }
        
        return recognizedItems
    }
}
