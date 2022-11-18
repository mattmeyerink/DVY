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
    
    if (images.count <= 0) {
        return response
    }
    
    // Only perform text recognition on the first scan that was captured
    let image = images[0]
    
    // Create a recognition request with the response object to be applied to the scan
    let recognizeTextRequest = createRecognitionRequest(response: response, imageHeight: image.height)
    recognizeTextRequest.recognitionLevel = .accurate
    
    let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
    try? requestHandler.perform([recognizeTextRequest])
    
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
            if (line.count < 1) {
                continue
            }
            
            // Create an array of each individual string on the line
            var itemsInLine: [String] = []
            for item in line {
                guard let word = item.topCandidates(maximumRecognitionCandidates).first?.string else { continue }
                itemsInLine += word.components(separatedBy: " ")
            }
            
            // Pop the last string on the line. If there is a price on the line its the last string.
            let lastString = itemsInLine.popLast()
            
            if (lastString == nil) {
                continue
            }
            
            let linePrice = formatStringToPrice(scannedString: lastString!)
            
            // If the last string is not a price, keep looking for more items
            if (linePrice == nil || linePrice! <= 0 || !lastString!.contains(".")) {
                continue
            }
            
            // Join each string before the price to be the items name
            var itemName = itemsInLine.joined(separator: " ")
            
            if (itemName == "") {
                itemName = "🧐 🤷‍♂️ 🤔"
            }
            
            let containsTax = itemName.localizedCaseInsensitiveContains("tax")
            
            // If the item contains the word tax, consider it towards the tax of the receipt
            if (containsTax && linePrice! > currentTax) {
                currentTax = linePrice!
                response.tax = CurrencyObject(price: currentTax)
                continue
            }
            
            // if the name doesn't contain an invalid word (like tax or total) add it to the list of items
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
    let invalidItems = ["total", "due", "visa", "xxxx"]
    
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
