//
//  ScanDocumentView.swift
//  DVY
//
//  Created by Matthew Meyerink on 10/16/21.
//

import SwiftUI
import VisionKit

struct ScanDocumentView: UIViewControllerRepresentable {
    @Binding var recognizedText: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(recognizedText: $recognizedText, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}
}

class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
    var recognizedText: Binding<String>
    var parent: ScanDocumentView
    
    init(recognizedText: Binding<String>, parent: ScanDocumentView) {
        self.recognizedText = recognizedText
        self.parent = parent
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {}
}
