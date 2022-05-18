//
//  TextRecognition.swift
//  DVY
//
//  Created by Matthew Meyerink on 5/17/22.
//

import Foundation
import VisionKit
import Vision

class TextRecognitionResponse {
    var items: [ReciptItem] = []
    var tax: CurrencyObject = CurrencyObject(price: 0.0)
}

func recognizeText(from images: [CGImage]) -> TextRecognitionResponse {
    let response = TextRecognitionResponse()
    
    let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
        guard error == nil else { return }
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        let maximumRecognitionCandidates = 1
        
        var currentItemName: String? = nil
        var currentItemPrice: Double? = nil
        var currentTax: Double = 0.0
        let invalidItems = ["total", "due", "visa"]
        
        for observation in observations {
            let candidate = observation.topCandidates(maximumRecognitionCandidates).first
            
            if (candidate != nil) {
                var updatedString = candidate!.string.replacingOccurrences(of: "$", with: "")
                updatedString = updatedString.replacingOccurrences(of: ",", with: ".")
                
                currentItemPrice = Double(updatedString)
                
                if (currentItemName != nil && currentItemPrice != nil && candidate!.string.contains(".") && currentItemPrice != 0) {
                    var containsInvalidWord = false
                    
                    for word in invalidItems {
                        if (currentItemName!.localizedCaseInsensitiveContains(word)) {
                            containsInvalidWord = true
                            break
                        }
                    }
                    
                    let containsTax = currentItemName!.localizedCaseInsensitiveContains("tax")
                    
                    if (containsTax && currentItemPrice! > currentTax) {
                        currentTax = currentItemPrice!
                        response.tax = CurrencyObject(price: currentTax)
                    } else if (!containsInvalidWord && !containsTax) {
                        response.items.append(ReciptItem(name: currentItemName!, price: currentItemPrice!))
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
    
    return response
}
