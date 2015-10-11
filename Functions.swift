//
//  Functions.swift
//  Lab Letter 2
//
//  Created by Fool on 5/6/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

import Cocoa

class Regex {
	let internalExpression: NSRegularExpression
	let pattern: String
	
	init(_ pattern: String) {
		self.pattern = pattern
		//var error: NSError?
		self.internalExpression = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
	}
	
	func test(input: String) -> Bool {
		let matches = self.internalExpression.matchesInString(input, options: [], range:NSMakeRange(0, (input.characters.count)))
		return matches.count > 0
	}
}

//Set all text fields to empty
func clearFields(nameArray: [NSTextField!]) {
	for name in nameArray {
	name.stringValue = ""
}
}

//Remove certain word combinations from the main block of text
//to make subsequent searches for similar terms easier and
//more reliable to execute
func stripOutExtraWords(theClipboard: String) ->String {
	var newText = theClipboard
	let extraPhrases = ["CORTISOL, RANDOM Show test details", "DRL MICROALBUMIN/CREATININE, RANDOM Show test details", "MICROALBUMIN/CREATININE, RANDOM AND RATIO Show test details", "C-REACTIVE PROTEIN Show test details", "CK, TOTAL Show test details", "VITAMIN B-12 Show test details", "TSH Show test details", "adult patients with a TSH value between", "RHEUMATOID FACTOR,QUANT Show test details", "SEDIMENTATION RATE Show test details", "FREE T3 Show test details", "FREE T4 Show test details", "TSH Show test details", "VITAMIN D, 25 OH Show test details", "HEMOGLOBIN A1c W/EAG AND INT CHART Show test details", "ML/MIN/1.73", "mL/min/1.73", "HGB A1C                     ESTIMATED AVERAGE GLUCOSE", "PSA, TOTAL, MEDICARE SCREEN", "AMYLASE Show test details", "LIPASE Show test details", "GASTRIN Show test details", "FOLLICLE STIM HORMONE Show test details", "(HEMATOCRIT %)"]
	for phrase in extraPhrases {
		newText = newText.stringByReplacingOccurrencesOfString(phrase, withString: "")
	}
	return newText
}



func regExMatching(currentLine: String, fieldAndValue: Dictionary<NSTextField, String>) {
	var theMatch = ""
	let theRegExp = try! NSRegularExpression(pattern: "\\b\\d+", options: [])
	let theRegExp2 = try! NSRegularExpression(pattern: "\\b\\d+\\.\\d+", options: [])
	let baseRegExp = "\\d+\\.\\d+"
	let lineCount = currentLine.characters.count
	let currentText = currentLine as NSString
	
	
	for i in fieldAndValue {
		let theWord = i.1
		
		if currentLine.rangeOfString(theWord) != nil {
			if Regex(baseRegExp).test(currentLine) == true {
				for match in theRegExp2.matchesInString(currentText as String, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
					for item in 0..<match.numberOfRanges {
						theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
						i.0.stringValue = theMatch
					}
				}
			} else {
				for match in theRegExp.matchesInString(currentText as String, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
					for item in 0..<match.numberOfRanges {
						theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
						i.0.stringValue = theMatch
					}
				}
				
			}
		}
	}
}

func regExDate(currentLine: String, fieldAndValue: Dictionary<NSTextField, String>) {
	var theMatch = ""
	let theRegExp = try! NSRegularExpression(pattern: "\\d./\\d./\\d*", options: [])
	let lineCount = currentLine.characters.count
	let currentText = currentLine as NSString
	
	for i in fieldAndValue {
		let theWord = i.1
		
		if currentLine.rangeOfString(theWord) != nil {
			for match in theRegExp.matchesInString(currentText as String, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
				for item in 0..<match.numberOfRanges {
					theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
					i.0.stringValue = theMatch
				}
			}
		}
	}
}

func regExName(currentLine: String, fieldAndValue: Dictionary<NSTextField, String>) {
	var theMatch = ""
	let theRegExp = try! NSRegularExpression(pattern: "\\b[A-Z][a-z]*\\s[A-Z][a-z]*", options: [])
	let lineCount = currentLine.characters.count
	let currentText = currentLine as NSString
	
	for i in fieldAndValue {
		let theWord = i.1
		
		if currentLine.rangeOfString(theWord) != nil {
			for match in theRegExp.matchesInString(currentText as String, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
				for item in 0..<match.numberOfRanges {
					theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
					i.0.stringValue = theMatch
				}
			}
		}
	}
}

func extractValues(wantedText:Dictionary<NSTextField, String>) {
	var theMatch = ""
	let pasteBoard = NSPasteboard.generalPasteboard()
	let theClipboard = pasteBoard.stringForType("public.utf8-plain-text")
	let newText = stripOutExtraWords(theClipboard!)
	let theSplitClipboard = newText.componentsSeparatedByString("\n")
	let theRegExp = try! NSRegularExpression(pattern: "\\b\\d+", options: [])
	let theRegExp2 = try! NSRegularExpression(pattern: "\\b\\d+\\.\\d+", options: [])
	let baseRegExp = "\\d+\\.\\d+"
	let numberOfLines = theSplitClipboard.count
	
	if !theSplitClipboard.isEmpty {
		for i in wantedText {
			var lineNumber = -1
			var actualLineNumber = 0
			let theWord = i.1
			for currentLine in theSplitClipboard {
				lineNumber++
				if lineNumber < (numberOfLines - 1) {
				actualLineNumber = lineNumber + 1
				}
				let actualLine = theSplitClipboard[actualLineNumber]
				let lineCount = actualLine.characters.count
				let currentText = actualLine as NSString
				if currentLine.rangeOfString(theWord) != nil {
					if Regex(baseRegExp).test(actualLine) == true {
					for match in theRegExp2.matchesInString(currentText as String, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
						for item in 0..<match.numberOfRanges {
							theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
							i.0.stringValue = theMatch
						}
					}
					} else {
						for match in theRegExp.matchesInString(currentText as String, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
							for item in 0..<match.numberOfRanges {
								theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
								i.0.stringValue = theMatch
							}
						}

					}
				}
			}
		}
	}
}

func extractComplicatedValues(textField:[NSTextField], goodText:[String], badText:[String]) {
	var theMatch = ""
	let pasteBoard = NSPasteboard.generalPasteboard()
	let theClipboard = pasteBoard.stringForType("public.utf8-plain-text")
	let newText = stripOutExtraWords(theClipboard!)
	let theSplitClipboard = newText.componentsSeparatedByString("\n")
	let theRegExp = try! NSRegularExpression(pattern: "\\b\\d+", options: [])
	let theRegExp2 = try! NSRegularExpression(pattern: "\\b\\d+\\.\\d+", options: [])
	let baseRegExp = "\\d+\\.\\d+"
	let numberOfLines = theSplitClipboard.count
	
	for var i = 0; i < textField.count; i++ {
		var lineNumber = -1
		var actualLineNumber = 0
		for currentLine in theSplitClipboard {
			lineNumber++
			if lineNumber < (numberOfLines - 1) {
				actualLineNumber = lineNumber + 1
			}
			let actualLine = theSplitClipboard[actualLineNumber]
			let lineCount = actualLine.characters.count
			let currentText = actualLine as NSString
			if currentLine.rangeOfString(goodText[i]) != nil
				&& currentLine.rangeOfString(badText[i]) == nil {
					if Regex(baseRegExp).test(actualLine) == true {
						for match in theRegExp2.matchesInString(currentText as String, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
							for item in 0..<match.numberOfRanges {
								theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
								textField[i].stringValue = theMatch
							}
						}
					} else {
						for match in theRegExp.matchesInString(currentText as String, options: [], range: NSMakeRange(0, lineCount)) as [NSTextCheckingResult] {
							for item in 0..<match.numberOfRanges {
								theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
								textField[i].stringValue = theMatch
							}
						}
					}
			}
		}
	}
}

func extractTheOutliers() {
	let outlierTerms = ["AMYLASE", "LIPASE", "GASTRIN", "FOLLICLE STIM HORMONE"]
}

//Turns out the name ISN'T on the same line with the age, rendering this useless
//There's important bits of learning here, though, so I'm not throwing it out yet
//func getName(nameLine: String) -> String {
//	var theName = ""
//	let stringLength = nameLine.characters.count
//	let ageRegEx = try! NSRegularExpression(pattern:"\\d* yrs ", options: [])
//	if let nameMatch = ageRegEx.firstMatchInString(nameLine, options: [], range: NSRange(location: 0, length: stringLength)) {
//		let ageMatch = (nameLine as NSString).substringWithRange(nameMatch.range)
//		let start = nameLine.startIndex
//		let endPoint = Array(arrayLiteral: ageMatch)[0]
//		let end = find(nameLine, endPoint)
//		theName = nameLine[start..<end!]
//	}
//	return theName
//}


