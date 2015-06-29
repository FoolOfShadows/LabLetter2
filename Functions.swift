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
		var error: NSError?
		self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)!
	}
	
	func test(input: String) -> Bool {
		let matches = self.internalExpression.matchesInString(input, options: nil, range:NSMakeRange(0, count(input)))
		return matches.count > 0
	}
}


func clearFields(nameArray: [NSTextField!]) {
	for name in nameArray {
	name.stringValue = ""
}
}

func stripOutExtraWords(theClipboard: String) ->String {
	var newText = theClipboard
	let extraPhrases = ["CORTISOL, RANDOM Show test details", "DRL MICROALBUMIN/CREATININE, RANDOM Show test details", "C-REACTIVE PROTEIN Show test details", "CK, TOTAL Show test details", "VITAMIN B-12 Show test details", "TSH Show test details", "adult patients with a TSH value between", "RHEUMATOID FACTOR,QUANT Show test details", "SEDIMENTATION RATE Show test details", "FREE T3 Show test details", "FREE T4 Show test details", "TSH Show test details", "VITAMIN D, 25 OH Show test details", "HEMOGLOBIN A1c W/EAG AND INT CHART Show test details", "mL/min/1.73"]
	for phrase in extraPhrases {
		newText = newText.stringByReplacingOccurrencesOfString(phrase, withString: "")
	}
	return newText
}



func regExMatching(currentLine: String, fieldAndValue: Dictionary<NSTextField, String>) {
	var theMatch = ""
	let theRegExp = NSRegularExpression(pattern: "\\b\\d+", options: NSRegularExpressionOptions.allZeros, error: nil)
	let theRegExp2 = NSRegularExpression(pattern: "\\b\\d+\\.\\d+", options: NSRegularExpressionOptions.allZeros, error: nil)
	let baseRegExp = "\\d+\\.\\d+"
	let lineCount = count(currentLine)
	let currentText = currentLine as NSString
	
	for i in fieldAndValue {
		let theWord = i.1
		
		if currentLine.rangeOfString(theWord) != nil {
			if Regex(baseRegExp).test(currentLine) == true {
				for match in theRegExp2!.matchesInString(currentText as String, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, lineCount)) as! [NSTextCheckingResult] {
					for item in 0..<match.numberOfRanges {
						theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
						i.0.stringValue = theMatch
					}
				}
			} else {
				for match in theRegExp!.matchesInString(currentText as String, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, lineCount)) as! [NSTextCheckingResult] {
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
	let theRegExp = NSRegularExpression(pattern: "\\d./\\d./\\d*", options: NSRegularExpressionOptions.allZeros, error: nil)
	let lineCount = count(currentLine)
	let currentText = currentLine as NSString
	
	for i in fieldAndValue {
		let theWord = i.1
		
		if currentLine.rangeOfString(theWord) != nil {
			for match in theRegExp!.matchesInString(currentText as String, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, lineCount)) as! [NSTextCheckingResult] {
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
	let theRegExp = NSRegularExpression(pattern: "\\b[A-Z][a-z]*\\s[A-Z][a-z]*", options: NSRegularExpressionOptions.allZeros, error: nil)
	let lineCount = count(currentLine)
	let currentText = currentLine as NSString
	
	for i in fieldAndValue {
		let theWord = i.1
		
		if currentLine.rangeOfString(theWord) != nil {
			for match in theRegExp!.matchesInString(currentText as String, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, lineCount)) as! [NSTextCheckingResult] {
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
	var pasteBoard = NSPasteboard.generalPasteboard()
	let theClipboard = pasteBoard.stringForType("public.utf8-plain-text")
	let newText = stripOutExtraWords(theClipboard!)
	let theSplitClipboard = newText.componentsSeparatedByString("\n")
	let theRegExp = NSRegularExpression(pattern: "\\b\\d+", options: NSRegularExpressionOptions.allZeros, error: nil)
	let theRegExp2 = NSRegularExpression(pattern: "\\b\\d+\\.\\d+", options: NSRegularExpressionOptions.allZeros, error: nil)
	let baseRegExp = "\\d+\\.\\d+"
	
	if !theSplitClipboard.isEmpty {
		for i in wantedText {
			let theWord = i.1
			for currentLine in theSplitClipboard {
				let lineCount = count(currentLine)
				let currentText = currentLine as NSString
				if currentLine.rangeOfString(theWord) != nil {
					if Regex(baseRegExp).test(currentLine) == true {
					for match in theRegExp2!.matchesInString(currentText as String, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, lineCount)) as! [NSTextCheckingResult] {
						for item in 0..<match.numberOfRanges {
							theMatch = currentText.substringWithRange(match.rangeAtIndex(item))
							i.0.stringValue = theMatch
						}
					}
					} else {
						for match in theRegExp!.matchesInString(currentText as String, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, lineCount)) as! [NSTextCheckingResult] {
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

//Turns out the name ISN'T on the same line with the age, rendering this useless
//There's important bits of learning here, though, so I'm not throwing it out yet
func getName(nameLine: String) -> String {
	var theName = ""
	let stringLength = count(nameLine)
	let ageRegEx = NSRegularExpression(pattern:"\\d* yrs ", options: nil, error: nil)!
	if let nameMatch = ageRegEx.firstMatchInString(nameLine, options: nil, range: NSRange(location: 0, length: stringLength)) {
		let ageMatch = (nameLine as NSString).substringWithRange(nameMatch.range)
		let start = nameLine.startIndex
		let endPoint = Array(ageMatch)[0]
		let end = find(nameLine, endPoint)
		theName = nameLine[start..<end!]
	}
	return theName
}


