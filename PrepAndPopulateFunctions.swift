//
//  Functions.swift
//  Lab Letter 2
//
//  Created by Fool on 5/6/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

import Cocoa

//Trim whitespace string extension.  Cribbed from raywenderlich.com.  Updated for Swift 2.0
extension String {
	func stringByTrimmingLeadingAndTrailingWhitespace() -> String {
		let leadingAndTrailingWhitespacePattern = "\\s*\\n"
		//"(?:^\\s+)|(?:\\s+$)"
		
		do {
			let regex = try RegularExpression(pattern: leadingAndTrailingWhitespacePattern, options: .dotMatchesLineSeparators)
			let range = NSMakeRange(0, self.characters.count)
			let trimmedString = regex.stringByReplacingMatches(in: self, options: .reportProgress, range:range, withTemplate:"\n")
			
			return trimmedString
		} catch _ {
			return self
		}
	}
}

//Set all text fields to empty
func clearFields(nameArray: [NSTextField]) {
	for name in nameArray {
	name.stringValue = ""
}
}

func stripOutExtraWords(theTextToClean: String, textToRemove: [String]) ->String {
	var newText = theTextToClean
	for phrase in textToRemove {
		newText = newText.replacingOccurrences(of: phrase, with: "")
		newText = newText.stringByTrimmingLeadingAndTrailingWhitespace()
	}
	return newText
}

func getDateRegEx(dateLine: String) -> String {
	var theMatch = ""
	let lineCount = dateLine.characters.count
	let textAsNSString = dateLine as NSString
	let theRegEx = try! RegularExpression(pattern: "\\d./\\d./\\d*", options: [])
	for match in theRegEx.matches(in: dateLine, options: [], range: NSMakeRange(0, lineCount)) as [TextCheckingResult] {
		for item in 0..<match.numberOfRanges {
			theMatch = textAsNSString.substring(with: match.range(at: item))
			let startDigit = theMatch.characters.first
			if startDigit == "0" {
				theMatch = String(theMatch.characters.dropFirst())
			}
		}
	}
	
	return theMatch
}

func getPatientDemo(theText:[String], thePatient: PatientData) -> PatientData {
	for (lineNumber, currentLine) in theText.enumerated() {
		if currentLine.range(of: "COLLECTED") != nil {
			thePatient.labDate = getDateRegEx(dateLine: currentLine)
			thePatient.dateField.stringValue = thePatient.labDate
		}
		if currentLine.range(of: "yrs") != nil {
			thePatient.ptName = theText[lineNumber - 2]
			thePatient.nameField.stringValue = thePatient.ptName
		}
		if currentLine.range(of: "yrs F") != nil {
			thePatient.ptGender = "F"
		} else if currentLine.range(of: "yrs M") != nil {
			thePatient.ptGender = "M"
		}
	}
	
	return thePatient
}

func prepTheCopiedText(phrasesToRemove:[String]) -> [String] {
	var results = [""]
	let myPasteboard = NSPasteboard.general()
	let copiedText = myPasteboard.string(forType: "public.utf8-plain-text")
	if let fullText = copiedText {
		let strippedText = stripOutExtraWords(theTextToClean: fullText, textToRemove: phrasesToRemove)
		results = strippedText.components(separatedBy: "\n")
	}
	
	return results
}	

func extractValues(theLabData: [LabData], thePatient: PatientData, wordsToRemove: [String]) {
	
	let preppedText = prepTheCopiedText(phrasesToRemove: wordsToRemove)
	let thisPatient = getPatientDemo(theText: preppedText, thePatient: thePatient)
	
	if !preppedText.isEmpty {
		for theLab in theLabData {
			for (lineNumber, line) in preppedText.enumerated() {
				if line.hasPrefix(theLab.identifyingText) {
					theLab.labValue = preppedText[lineNumber + 1]
					if let unwrappedLabValue = theLab.labValue {
						theLab.controller.stringValue = unwrappedLabValue + theLab.labRange(ptGender: thisPatient.ptGender)
					}
				}
			}
		}
	}
}
