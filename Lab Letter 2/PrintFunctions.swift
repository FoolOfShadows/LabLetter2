//
//  PrintFunctions.swift
//  Lab Letter 2
//
//  Created by Fool on 3/2/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

func generateIndividualResultString(_ theHeader: String, theLabs:[LabDataPosNeg], checkForNorms:Bool) ->String {
	var result = String()
	var theArray = [String]()
	//If the checkForNorms flag is true, develop the string to only report on 
	//abnormal results.
	if checkForNorms == true {
		var normCount = 0
		var arrayCount = 0
		for lab in theLabs {
			if !lab.controller.stringValue.isEmpty {
				arrayCount+=1
				if lab.controller.stringValue.contains("Normal") {
					normCount+=1
				} else {
					let theString = "\(lab.outputTitle) \(lab.controller.stringValue)"
					theArray.append(theString)
				}
			}
		}
		if (normCount == arrayCount) && (normCount != 0) {
			return "\(theHeader.uppercased()) results are all within normal range."
		} else  if !theArray.isEmpty {
			let preString = stringOfThreeFromArray(theArray)
			result = "\(theHeader)\n\(preString)"
			//result = "\(theHeader.uppercaseString)\n\(theArray.joinWithSeparator(tab))"
			return result
		}
	} else {
		//If the checkForNorms flag is false, develop the string to report all results
		for lab in theLabs {
			if !lab.controller.stringValue.isEmpty {
				let theString = "\(lab.outputTitle) \(lab.controller.stringValue)"
				theArray.append(theString)
			}
		}
	}
	if !theArray.isEmpty {
		let preString = stringOfThreeFromArray(theArray)
		result = "\(theHeader)\n\(preString)"
		//result = "\(theHeader.uppercaseString)\n\(theArray.joinWithSeparator(tab))"
	}
	return result
}

func generateSectionResultsString() {
	//Section Headers
	let bloodCountHeading = "Blood count"
	let cmpHeading = "Complete metabolic panel"
	let liverHeading = "Liver panel"

	let thyroidHeading = "Thyroid function"
	let otherHeading = "Other"
	
	if let bloodCount = MyVariables.completeLabData?.returnBloodCount() {
		let theBloodCountResults = generateIndividualResultString(bloodCountHeading, theLabs: bloodCount, checkForNorms: true)
		MyVariables.theLabLetter?.bloodCountResults = theBloodCountResults
		}
	if let liverFunction = MyVariables.completeLabData?.returnLiverFunction() {
		MyVariables.theLabLetter?.liverResults = generateIndividualResultString(liverHeading, theLabs: liverFunction, checkForNorms: true)
	}
	if let cmp = MyVariables.completeLabData?.returnCMP() {
		MyVariables.theLabLetter?.cmpResults = generateIndividualResultString(cmpHeading, theLabs: cmp, checkForNorms: false)
	}
	if let thyroid = MyVariables.completeLabData?.returnThyroid() {
		MyVariables.theLabLetter?.thyroidResults = generateIndividualResultString(thyroidHeading, theLabs: thyroid, checkForNorms: false)
	}
	if let other = MyVariables.completeLabData?.returnOther() {
		var otherArray = [String]()
		var unlabeledLabResults = String()
		if let otherUnlabeledLabs = MyVariables.completeLabData?.unlabeledLabs {
			for lab in otherUnlabeledLabs {
				if !lab.stringValue.isEmpty {
					otherArray.append(lab.stringValue)
				}
			}
			if !otherArray.isEmpty {
				unlabeledLabResults = otherArray.joined(separator: tab)
			}
		}
		
		let regularOtherResults = generateIndividualResultString(otherHeading, theLabs: other, checkForNorms: false)
		
		if !regularOtherResults.isEmpty {
			if !unlabeledLabResults.isEmpty {
				MyVariables.theLabLetter?.otherResults = regularOtherResults + tab + unlabeledLabResults
			} else if unlabeledLabResults.isEmpty {
				MyVariables.theLabLetter?.otherResults = regularOtherResults
			}
		} else if regularOtherResults.isEmpty {
			if !unlabeledLabResults.isEmpty {
				MyVariables.theLabLetter?.otherResults = otherHeading.uppercased() + "\n" + unlabeledLabResults
			}
		}
		
		//MyVariables.theLabLetter?.otherResults
	}

}

func generateDiabetesSectionResults() {
	let diabetesHeading = "Blood sugar average/Microalbumin"
	var hA1cString = String()
	var aveGlucoseString = String()
	var microAlbString = String()
	var returnOrNot = String()
	
	if let hemoA1c = MyVariables.completeLabData?.hba1cLab {
		if !hemoA1c.controller.stringValue.isEmpty {
			hA1cString = "Hemoglobin A1c: \(hemoA1c.controller.stringValue). The goal is less than 7 and normal is less than 6. "
		}
	}
	
	if let aveGlucose = MyVariables.completeLabData?.aveGlucoseLab {
		if !aveGlucose.controller.stringValue.isEmpty {
			aveGlucoseString = "This number equals a 3 month average blood sugar of \(aveGlucose.controller.stringValue) (the goal is less than 150)."
		}
	}
	
	if let microAlb = MyVariables.completeLabData?.microalbuminLab {
		if !microAlb.controller.stringValue.isEmpty {
			microAlbString = "Urine Microalbumin: \(microAlb.controller.stringValue)"
		}
	}
	
	if ((!hA1cString.isEmpty) || (!aveGlucoseString.isEmpty)) && (!microAlbString.isEmpty) {
		returnOrNot = "\n"
	}
	
	
	let diabetesString = "\(hA1cString)\(aveGlucoseString)\(returnOrNot)\(microAlbString)"
	
	if !diabetesString.isEmpty {
		MyVariables.theLabLetter?.bloodSugarMicroResults = "\(diabetesHeading.uppercased())\n\(diabetesString)"
	} else {
		MyVariables.theLabLetter?.bloodSugarMicroResults = ""
	}
}

func generateCholesterolSectionResults() {
	var totalString = String()
	var triglyceridesString = String()
	var hdlString = String()
	var ldlString = String()
	var ldlConcentrationString = String()
	var smallLDLString = String()
	var smallConcetrationString = String()
	var cholesterolArray = [String]()
	
	if let total = MyVariables.completeLabData?.totalCholesterolLab {
		if !total.controller.stringValue.isEmpty {
			totalString = "Total Cholesterol: \(total.controller.stringValue).\nNormal is less than 200. Keep dietary cholesterol under 300mg per day and keep total fat in your diet to less than 30 percent of total daily calorie intake."
			cholesterolArray.append(totalString)
		}
	}
	
	if let triglycerides = MyVariables.completeLabData?.triglyceridesLab {
		if !triglycerides.controller.stringValue.isEmpty {
			triglyceridesString = "Triglycerides (fat): \(triglycerides.controller.stringValue).\nNormal is less than 150. Decrease the amount of fat in your diet to positively affect this number."
			cholesterolArray.append(triglyceridesString)
		}
	}
	
	if let hdl = MyVariables.completeLabData?.hdlLab {
		if !hdl.controller.stringValue.isEmpty {
			hdlString = "HDL Cholesterol: \(hdl.controller.stringValue).\nNormal is above 40 and the goal is above 50. This is the \"good\" cholesterol and protects against heart attacks.  Exercise will improve this number."
			cholesterolArray.append(hdlString)
		}
	}
	
	if let ldl = MyVariables.completeLabData?.ldlLab {
		if !ldl.controller.stringValue.isEmpty {
			ldlString = "LDL Cholesterol: \(ldl.controller.stringValue).\nFair is less than 130, good is less than 100, and excellent is less than 70.  This is the \"bad\" cholesterol. Lifestyle changes such as diet and exercise can decrease this number."
			cholesterolArray.append(ldlString)
		}
	}
	
	if let ldlConcentration = MyVariables.completeLabData?.ldlConcentrationLab {
		if !ldlConcentration.controller.stringValue.isEmpty {
			ldlConcentrationString = "LDL Particle Concentration: \(ldlConcentration.controller.stringValue)"
		}
	}
	
	if let smallLDL = MyVariables.completeLabData?.smallLDLLab {
		if !smallLDL.controller.stringValue.isEmpty {
			smallLDLString = "Small Dense LDL: \(smallLDL.controller.stringValue)"
		}
	}
	
	if (!ldlConcentrationString.isEmpty) || (!smallLDLString.isEmpty) {
		smallConcetrationString = ldlConcentrationString + tab + smallLDLString
		cholesterolArray.append(smallConcetrationString)
	}
	
	if !cholesterolArray.isEmpty {
		let cholesterolResults = "CHOLESTEROL\n" + cholesterolArray.joined(separator: "\n")
		MyVariables.theLabLetter?.cholesterolResults = cholesterolResults
	}

}


func stringOfThreeFromArray(_ startingArray: [String]) -> String {
	var arrayOfArrays: [String] = [String]()
	var initialArray = startingArray
	
	while initialArray.count > 0 {
		if initialArray.count >= 3 {
			var tempArray = [String]()
			for _ in 1...3 {
				tempArray.append(initialArray.remove(at: 0))
			}
			let tempString = tempArray.joined(separator: "    ")
			arrayOfArrays.append(tempString)
		} else {
			var tempArray = [String]()
			for _ in 1...initialArray.count {
				tempArray.append(initialArray.remove(at: 0))
			}
			let tempString = tempArray.joined(separator: "    ")
			arrayOfArrays.append(tempString)
		}
	}
	
	let stringResult = arrayOfArrays.joined(separator: "\n")
	
	return stringResult
}
