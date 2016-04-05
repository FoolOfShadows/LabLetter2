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
			let regex = try NSRegularExpression(pattern: leadingAndTrailingWhitespacePattern, options: .DotMatchesLineSeparators)
			let range = NSMakeRange(0, self.characters.count)
			let trimmedString = regex.stringByReplacingMatchesInString(self, options: .ReportProgress, range:range, withTemplate:"\n")
			
			return trimmedString
		} catch _ {
			return self
		}
	}
}

//Set all text fields to empty
func clearFields(nameArray: [NSTextField!]) {
	for name in nameArray {
	name.stringValue = ""
}
}

func stripOutExtraWords(theTextToClean: String, textToRemove: [String]) ->String {
	var newText = theTextToClean
	for phrase in textToRemove {
		newText = newText.stringByReplacingOccurrencesOfString(phrase, withString: "")
		newText = newText.stringByTrimmingLeadingAndTrailingWhitespace()
	}
	return newText
}

func getDateRegEx(dateLine: String) -> String {
	var theMatch = ""
	let lineCount = dateLine.characters.count
	let textAsNSString = dateLine as NSString
	let theRegEx = try! NSRegularExpression(pattern: "\\d./\\d./\\d*", options: [])
	for match in theRegEx.matchesInString(dateLine, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
		for item in 0..<match.numberOfRanges {
			theMatch = textAsNSString.substringWithRange(match.rangeAtIndex(item))
			let startDigit = theMatch.characters.first
			if startDigit == "0" {
				theMatch = String(theMatch.characters.dropFirst())
			}
		}
	}
	
	return theMatch
}

func getPatientDemo(theText:[String], thePatient: PatientData) -> PatientData {
	for (lineNumber, currentLine) in theText.enumerate() {
		if currentLine.rangeOfString("COLLECTED") != nil {
			thePatient.labDate = getDateRegEx(currentLine)
			thePatient.dateField.stringValue = thePatient.labDate
		}
		if currentLine.rangeOfString("yrs") != nil {
			thePatient.ptName = theText[lineNumber - 2]
			thePatient.nameField.stringValue = thePatient.ptName
		}
		if currentLine.rangeOfString("yrs F") != nil {
			thePatient.ptGender = "F"
		} else if currentLine.rangeOfString("yrs M") != nil {
			thePatient.ptGender = "M"
		}
	}
	
	return thePatient
}

func prepTheCopiedText(phrasesToRemove:[String]) -> [String] {
	var results = [""]
	let myPasteboard = NSPasteboard.generalPasteboard()
	let copiedText = myPasteboard.stringForType("public.utf8-plain-text")
	if let fullText = copiedText {
		let strippedText = stripOutExtraWords(fullText, textToRemove: phrasesToRemove)
		results = strippedText.componentsSeparatedByString("\n")
	}
	
	return results
}	

func extractValues(theLabData: [LabData], thePatient: PatientData, wordsToRemove: [String]) {
	
	let preppedText = prepTheCopiedText(wordsToRemove)
	let thisPatient = getPatientDemo(preppedText, thePatient: thePatient)
	
	if !preppedText.isEmpty {
		for theLab in theLabData {
			for (lineNumber, line) in preppedText.enumerate() {
				if line.hasPrefix(theLab.identifyingText) {
					theLab.labValue = preppedText[lineNumber + 1]
					if let unwrappedLabValue = theLab.labValue {
						theLab.controller.stringValue = unwrappedLabValue + theLab.labRange(thisPatient.ptGender)
					}
				}
			}
		}
	}
}
