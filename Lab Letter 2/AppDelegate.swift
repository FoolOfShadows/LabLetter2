//
//  AppDelegate.swift
//  Lab Letter 2
//
//  Created by Fool on 1/16/15.
//  Copyright (c) 2015 Fulgent Wake. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
	@IBOutlet weak var winPrint: NSWindow!

    @IBOutlet weak var letterDateView: NSTextField!
    @IBOutlet weak var patientNameView: NSTextField!
    @IBOutlet weak var labDateView: NSTextField!
    @IBOutlet weak var wbcView: NSTextField!
    @IBOutlet weak var hgbView: NSTextField!
    @IBOutlet weak var hctView: NSTextField!
    @IBOutlet weak var plateletsView: NSTextField!
    @IBOutlet weak var glucoseView: NSTextField!
    @IBOutlet weak var creatinineView: NSTextField!
    @IBOutlet weak var eGFRAAView: NSTextField!
    @IBOutlet weak var eGFRNonAAView: NSTextField!
    @IBOutlet weak var potassiumView: NSTextField!
	@IBOutlet weak var calciumView: NSTextField!
    @IBOutlet weak var proteinView: NSTextField!
    @IBOutlet weak var albuminView: NSTextField!
    @IBOutlet weak var calculatedGlobView: NSTextField!
    @IBOutlet weak var agRatioView: NSTextField!
    @IBOutlet weak var bilirubinView: NSTextField!
    @IBOutlet weak var alkPhosphataseView: NSTextField!
    @IBOutlet weak var astView: NSTextField!
    @IBOutlet weak var altView: NSTextField!
    @IBOutlet weak var hemoglobinA1cView: NSTextField!
    @IBOutlet weak var averageGlucoseView: NSTextField!
    @IBOutlet weak var microalbuminView: NSTextField!
    @IBOutlet weak var totalCholesterolView: NSTextField!
    @IBOutlet weak var triglyceridesView: NSTextField!
    @IBOutlet weak var hdlsView: NSTextField!
    @IBOutlet weak var ldlsView: NSTextField!
    @IBOutlet weak var ldlConcentrationView: NSTextField!
    @IBOutlet weak var smallLDLView: NSTextField!
    @IBOutlet weak var tshView: NSTextField!
    @IBOutlet weak var freeT3View: NSTextField!
    @IBOutlet weak var freeT4View: NSTextField!
    @IBOutlet weak var ckTotalView: NSTextField!
    @IBOutlet weak var sedRateView: NSTextField!
    @IBOutlet weak var cReactiveProteinView: NSTextField!
    @IBOutlet weak var cortisolView: NSTextField!
    @IBOutlet weak var psaView: NSTextField!
    @IBOutlet weak var vitaminB12View: NSTextField!
    @IBOutlet weak var vitaminDView: NSTextField!
    @IBOutlet weak var ironView: NSTextField!
	@IBOutlet weak var uricAcidView: NSTextField!
	@IBOutlet weak var inrView: NSTextField!
	@IBOutlet weak var folicAcidView: NSTextField!
	@IBOutlet weak var ferritinView: NSTextField!
	@IBOutlet weak var magnesiumView: NSTextField!
	@IBOutlet weak var ldhView: NSTextField!
	@IBOutlet weak var lipaseView: NSTextField!
	@IBOutlet weak var amylaseView: NSTextField!
	@IBOutlet weak var hPyloriView: NSTextField!
	@IBOutlet weak var rheumatoidFactorView: NSTextField!
	@IBOutlet weak var antiNuclearView: NSTextField!
	@IBOutlet weak var reticulocyteView: NSTextField!
	@IBOutlet weak var testosteroneView: NSTextField!
	
	
    @IBOutlet weak var other1View: NSTextField!
    @IBOutlet weak var other2View: NSTextField!
    @IBOutlet weak var other3View: NSTextField!
    @IBOutlet weak var other4View: NSTextField!
    @IBOutlet weak var other5View: NSTextField!
    @IBOutlet weak var other6View: NSTextField!
	
	@IBOutlet var printView: NSTextView!
	
	var letterString = ""
	
    @IBAction func takeClear(sender: AnyObject) {
     resetFormFields()
    }
	
    @IBAction func takeProcess(sender: AnyObject) {
		generateSectionResultsString()
		generateDiabetesSectionResults()
		generateCholesterolSectionResults()
		
		if let theLabLetter = MyVariables.theLabLetter {
			theLabLetter.buildLetter()
		}
    }
    
	@IBAction func takePopulate(sender: AnyObject) {
		//Extract the raw data from the PracticeFusion text in the clipboard and set the fields of the form accordingly
		if let theCompleteLabData = MyVariables.completeLabData {
			if let thisPatient = MyVariables.thePatient {
				extractValues(theCompleteLabData.returnAllTheLabsButHGB(), thePatient: thisPatient, wordsToRemove: extraPhrases)
			}
		}
		if let theHGBLabData = MyVariables.completeLabData?.hgbLab {
			if let thisPatient = MyVariables.thePatient {
				extractValues([theHGBLabData], thePatient: thisPatient, wordsToRemove: moreExtraPhrases)
			}
		}
	}
	
	@IBAction func takePrint(sender: AnyObject) {
	}
    

    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
		resetFormFields()
		
		MyVariables.thePatient = PatientData(nameField: patientNameView, dateField: labDateView)
		
		//Blood Count
		let wbcLab = LabDataWithHighLow(controller: wbcView, idText: "WBC", highFemale: wbcHighF, lowFemale: wbcLowF, highMale: wbcHighM, lowMale: wbcLowM, outputTitle: "White Blood Count:")
		let hctLab = LabDataWithHighLow(controller: hctView, idText: "HEMATOCRIT", highFemale: hctHighF, lowFemale: hctLowF, highMale: hctHighM, lowMale: hctLowM, outputTitle: "Hematocrit:")
		let hgbLab = LabDataWithHighLow(controller: hgbView, idText: "HEMOGLOBIN", highFemale: hgbHighF, lowFemale: hgbLowF, highMale: hgbHighM, lowMale: hgbLowM, outputTitle: "Hemoglobin:")
		let plateletsLab = LabDataWithHighLow(controller: plateletsView, idText: "PLATELET COUNT", highFemale: plateletsHighF, lowFemale: plateletsLowF, highMale: plateletsHighM, lowMale: plateletsLowM, outputTitle: "Platelets:")
		
		//CMP
		let glucoseLab = LabDataGlucose(controller: glucoseView, idText: "GLUCOSE", highFemale: glucoseHighF, lowFemale: glucoseLowF, highMale: glucoseHighM, lowMale: glucoseLowM, borderlineFemale: glucoseBorderlineF, borderlineMale: glucoseBorderlineM, outputTitle: "Glucose:")
		let creatinineLab = LabDataWithHighLow(controller: creatinineView, idText: "CREATININE", highFemale: creatinineHighF, lowFemale: creatinineLowF, highMale: creatinineHighM, lowMale: creatinineLowM, outputTitle: "Creatinine:")
		let eGFRAALab = LabDataWithHighLow(controller: eGFRAAView, idText: "eGFR AFRICAN AMER.", highFemale: eGFRAAHighF, lowFemale: eGFRAALowF, highMale: eGFRAAHighM, lowMale: eGFRAALowM, outputTitle: "eGFR African American:")
		let eGFRNonAALab = LabDataWithHighLow(controller: eGFRNonAAView, idText: "eGFR NON-AFRICAN AMER.", highFemale: eGFRNonAAHighF, lowFemale: eGFRNonAALowF, highMale: eGFRNonAAHighM, lowMale: eGFRNonAALowM, outputTitle: "eGFR Non-African American:")
		let potassiumLab = LabDataWithHighLow(controller: potassiumView, idText: "POTASSIUM", highFemale: potassiumHighF, lowFemale: potassiumLowF, highMale: potassiumHighM, lowMale: potassiumLowM, outputTitle: "Potassium:")
		let calciumLab = LabDataWithHighLow(controller: calciumView, idText: "CALCIUM", highFemale: calciumHighF, lowFemale: calciumLowF, highMale: calciumHighM, lowMale: calciumLowM, outputTitle: "\nCalcium:")
		
		//Liver Function
		let proteinLab = LabDataWithHighLow(controller: proteinView, idText: "PROTEIN, TOTAL", highFemale: proteinHighF, lowFemale: proteinLowF, highMale: proteinHighM, lowMale: proteinLowM, outputTitle: "Protein:")
		let albuminLab = LabDataWithHighLow(controller: albuminView, idText: "ALBUMIN", highFemale: albuminHighF, lowFemale: albuminLowF, highMale: albuminHighM, lowMale: albuminLowM, outputTitle: "Albumin:")
		let calculatedGlobLab = LabDataWithHighLow(controller: calculatedGlobView, idText: "CALCULATED GLOBULIN", highFemale: globHighF, lowFemale: globLowF, highMale: globHighM, lowMale: globLowM, outputTitle: "Globulin:")
		let agRatioLab = LabDataWithHighLow(controller: agRatioView, idText: "CALCULATED A/G RATIO", highFemale: agRatioHighF, lowFemale: agRatioLowF, highMale: agRatioHighM, lowMale: agRatioLowM, outputTitle: "A/G Ratio:")
		let bilirubinLab = LabDataWithHighLow(controller: bilirubinView, idText: "BILIRUBIN, TOTAL", highFemale: biliHighF, lowFemale: biliLowF, highMale: biliHighM, lowMale: biliLowM, outputTitle: "Bilirubin:")
		let alkPhosphataseLab = LabDataWithHighLow(controller: alkPhosphataseView, idText: "ALKALINE PHOSPHATASE", highFemale: alkPhosHighF, lowFemale: alkPhosLowF, highMale: alkPhosHighM, lowMale: alkPhosLowM, outputTitle: "Alk Phosphatase:")
		let astLab = LabDataWithHighLow(controller: astView, idText: "SGOT (AST)", highFemale: astHighF, lowFemale: astLowF, highMale: astHighM, lowMale: astLowM, outputTitle: "SGOT (AST):")
		let altLab = LabDataWithHighLow(controller: altView, idText: "SGPT (ALT)", highFemale: altHighF, lowFemale: altLowF, highMale: altHighM, lowMale: altLowM, outputTitle: "SGPT (ALT):")
		
		//Diabetes Labs - Simple
		let hba1cLab = LabData(controller: hemoglobinA1cView, idText: "HEMOGLOBIN A1c")
		let aveGlucoseLab = LabData(controller: averageGlucoseView, idText: "ESTIMATED AVERAGE GLUCOSE")
		// - Complex
		let microalbuminLab = LabDataWithHighLow(controller: microalbuminView, idText: "CALC MICROALB/CREAT RND", highFemale: microAlbHighF, lowFemale: microAlbLowF, highMale: microAlbHighM, lowMale: microAlbLowM, outputTitle: "Urine Microalbumin:")
		
		//Cholesterol - Simple
		let totalCholesterolLab = LabData(controller: totalCholesterolView, idText: "CHOLESTEROL")
		let triglyceridesLab = LabData(controller: triglyceridesView, idText: "TRIGLYCERIDES")
		let hdlLab = LabData(controller: hdlsView, idText: "HDL CHOLESTEROL")
		let ldlLab = LabData(controller: ldlsView, idText: "CALCULATED LDL CHOL")
		// - Complex
		let ldlConcentrationLab = LabDataWithHighLow(controller: ldlConcentrationView, idText: "LDL PARTICLE (P) CONC", highFemale: ldlConcHighF, lowFemale: ldlConcLowF, highMale: ldlConcHighM, lowMale: ldlConcLowM, outputTitle: "LDL Particle Concentration:")
		let smallLDLLab = LabDataWithHighLow(controller: smallLDLView, idText: "SMALL LDL-P", highFemale: smallLDLHighF, lowFemale: smallLDLLowF, highMale: smallLDLHighM, lowMale: smallLDLLowM, outputTitle: "Small Dense LDL:")
		
		//Thyroid
		let tshLab = LabDataTSH(controller: tshView, idText: "TSH", highFemale: tshHighF, lowFemale: tshLowF, highMale: tshHighM, lowMale: tshLowM, outputTitle: "TSH:")
		let freeT3Lab = LabDataWithHighLow(controller: freeT3View, idText: "FREE T3", highFemale: freeT3HighF, lowFemale: freeT3LowF, highMale: freeT3HighM, lowMale: freeT3LowM, outputTitle: "Free T3:")
		let freeT4Lab = LabDataWithHighLow(controller: freeT4View, idText: "FREE T4 (THYROXINE)", highFemale: freeT4HighF, lowFemale: freeT4LowF, highMale: freeT4HighM, lowMale: freeT4LowM, outputTitle: "Free T4:")
		
		//Other
		let ckLab = LabDataWithHighLow(controller: ckTotalView, idText: "CK, TOTAL", highFemale: ckHighF, lowFemale: ckLowF, highMale: ckHighM, lowMale: ckLowM, outputTitle: "Creatinine Kinase:")
		let sedRateLab = LabDataWithHighLow(controller: sedRateView, idText: "SEDIMENTATION RATE", highFemale: sedHighF, lowFemale: sedLowF, highMale: sedHighM, lowMale: sedLowM, outputTitle: "Sedimentation Rate:")
		let cReactiveProteinLab = LabDataWithHighLow(controller: cReactiveProteinView, idText: "C-REACTIVE PROTEIN", highFemale: cReactiveHighF, lowFemale: cReactiveLowF, highMale: cReactiveHighM, lowMale: cReactiveLowM, outputTitle: "C-Reactive Protein:")
		let cortisolLab = LabDataWithHighLow(controller: cortisolView, idText: "CORTISOL, RANDOM", highFemale: cortisolHighF, lowFemale: cortisolLowF, highMale: cortisolHighM, lowMale: cortisolLowM, outputTitle: "Cortisol:")
		let vitaminB12Lab = LabDataWithHighLow(controller: vitaminB12View, idText: "VITAMIN B-12", highFemale: b12HighF, lowFemale: b12LowF, highMale: b12HighM, lowMale: b12LowM, outputTitle: "Vitamin B12:")
		let vitaminDLab = LabDataWithHighLow(controller: vitaminDView, idText: "VITAMIN D, 25 OH", highFemale: dHighF, lowFemale: dLowF, highMale: dHighM, lowMale: dLowM, outputTitle: "Vitamin D:")
		let ironLab = LabDataWithHighLow(controller: ironView, idText: "IRON, SERUM", highFemale: ironHighF, lowFemale: ironLowF, highMale: ironHighM, lowMale: ironLowM, outputTitle: "Iron:")
		let psaLab = LabDataWithHighLow(controller: psaView, idText: "PSA, TOTAL", highFemale: psaHighF, lowFemale: psaLowF, highMale: psaHighM, lowMale: psaLowM, outputTitle: "PSA:")
		let uricAcidLab = LabDataWithHighLow(controller: uricAcidView, idText: "URIC ACID", highFemale: uricAcidHighF, lowFemale: uricAcidLowF, highMale: uricAcidHighM, lowMale: uricAcidLowM, outputTitle: "Uric Acid:")
		let folicAcidLab = LabDataWithHighLow(controller: folicAcidView, idText: "FOLIC ACID", highFemale: folicAcidHighF, lowFemale: folicAcidLowF, highMale: folicAcidHighM, lowMale: folicAcidLowM, outputTitle: "Folic Acid:")
		let ferritinLab = LabDataWithHighLow(controller: ferritinView, idText: "FERRITIN", highFemale: ferritinHighF, lowFemale: ferritinLowF, highMale: ferritinHighM, lowMale: ferritinLowM, outputTitle: "Ferritin:")
		let magnesiumLab = LabDataWithHighLow(controller: magnesiumView, idText: "MAGNESIUM", highFemale: magnesiumHighF, lowFemale: magnesiumLowF, highMale: magnesiumHighM, lowMale: magnesiumLowM, outputTitle: "Magnesium:")
		let ldhLab = LabDataWithHighLow(controller: ldhView, idText: "LDH", highFemale: ldhHighF, lowFemale: ldhLowF, highMale: ldhHighM, lowMale: ldhLowM, outputTitle: "LDH:")
		let lipaseLab = LabDataWithHighLow(controller: lipaseView, idText: "LIPASE", highFemale: lipaseHighF, lowFemale: lipaseLowF, highMale: lipaseHighM, lowMale: lipaseLowM, outputTitle: "Lipase:")
		let amylaseLab = LabDataWithHighLow(controller: amylaseView, idText: "AMYLASE", highFemale: amylaseHighF, lowFemale: amylaseLowF, highMale: amylaseHighM, lowMale: amylaseLowM, outputTitle: "Amylase:")
		let rheumatoidFactorLab = LabDataWithHighLow(controller: rheumatoidFactorView, idText: "RHEUMATOID FACTOR, QUANT", highFemale: rheumatoidFactorHighF, lowFemale: rheumatoidFactorLowF, highMale: rheumatoidFactorHighM, lowMale: rheumatoidFactorLowM, outputTitle: "Rheumatoid Factor:")
		let reticulocyteLab = LabDataWithHighLow(controller: reticulocyteView, idText: "RETICULOCYTE", highFemale: reticulocyteHighF, lowFemale: reticulocyteLowF, highMale: reticulocyteHighM, lowMale: reticulocyteLowM, outputTitle: "Reticulocyte Count")
		let antiNuclearLab = LabDataPosNeg(controller: antiNuclearView, idText: "Anti-Nuclear Antibodies", outputTitle: "Anti-Nuclear Antibodies:")
		let hPyloriLab = LabDataPosNeg(controller: hPyloriView, idText: "H. PYLORI IgG", outputTitle: "H.Pylori:")
		let inrLab = LabDataPosNeg(controller: inrView, idText: "INR", outputTitle: "INR:")
		let testosteroneLab = LabDataWithHighLow(controller: testosteroneView, idText: "testosterone", highFemale: testosteroneHighF, lowFemale: testosteroneLowF, highMale: testosteroneHighM, lowMale: testosteroneLowM, outputTitle: "Testosterone:")
		
		
		//Populate the completeLabData variable with all the lab objects
		MyVariables.completeLabData = AllTheLabs(wbcLab: wbcLab, hgbLab: hgbLab, hctLab: hctLab, plateletsLab: plateletsLab, glucoseLab: glucoseLab, creatinineLab: creatinineLab, potassiumLab: potassiumLab, eGFRAALab: eGFRAALab, eGFRNonAALab: eGFRNonAALab, calciumLab: calciumLab, proteinLab: proteinLab, albuminLab: albuminLab, calculatedGlobLab: calculatedGlobLab, agRatioLab: agRatioLab, bilirubinLab: bilirubinLab, alkPhosphataseLab: alkPhosphataseLab, astLab: astLab, altLab: altLab, microalbuminLab: microalbuminLab, ldlConcentrationLab: ldlConcentrationLab, smallLDLLab: smallLDLLab, freeT3Lab: freeT3Lab, freeT4Lab: freeT4Lab, totalCholesterolLab: totalCholesterolLab, triglyceridesLab: triglyceridesLab, hdlLab: hdlLab, ldlLab: ldlLab, hba1cLab: hba1cLab, aveGlucoseLab: aveGlucoseLab, ckLab: ckLab, sedRateLab: sedRateLab, cReactiveProteinLab: cReactiveProteinLab, cortisolLab: cortisolLab, vitaminB12Lab: vitaminB12Lab, vitaminDLab: vitaminDLab, ironLab: ironLab, tshLab: tshLab, psaLab: psaLab, testosteroneLab: testosteroneLab, uricAcidLab: uricAcidLab, folicAcidLab: folicAcidLab, ferritinLab: ferritinLab, magnesiumLab: magnesiumLab, ldhLab: ldhLab, lipaseLab: lipaseLab, amylaseLab: amylaseLab, rheumatoidFactorLab: rheumatoidFactorLab, reticulocyteLab: reticulocyteLab, antiNuclearLab: antiNuclearLab, hPyloriLab: hPyloriLab, inrLab: inrLab, unlabeledLabs:[other1View, other2View, other3View, other4View, other5View, other6View])
		//Instantiate a LabLetter object to collect the letter parts
		MyVariables.theLabLetter = LabLetter(letterDateField: letterDateView)
		
		
        //Get current date and format it
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM d, YYYY"
        let todaysDate: String = formatter.stringFromDate(NSDate())
        letterDateView.stringValue = todaysDate
		if let thisLabLetter = MyVariables.theLabLetter {
				thisLabLetter.letterDate = todaysDate
		}
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    //Sets all the form fields to an empty string
	func resetFormFields(){
		//Clear the PatientData object
		if let thePatientData = MyVariables.thePatient {
			thePatientData.clearPatientData()
		}
		
		//Clear the LabData object
		if let theCompleteLabData = MyVariables.completeLabData {
			theCompleteLabData.resetAllTheLabs()
		}
		
		//Clear the LabLetter object
		if let theLabLetter = MyVariables.theLabLetter {
			theLabLetter.resetVariables()
		}
	}
	
	@IBAction func takeShowResultsWindow(sender: AnyObject) {
		winPrint.makeKeyAndOrderFront(self)
		self.printView.string = letterString
	}

	func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
		return true
	}

}

