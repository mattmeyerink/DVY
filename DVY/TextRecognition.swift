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
    // Initialize the response object that will hold the items and tax information
    let response = TextRecognitionResponse()
    
    // Perform text recognition on each scan that was captured
    for image in images {
        // Create a recognition request with the response object to be applied to the scans
        let recognizeTextRequest = createRecognitionRequest(response: response, imageHeight: image.height)
        recognizeTextRequest.recognitionLevel = .accurate
        
        let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
        try? requestHandler.perform([recognizeTextRequest])
    }
    
    return response
}

func createRecognitionRequest(response: TextRecognitionResponse, imageHeight: Int) -> VNRecognizeTextRequest {
    return VNRecognizeTextRequest { (request, error) in
        guard error == nil else { return }
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        let lines = sortImagesByLine(observations: observations, imageHeight: imageHeight)
        
        let maximumRecognitionCandidates = 1
        
        var currentTax: Double = 0.0
        
        for line in lines {
            // If there are less than two items on the line can't have a name and a price
            if (line.count < 2) {
                continue
            }
            
            // Get the last observation on the line. This is most likely a the price
            let lastString = line.last?.topCandidates(maximumRecognitionCandidates).first?.string
            
            if (lastString == nil) {
                continue
            }
            
            let linePrice = formatStringToPrice(scannedString: lastString!)
            
            // If the last item is not a price, keep looking for more items
            if (linePrice == nil || linePrice == 0 || !lastString!.contains(".")) {
                continue
            }
            
            // Add each observation beore the price to the items name
            var itemName = ""
            for i in 0..<(line.count - 1) {
                let candidate = line[i].topCandidates(maximumRecognitionCandidates).first
                if (candidate == nil) { continue }
                itemName += candidate!.string + " "
            }
            
            let containsTax = itemName.localizedCaseInsensitiveContains("tax")
            
            // If the item contains the word tax, consider it towards the tax of the receipt
            if (containsTax && linePrice! > currentTax) {
                currentTax = linePrice!
                response.tax = CurrencyObject(price: currentTax)
                continue
            }
            
            // if the name doesn't contain an invalid word (like tax or total) add it to the list of itemspo
            if (!containsTax && !nameContainsInvalidWord(name: itemName)){
                response.items.append(ReciptItem(name: itemName, price: linePrice!))
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

func sortImagesByLine(observations: [VNRecognizedTextObservation], imageHeight: Int) -> [[VNRecognizedTextObservation]] {
    // Sort the observation objects by HEIGHT on the receipt
    let sortedObservations = observations.sorted(by: { $0.boundingBox.standardized.minY > $1.boundingBox.standardized.minY })
    
    // Fill in an array of lines on the receipt by matching up all observations with the same height
    var lines: [[VNRecognizedTextObservation]] = []
    var currentLine: [VNRecognizedTextObservation] = []
    
    for observation in sortedObservations {
        // Begin an new line if there is nothing on the line yet
        if (currentLine.count == 0) {
            currentLine.append(observation)
            continue
        }
        
        // Calculate the percent difference between the last observation and the current one
        let lastElementHeight = currentLine.last!.boundingBox.minY * CGFloat(imageHeight)
        let currentElementHeight = observation.boundingBox.minY * CGFloat(imageHeight)
        let heightDifference = abs(lastElementHeight - currentElementHeight)
        
        // If the height of the lines is similar enough, add the observation to the current line
        let ESTIMATED_LINE_HEIGHT = 22.5
        if (heightDifference < ESTIMATED_LINE_HEIGHT) {
            currentLine.append(observation)
            continue
        }
        
        // Start a new line since the item wasn't included on the last line
        lines.append(currentLine)
        currentLine = [observation]
    }
    
    // Make sure to add the last line that was created
    lines.append(currentLine)
    
    // Sort each line by the WIDTH on the receipt to read from left to right
    for i in 0..<lines.count {
        lines[i].sort(by: { $0.boundingBox.standardized.minX < $1.boundingBox.standardized.minX })
    }
    
    return lines
}
