//
//  LabLetterClass.swift
//  Lab Letter 2
//
//  Created by Fool on 3/2/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class LabLetter {
	var letterDateField:NSTextField
	var letterDate = String()
	var patientName = String()
	var labDate = String()
	var bloodCountResults = String()
	var cholesterolResults = String()
	var bloodSugarMicroResults = String()
	var cmpResults = String()
	var liverResults = String()
	var thyroidResults = String()
	var otherResults = String()
	
	init(letterDateField:NSTextField) {
		self.letterDateField = letterDateField
	}
	func resetVariables() {
		letterDate = String()
		patientName = String()
		labDate = String()
		bloodCountResults = String()
		cholesterolResults = String()
		bloodSugarMicroResults = String()
		cmpResults = String()
		liverResults = String()
		thyroidResults = String()
		otherResults = String()
	}
	
	func buildLetter() {
		if let thisPatient = MyVariables.thePatient {
			labDate = thisPatient.dateField.stringValue
			patientName = thisPatient.nameField.stringValue
		}
		
		let letterOpening = "\(letterDateField.stringValue)\n\nDear \(patientName),\nTheses are the results of your lab from \(labDate):\n\n"
		let letterClosing = "\n\nPlease call my office to make an appointment if you have any questions about these results.\nSincerely,\n\nDawn R. Whelchel, M.D."
		let bodySections = [bloodCountResults, cholesterolResults, bloodSugarMicroResults, cmpResults, liverResults, thyroidResults, otherResults]
		var usedSections = [String]()
		for section in bodySections {
			if !section.isEmpty {
				usedSections.append(section)
			}
		}
		let letterBody = usedSections.joinWithSeparator("\n\n")
		
		let finalLetter = letterOpening + letterBody + letterClosing
		
		print(finalLetter)
		
		let pasteBoard = NSPasteboard.generalPasteboard()
		pasteBoard.clearContents()
		pasteBoard.setString(finalLetter, forType: NSPasteboardTypeString)
		
	}
}

class AllTheLabs {
	var wbcLab:LabDataWithHighLow
	var hgbLab:LabDataWithHighLow
	var hctLab:LabDataWithHighLow
	var plateletsLab:LabDataWithHighLow
	var glucoseLab:LabDataGlucose
	var creatinineLab:LabDataWithHighLow
	var eGFRAALab:LabDataWithHighLow
	var eGFRNonAALab:LabDataWithHighLow
	var potassiumLab:LabDataWithHighLow
	var calciumLab:LabDataWithHighLow
	var proteinLab:LabDataWithHighLow
	var albuminLab:LabDataWithHighLow
	var calculatedGlobLab:LabDataWithHighLow
	var agRatioLab:LabDataWithHighLow
	var bilirubinLab:LabDataWithHighLow
	var alkPhosphataseLab:LabDataWithHighLow
	var astLab:LabDataWithHighLow
	var altLab:LabDataWithHighLow
	var microalbuminLab:LabDataWithHighLow
	var ldlConcentrationLab:LabDataWithHighLow
	var smallLDLLab:LabDataWithHighLow
	var freeT3Lab:LabDataWithHighLow
	var freeT4Lab:LabDataWithHighLow
	var totalCholesterolLab:LabData
	var triglyceridesLab:LabData
	var hdlLab:LabData
	var ldlLab:LabData
	var hba1cLab:LabData
	var aveGlucoseLab:LabData
	var ckLab:LabDataWithHighLow
	var sedRateLab:LabDataWithHighLow
	var cReactiveProteinLab:LabDataWithHighLow
	var cortisolLab:LabDataWithHighLow
	var vitaminB12Lab:LabDataWithHighLow
	var vitaminDLab:LabDataWithHighLow
	var ironLab:LabDataWithHighLow
	var tshLab:LabDataTSH
	var psaLab:LabDataWithHighLow
	var uricAcidLab:LabDataWithHighLow
	//var inrLab:LabData
	var folicAcidLab:LabDataWithHighLow
	var ferritinLab:LabDataWithHighLow
	var magnesiumLab:LabDataWithHighLow
	var ldhLab:LabDataWithHighLow
	var lipaseLab:LabDataWithHighLow
	var amylaseLab:LabDataWithHighLow
	//var hPyloriLab
	var rheumatoidFactorLab:LabDataWithHighLow
	//var antiNuclearLab
	var reticulocyteLab:LabDataWithHighLow
	var unlabeledLabs:[NSTextField]

	
	init(wbcLab:LabDataWithHighLow, hgbLab:LabDataWithHighLow, hctLab:LabDataWithHighLow, plateletsLab:LabDataWithHighLow, glucoseLab:LabDataGlucose, creatinineLab:LabDataWithHighLow, potassiumLab:LabDataWithHighLow, eGFRAALab:LabDataWithHighLow, eGFRNonAALab:LabDataWithHighLow, calciumLab:LabDataWithHighLow, proteinLab:LabDataWithHighLow, albuminLab:LabDataWithHighLow, calculatedGlobLab:LabDataWithHighLow, agRatioLab:LabDataWithHighLow, bilirubinLab:LabDataWithHighLow, alkPhosphataseLab:LabDataWithHighLow, astLab:LabDataWithHighLow, altLab:LabDataWithHighLow, microalbuminLab:LabDataWithHighLow, ldlConcentrationLab:LabDataWithHighLow, smallLDLLab:LabDataWithHighLow, freeT3Lab:LabDataWithHighLow, freeT4Lab:LabDataWithHighLow, totalCholesterolLab:LabData, triglyceridesLab:LabData, hdlLab:LabData, ldlLab:LabData, hba1cLab:LabData, aveGlucoseLab:LabData, ckLab:LabDataWithHighLow, sedRateLab:LabDataWithHighLow, cReactiveProteinLab:LabDataWithHighLow, cortisolLab:LabDataWithHighLow, vitaminB12Lab:LabDataWithHighLow, vitaminDLab:LabDataWithHighLow, ironLab:LabDataWithHighLow, tshLab:LabDataTSH, psaLab:LabDataWithHighLow, uricAcidLab:LabDataWithHighLow, folicAcidLab:LabDataWithHighLow, ferritinLab:LabDataWithHighLow, magnesiumLab:LabDataWithHighLow, ldhLab:LabDataWithHighLow, lipaseLab:LabDataWithHighLow, amylaseLab:LabDataWithHighLow, rheumatoidFactorLab:LabDataWithHighLow, reticulocyteLab:LabDataWithHighLow, unlabeledLabs:[NSTextField]) {
		self.wbcLab = wbcLab
		self.hgbLab = hgbLab
		self.hctLab = hctLab
		self.plateletsLab = plateletsLab
		self.glucoseLab = glucoseLab
		self.creatinineLab = creatinineLab
		self.eGFRAALab = eGFRAALab
		self.eGFRNonAALab = eGFRNonAALab
		self.potassiumLab = potassiumLab
		self.calciumLab = calciumLab
		self.proteinLab = proteinLab
		self.albuminLab = albuminLab
		self.calculatedGlobLab = calculatedGlobLab
		self.agRatioLab = agRatioLab
		self.bilirubinLab = bilirubinLab
		self.alkPhosphataseLab = alkPhosphataseLab
		self.astLab = astLab
		self.altLab = altLab
		self.microalbuminLab = microalbuminLab
		self.ldlConcentrationLab = ldlConcentrationLab
		self.smallLDLLab = smallLDLLab
		self.freeT3Lab = freeT3Lab
		self.freeT4Lab = freeT4Lab
		self.totalCholesterolLab = totalCholesterolLab
		self.triglyceridesLab = triglyceridesLab
		self.hdlLab = hdlLab
		self.ldlLab = ldlLab
		self.hba1cLab = hba1cLab
		self.aveGlucoseLab = aveGlucoseLab
		self.ckLab = ckLab
		self.sedRateLab = sedRateLab
		self.cReactiveProteinLab = cReactiveProteinLab
		self.cortisolLab = cortisolLab
		self.vitaminB12Lab = vitaminB12Lab
		self.vitaminDLab = vitaminDLab
		self.ironLab = ironLab
		self.tshLab = tshLab
		self.psaLab = psaLab
		self.uricAcidLab = uricAcidLab
		self.folicAcidLab = folicAcidLab
		self.ferritinLab = ferritinLab
		self.magnesiumLab = magnesiumLab
		self.ldhLab = ldhLab
		self.lipaseLab = lipaseLab
		self.amylaseLab = amylaseLab
		self.rheumatoidFactorLab = rheumatoidFactorLab
		self.reticulocyteLab = reticulocyteLab
		self.unlabeledLabs = unlabeledLabs
	}
	
	func returnAllTheLabsButHGB() -> [LabData] {
			return [wbcLab, hctLab, plateletsLab, glucoseLab, creatinineLab, eGFRAALab, eGFRNonAALab, potassiumLab, calciumLab, proteinLab, albuminLab, calculatedGlobLab, agRatioLab, bilirubinLab, alkPhosphataseLab, astLab, altLab, microalbuminLab, ldlConcentrationLab, smallLDLLab, freeT3Lab, freeT4Lab, totalCholesterolLab, triglyceridesLab, hdlLab, ldlLab, hba1cLab, aveGlucoseLab, ckLab, sedRateLab, cReactiveProteinLab, cortisolLab, vitaminB12Lab, vitaminDLab, ironLab, tshLab, psaLab, uricAcidLab, folicAcidLab, ferritinLab, magnesiumLab, ldhLab, lipaseLab, amylaseLab, rheumatoidFactorLab, reticulocyteLab]
	}
	
	func returnBloodCount() -> [LabDataWithHighLow] {
		return [wbcLab, hgbLab, hctLab, plateletsLab]
	}
	
	func returnCMP() -> [LabDataWithHighLow] {
		return [glucoseLab, creatinineLab, potassiumLab, eGFRAALab, eGFRNonAALab, calciumLab]
	}
	
	func returnLiverFunction() -> [LabDataWithHighLow] {
		return [proteinLab, albuminLab, calculatedGlobLab, agRatioLab, bilirubinLab, alkPhosphataseLab, astLab, altLab]
	}
	
	func returnDiabtes() -> [LabData] {
		return [hba1cLab, aveGlucoseLab]
	}
	
	func returnCholesterolSimple() -> [LabData] {
		return [totalCholesterolLab, triglyceridesLab, hdlLab, ldlLab]
	}
	
	func returnCholesterolComplex() -> [LabDataWithHighLow] {
		return [ldlConcentrationLab, smallLDLLab]
	}
	
	func returnThyroid() -> [LabDataWithHighLow] {
		return [tshLab, freeT3Lab, freeT4Lab]
	}
	
	func returnOther() -> [LabDataWithHighLow] {
		return [ckLab, sedRateLab, cReactiveProteinLab, cortisolLab, vitaminB12Lab, vitaminDLab, ironLab, psaLab, uricAcidLab, folicAcidLab, ferritinLab, magnesiumLab, ldhLab, lipaseLab, amylaseLab, rheumatoidFactorLab, reticulocyteLab]
	}
	
	func clearUnlabeledLabs() {
		for lab in unlabeledLabs {
			lab.stringValue = ""
		}
	}
	
	func resetAllTheLabs() {
		let mostLabs = returnAllTheLabsButHGB()
		for lab in mostLabs {
		lab.controller.stringValue = String()
		}
		hgbLab.controller.stringValue = String()
		
//		wbcLab.controller.stringValue = String()
//		hctLab.controller.stringValue = String()
//		plateletsLab.controller.stringValue = String()
//		glucoseLab.controller.stringValue = String()
//		creatinineLab.controller.stringValue = String()
//		eGFRAALab.controller.stringValue = String()
//		eGFRNonAALab.controller.stringValue = String()
//		potassiumLab.controller.stringValue = String()
//		calciumLab.controller.stringValue = String()
//		proteinLab.controller.stringValue = String()
//		albuminLab.controller.stringValue = String()
//		calculatedGlobLab.controller.stringValue = String()
//		agRatioLab.controller.stringValue = String()
//		bilirubinLab.controller.stringValue = String()
//		alkPhosphataseLab.controller.stringValue = String()
//		astLab.controller.stringValue = String()
//		altLab.controller.stringValue = String()
//		microalbuminLab.controller.stringValue = String()
//		ldlConcentrationLab.controller.stringValue = String()
//		smallLDLLab.controller.stringValue = String()
//		freeT3Lab.controller.stringValue = String()
//		freeT4Lab.controller.stringValue = String()
//		totalCholesterolLab.controller.stringValue = String()
//		triglyceridesLab.controller.stringValue = String()
//		hdlLab.controller.stringValue = String()
//		ldlLab.controller.stringValue = String()
//		hba1cLab.controller.stringValue = String()
//		aveGlucoseLab.controller.stringValue = String()
//		ckLab.controller.stringValue = String()
//		sedRateLab.controller.stringValue = String()
//		cReactiveProteinLab.controller.stringValue = String()
//		cortisolLab.controller.stringValue = String()
//		vitaminB12Lab.controller.stringValue = String()
//		vitaminDLab.controller.stringValue = String()
//		ironLab.controller.stringValue = String()
//		tshLab.controller.stringValue = String()
//		psaLab.controller.stringValue = String()
//		uricAcidLab.controller.stringValue = String()
		
		clearUnlabeledLabs()
	}

}