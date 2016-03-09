//
//  LabDataClass.swift
//  Lab Letter 2
//
//  Created by Fool on 2/24/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class LabData {
	var controller: NSTextField
	var identifyingText: String
	var outputText: String = ""
	var labValue: String?
	
	
	init(controller: NSTextField, idText: String) {
		self.controller = controller
		self.identifyingText = idText
	}
	
	func labRange(ptGender: String) -> String {
		return ""
	}
}

class LabDataPosNeg: LabData {
	var outputTitle: String
	
	init(controller: NSTextField, idText: String, outputTitle:String) {
		self.outputTitle = outputTitle
		super.init(controller: controller, idText: idText)
	}
}

class LabDataWithHighLow: LabDataPosNeg {
	var highValuesFemale: Double
	var lowValuesFemale: Double
	var highValuesMale: Double
	var lowValuesMale: Double
	
	init(controller: NSTextField, idText: String, highFemale: Double, lowFemale: Double, highMale: Double, lowMale: Double, outputTitle: String) {
		self.highValuesFemale = highFemale
		self.lowValuesFemale = lowFemale
		self.highValuesMale = highMale
		self.lowValuesMale = lowMale
		super.init(controller: controller, idText: idText, outputTitle: outputTitle)
	}
	
	override func labRange(ptGender: String) -> String {
		var results = ""
		if var theLabValue = self.labValue {
			//Check if the string contains a less than or greater than sign
			if theLabValue.characters.contains("<") || theLabValue.characters.contains(">") {
				//If it does, remove the sign (we're assuming it's the first character)
				theLabValue = String(theLabValue.characters.dropFirst())
			}
			//Convert the lab value from a string into a double
			if let labAsDouble = Double(theLabValue){
				if ptGender == "F" {
					switch labAsDouble {
					case _ where labAsDouble < self.lowValuesFemale: results = LabValue.low.rawValue
					case _ where labAsDouble > self.highValuesFemale: results = LabValue.high.rawValue
					default: results = LabValue.normal.rawValue
					}
				} else if ptGender == "M" {
					switch labAsDouble {
					case _ where labAsDouble < self.lowValuesMale: results = LabValue.low.rawValue
					case _ where labAsDouble > self.highValuesMale: results = LabValue.high.rawValue
					default: results = LabValue.normal.rawValue
					}
				}
			}
		}
		
		return results
	}
}

class LabDataTSH: LabDataWithHighLow {
	
	override func labRange(ptGender: String) -> String {
		var results = ""
		if var theLabValue = self.labValue {
			//Check if the string contains a less than or greater than sign
			if theLabValue.characters.contains("<") || theLabValue.characters.contains(">") {
				//If it does, remove the sign (we're assuming it's the first character)
				theLabValue = String(theLabValue.characters.dropFirst())
			}
			if let labAsDouble = Double(theLabValue) {
				if ptGender == "F" {
					switch labAsDouble {
					case _ where labAsDouble < self.lowValuesFemale: results = LabValue.overactive.rawValue
					case _ where labAsDouble > self.highValuesFemale: results = LabValue.underactive.rawValue
					default: results = LabValue.normal.rawValue
					}
				} else if ptGender == "M" {
					switch labAsDouble {
					case _ where labAsDouble < self.lowValuesMale: results = LabValue.overactive.rawValue
					case _ where labAsDouble > self.highValuesMale: results = LabValue.underactive.rawValue
					default: results = LabValue.normal.rawValue
					}
				}
			}
		}
		
		return results
	}
}



class LabDataGlucose: LabDataWithHighLow {
	var borderlineFemale: Double
	var borderlineMale: Double
	var theLabValue: String?
	
	init(controller: NSTextField, idText: String, highFemale: Double, lowFemale: Double, highMale: Double, lowMale: Double, borderlineFemale: Double, borderlineMale: Double, outputTitle: String) {
		self.borderlineFemale = borderlineFemale
		self.borderlineMale = borderlineMale
		super.init(controller: controller, idText: idText, highFemale: highFemale, lowFemale: lowFemale, highMale: highMale, lowMale: lowMale, outputTitle: outputTitle)
	}
	
	override func labRange(ptGender: String) -> String {
		var results = ""
		if let theLabValue = self.labValue {
			if let labAsDouble = Int(theLabValue) {
				switch labAsDouble {
				case 0..<65 : results = LabValue.low.rawValue
				case 65..<101 : results = LabValue.normal.rawValue
				case 101..<105 : results = LabValue.borderline.rawValue
				default: results = LabValue.high.rawValue
				}
			}
		}
		
		return results
	}
}







