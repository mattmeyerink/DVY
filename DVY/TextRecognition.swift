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
    
    let recognizeTextRequest = createRecognitionRequest(response: response)
    
    recognizeTextRequest.recognitionLevel = .accurate
    
    for image in images {
        let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
        try? requestHandler.perform([recognizeTextRequest])
    }
    
    return response
}

func createRecognitionRequest(response: TextRecognitionResponse) -> VNRecognizeTextRequest {
    return VNRecognizeTextRequest { (request, error) in
        guard error == nil else { return }
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        let maximumRecognitionCandidates = 1
        
        var currentItemName: String? = nil
        var currentItemPrice: Double? = nil
        var currentTax: Double = 0.0
        
        for observation in observations {
            let candidate = observation.topCandidates(maximumRecognitionCandidates).first
            if (candidate == nil) { continue }
            
            currentItemPrice = formatStringToPrice(scannedString: candidate!.string)
            
            if (isCompleteItem(name: currentItemName, price: currentItemPrice, rawText: candidate!.string)) {
                let containsTax = currentItemName!.localizedCaseInsensitiveContains("tax")
                
                if (containsTax && currentItemPrice! > currentTax) {
                    currentTax = currentItemPrice!
                    response.tax = CurrencyObject(price: currentTax)
                } else if (!containsTax && !nameContainsInvalidWord(name: currentItemName)) {
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

func formatStringToPrice(scannedString: String) -> Double? {
    var formattedString = scannedString
    
    formattedString = formattedString.replacingOccurrences(of: "$", with: "")
    formattedString = formattedString.replacingOccurrences(of: ",", with: ".")
    
    return Double(formattedString)
}

func isCompleteItem(name: String?, price: Double?, rawText: String) -> Bool {
        let itemNameValid = name != nil
        let itemPriceValid = price != nil && price != 0 && rawText.contains(".")
    
        return itemNameValid && itemPriceValid
}

func nameContainsInvalidWord(name: String?) -> Bool {
    var nameIsInvalid = false
    let invalidItems = ["total", "due", "visa"]
    
    for word in invalidItems {
        if (name!.localizedCaseInsensitiveContains(word)) {
            nameIsInvalid = true
            break
        }
    }
    
    return nameIsInvalid
}
