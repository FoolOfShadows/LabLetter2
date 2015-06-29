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
    @IBOutlet weak var other1View: NSTextField!
    @IBOutlet weak var other2View: NSTextField!
    @IBOutlet weak var other3View: NSTextField!
    @IBOutlet weak var other4View: NSTextField!
    @IBOutlet weak var other5View: NSTextField!
    @IBOutlet weak var other6View: NSTextField!
	@IBOutlet weak var otherLabView: NSTextField!
	
	var ptGender = ""
	
    @IBAction func takeWBCView(sender: AnyObject) {
    }
    @IBAction func takeProteinView(sender: AnyObject) {
    }
    
    @IBAction func takeClear(sender: AnyObject) {
     resetFormFields()
    }
    @IBAction func takeProcess(sender: AnyObject) {
		createLetterVerbiage()
		NSWorkspace.sharedWorkspace().launchApplication("PDFPen 6")
    }
    
	@IBAction func takePopulate(sender: AnyObject) {
		let controlNameVerbiageList = [wbcView:"WBC", hctView:"HEMATOCRIT", plateletsView:"PLATELET COUNT", glucoseView:"GLUCOSE", eGFRAAView:"eGFR AFRICAN AMER.", eGFRNonAAView:"eGFR NON-AFRICAN AMER.", potassiumView:"POTASSIUM", proteinView:"PROTEIN, TOTAL", calculatedGlobView:"CALCULATED GLOBULIN", agRatioView:"CALCULATED A/G RATIO", bilirubinView:"BILIRUBIN, TOTAL", alkPhosphataseView:"ALKALINE PHOSPHATASE", astView:"SGOT (AST)", altView:"SGPT (ALT)", hemoglobinA1cView:"HEMOGLOBIN A1c", averageGlucoseView:"ESTIMATED AVERAGE GLUCOSE", microalbuminView:"MICROALBUMIN, RANDOM", triglyceridesView:"TRIGLYCERIDES", hdlsView:"HDL CHOLESTEROL", ldlsView:"LDL CHOL", ldlConcentrationView:"LDL PARTICLE (P) CONC", smallLDLView:"SMALL LDL-P", tshView:"TSH ", freeT3View:"FREE T3", freeT4View:"FREE T4 (THYROXINE)", ckTotalView:"CK, TOTAL", sedRateView:"SEDIMENTATION RATE", cReactiveProteinView:"C-REACTIVE PROTEIN", cortisolView:"CORTISOL, RANDOM", psaView:"PSA, TOTAL ", vitaminB12View:"VITAMIN B-12", vitaminDView:"VITAMIN D, 25 OH", ironView:"IRON, SERUM"]
		let glucoseVerb = "GLUCOSE"
		extractValues(controlNameVerbiageList)
		
		extractComplicatedResults()
		checkValuePrep()
	}
	
	@IBAction func takePrint(sender: AnyObject) {
	}
    

    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        //Get current date and format it
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM d, YYYY"
        let todaysDate: String = formatter.stringFromDate(NSDate())
        letterDateView.stringValue = todaysDate
    resetFormFields()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    //Sets all the form fields to an empty string
    func resetFormFields(){
		let controlNameArray1 = [patientNameView, labDateView, wbcView, hgbView, hctView, plateletsView, glucoseView, creatinineView, eGFRAAView, eGFRNonAAView, potassiumView]
		let controlNameArray2 = [proteinView, albuminView, calculatedGlobView, agRatioView, bilirubinView, alkPhosphataseView, astView, altView, hemoglobinA1cView, averageGlucoseView]
		let controlNameArray3 = [microalbuminView, totalCholesterolView, triglyceridesView, hdlsView, ldlsView, ldlConcentrationView, smallLDLView, tshView]
		let controlNameArray4 = [freeT3View, freeT4View, ckTotalView, sedRateView, cReactiveProteinView, cortisolView, psaView, vitaminB12View, vitaminDView]
		let controlNameArray5 = [ironView, other1View, other2View, other3View, other4View, other5View, other6View, otherLabView]
		clearFields(controlNameArray1)
		clearFields(controlNameArray2)
		clearFields(controlNameArray3)
		clearFields(controlNameArray4)
		clearFields(controlNameArray5)
		ptGender = ""
        }
	
	//Extract data from fields which have multiple base matches
	func extractComplicatedResults() {
		var theMatch = ""
		var pasteBoard = NSPasteboard.generalPasteboard()
		let theClipboard = pasteBoard.stringForType("public.utf8-plain-text")
		let newText = stripOutExtraWords(theClipboard!)
		let theSplitClipboard = newText.componentsSeparatedByString("\n")
		let numberOfLines = theSplitClipboard.count
		
		if !theSplitClipboard.isEmpty {
			var lineCount = 0
			for currentLine in theSplitClipboard {
				lineCount++
				if currentLine.rangeOfString("CHOLESTEROL") != nil
					&& currentLine.rangeOfString("HDL CHOLESTEROL") == nil {
						regExMatching(currentLine, [totalCholesterolView:"CHOLESTEROL"])
				}
				if currentLine.rangeOfString("ALBUMIN") != nil
					&& currentLine.rangeOfString("MICROALBUMIN") == nil {
					regExMatching(currentLine, [albuminView:"ALBUMIN"])
				}
				if currentLine.rangeOfString("CREATININE") != nil
					&& currentLine.rangeOfString("MICROALBUMIN") == nil
					&& currentLine.rangeOfString("URINE") == nil{
					regExMatching(currentLine, [creatinineView:"CREATININE"])
				}
				if currentLine.rangeOfString("HEMOGLOBIN") != nil
					&& currentLine.rangeOfString("A1C") == nil
					&& currentLine.rangeOfString("A1c") == nil {
					regExMatching(currentLine, [hgbView:"HEMOGLOBIN"])
				}
				if currentLine.rangeOfString("GLUCOSE") != nil
					&& currentLine.rangeOfString("AVERAGE") == nil {
						regExMatching(currentLine, [glucoseView:"GLUCOSE"])
				}
				if currentLine.rangeOfString("COLLECTED:") != nil {
						regExDate(currentLine, [labDateView:"COLLECTED:"])
				}
				if currentLine.rangeOfString("yrs") != nil {
					//What if the file doesn't have the patients gender?
					let nameLineCount = lineCount - 2
					let patientName = theSplitClipboard[nameLineCount]
					patientNameView.stringValue = patientName
					if (currentLine.rangeOfString("yrs F") != nil) {
						ptGender = "F"
					} else if currentLine.rangeOfString("yrs M") != nil {
						ptGender = "M"
					}
				}
			}
		}
	}
	
	//Hold the sets used to determine hi/low, etc. and run the various functions using the sets
	func checkValuePrep () {
		let controlNameArrayCBC = [wbcView, hgbView, hctView, plateletsView]
		var lowArrayCBC = [Double]()
		let lowArrayCBCF = [4.0, 11.5, 34.0, 130.0]
		let lowArrayCBCM = [4.0, 13.0, 37.0, 130.0]
		var highArrayCBC = [Double]()
		let highArrayCBCF = [11.0,15.5,45.0,400.0]
		let highArrayCBCM = [11.0, 17.0, 49.0, 400.0]
		if ptGender == "F" {
			lowArrayCBC = lowArrayCBCF
			highArrayCBC = highArrayCBCF
		} else if ptGender == "M" {
			lowArrayCBC = lowArrayCBCM
			highArrayCBC = highArrayCBCM
		}
		checkValueRangesSingles(controlNameArrayCBC, lowValue: lowArrayCBC, highValue: highArrayCBC)
		
		let controlNameArrayCMP = [creatinineView, potassiumView]
		var lowArrayCMP = [Double]()
		let lowArrayCMPF = [0.6, 3.5]
		let lowArrayCMPM = [0.8, 3.5]
		var highArrayCMP = [Double]()
		let highArrayCMPF = [1.3, 5.3]
		let highArrayCMPM = [1.4, 5.3]
		if ptGender == "F" {
			lowArrayCMP = lowArrayCMPF
			highArrayCMP = highArrayCMPF
		} else if ptGender == "M" {
			lowArrayCMP = lowArrayCMPM
			highArrayCMP = highArrayCMPM
		}
		checkValueRangesSingles(controlNameArrayCMP, lowValue: lowArrayCMP, highValue: highArrayCMP)
		
		checkValueGlucose()
		
		
		
		let controlNameArrayLiver = [proteinView, albuminView, calculatedGlobView, agRatioView, bilirubinView, alkPhosphataseView, astView, altView]
		let lowArrayLiver = [6.0, 2.9, 2.0, 0.9, 0.1, 30, 5, 7]
		let highArrayLiver = [8.4,5.0,3.8,2.5,1.3,132,35,56]
		checkValueRangesSingles(controlNameArrayLiver, lowValue: lowArrayLiver, highValue: highArrayLiver)
		
		let controlNameArrayOther = [ironView, microalbuminView, freeT3View, freeT4View, ckTotalView, sedRateView, cReactiveProteinView, cortisolView, vitaminB12View, vitaminDView]
		var lowArrayOther = [Double]()
		let lowArrayOtherF = [35, 0.0, 2.3, 0.73, 30.0, 0.0, 0.0, 2.0, 243.0, 30.0]
		let lowArrayOtherM = [35, 0.0, 2.3, 0.73, 30.0, 0.0, 0.0, 2.0, 243.0, 30.0]
		var highArrayOther = [Double]()
		let highArrayOtherF = [145, 1.8,4.2,1.95,200.0,20.0,0.5,25.0,894.0,100.0]
		let highArrayOtherM = [145, 1.8,4.2,1.95,200.0,20.0,0.8,25.0,894.0,100.0]
		if ptGender == "F" {
			lowArrayOther = lowArrayOtherF
			highArrayOther = highArrayOtherF
		}else if ptGender == "M" {
			lowArrayOther = lowArrayOtherM
			highArrayOther = highArrayOtherM
		}
		checkValueRangesSingles(controlNameArrayOther, lowValue: lowArrayOther, highValue: highArrayOther)
		
		let controlNameArrayEGFR = [eGFRAAView, eGFRNonAAView]
		let valueArrayEGFR = [60.0, 60.0]
		checkValueEGFR(controlNameArrayEGFR, theValue: valueArrayEGFR)
		
		let controlNameArrayCholPSA = [smallLDLView, ldlConcentrationView, psaView]
		let valueArrayChol = [528.0, 1000.0, 4.0]
		checkValueChol(controlNameArrayCholPSA, theValue: valueArrayChol)
		
		let controlNameArrayTSH = [tshView]
		var lowArrayTSH = [Double]()
		let lowArrayTSHM = [0.5]
		let lowArrayTSHF = [0.3]
		var highArrayTSH = [Double]()
		let highArrayTSHM = [4.7]
		let highArrayTSHF = [4.2]
		if ptGender == "F" {
			lowArrayTSH = lowArrayTSHF
			highArrayTSH = highArrayTSHF
		} else if ptGender == "M" {
			lowArrayTSH = lowArrayTSHM
			highArrayTSH = highArrayTSHM
		}
		checkValueRangesTSH(controlNameArrayTSH, lowValue: lowArrayTSH, highValue: highArrayTSH)
		
		checkGroupForNormal(controlNameArrayCBC)
		checkGroupForNormal(controlNameArrayLiver)
	}
	
	//Check and set the hi/low values of the normal tests
	func checkValueRangesSingles(textFields:[NSTextField!], lowValue: [Double], highValue: [Double]) {
		for var i = 0; i < textFields.count; i++ {
			if !textFields[i].stringValue.isEmpty || textFields[i].stringValue != "" {
				let baseValue = textFields[i].doubleValue
				//let low = lowValue[i]
				if baseValue < lowValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Low"
				} else if baseValue > highValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - High"
				} else {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Normal"
				}
			}
		}
	}
	
	//Check and set the under/over active values of the thyroid test
	func checkValueRangesTSH(textFields:[NSTextField!], lowValue: [Double], highValue: [Double]) {
		for var i = 0; i < textFields.count; i++ {
			if !textFields[i].stringValue.isEmpty || textFields[i].stringValue != "" {
				let baseValue = textFields[i].doubleValue
				//let low = lowValue[i]
				if baseValue < lowValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Overactive"
				} else if baseValue > highValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Underactive"
				} else {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Normal"
				}
			}
		}
	}
	
	func checkValueRangesGroup(textFields:[NSTextField!], lowValue: [Double], highValue: [Double]) {
		for var i = 0; i < textFields.count; i++ {
			if !textFields[i].stringValue.isEmpty || textFields[i].stringValue != "" {
				let baseValue = textFields[i].doubleValue
				let low = lowValue[i]
				if baseValue < lowValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Low"
				} else if baseValue > highValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - High"
				} else {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Normal"
				}
			}
		}
	}
	
	//Check Glucose results for normalcy
	func checkValueGlucose() {
		let glucoseValue = glucoseView.integerValue
		if !glucoseView.stringValue.isEmpty || glucoseView.stringValue != "" {
			switch glucoseValue {
			case 0..<65 :
				glucoseView.stringValue = "\(glucoseView.stringValue) - Low"
			case 65..<101 :
				glucoseView.stringValue = "\(glucoseView.stringValue) - Normal"
			case 101..<105 :
				glucoseView.stringValue = "\(glucoseView.stringValue) - Borderline High"
			default :
				glucoseView.stringValue = "\(glucoseView.stringValue) - High"
			}
		}
	}
	
	//Check eGFR results for normalcy
	func checkValueEGFR(textFields:[NSTextField!], theValue:[Double]) {
		for var i = 0; i < textFields.count; i++ {
			if !textFields[i].stringValue.isEmpty || textFields[i].stringValue != "" {
				let baseValue = textFields[i].doubleValue
				if baseValue < theValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Low"
				} else if baseValue >= theValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Normal"
				}
			}
		}
	}
	
	//Check Cholesterol results for normalcy
	func checkValueChol(textFields:[NSTextField!], theValue:[Double]) {
		for var i = 0; i < textFields.count; i++ {
			if !textFields[i].stringValue.isEmpty || textFields[i].stringValue != "" {
				let baseValue = textFields[i].doubleValue
				if baseValue > theValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - High"
				} else if baseValue < theValue[i] {
					textFields[i].stringValue = "\(textFields[i].stringValue) - Normal"
				}
			}
		}
	}
	
	func checkGroupForNormal(textFields:[NSTextField!]) {
		var theFieldCount = 0
		var theNormalCount = 0
		for i in textFields {
			if i.stringValue != "" {
				theFieldCount++
			}
		}
		for i in textFields {
			if i.stringValue.rangeOfString("Normal") != nil {
				theNormalCount++
			}
		}
		if theFieldCount != 0 && theNormalCount == theFieldCount {
			groupValuesNormal(textFields)
		} else {
			setNormalsToBlank(textFields)
		}
		
	}
	
	func setNormalsToBlank(textFields:[NSTextField!]) {
		for i in textFields {
			if i.stringValue.rangeOfString("Normal") != nil {
				i.stringValue = ""
			}
		}
	}
	
	func groupValuesNormal(textFields: [NSTextField!]) {
		for var index = 0; index < textFields.count; index++ {
			if index == 0 {
				textFields[index].stringValue = "Norm"
			} else {
				textFields[index].stringValue = ""
			}
		}

	}
	
	//Based on the contents of the form, create the verbiage for the actual letter
	func createLetterVerbiage() {
		let tab = "        "
		let letterDateString = "\(letterDateView.stringValue)"
		let patientNameString = "Dear \(patientNameView.stringValue),"
//		let labDate1 = labDateView.stringValue
//		var finalLabDate = ""
//		if !labDate1.isEmpty {
//			let labDateFormatter1 = NSDateFormatter()
//			labDateFormatter1.dateStyle = .ShortStyle
//			let labDate2: NSDate = labDateFormatter1.dateFromString(labDate1)!
//			let labDateFormatter2 = NSDateFormatter()
//			labDateFormatter2.dateFormat = "M/d/YY"
//			let finalLabDate = labDateFormatter2.stringFromDate(labDate2)
//		}
		let labDateString = "These are the results of your lab from \(labDateView.stringValue)."
		var totalCholesterolString = ""
		if !totalCholesterolView.stringValue.isEmpty || totalCholesterolView.stringValue != "" {
			 totalCholesterolString = "Total Cholesterol: \(totalCholesterolView.stringValue).\nNormal is less than 200. Keep dietary cholesterol under 300mg per day and keep total fat in your diet to less than 30 percent of total daily calorie intake.\n"
		}
		var triglyceridesString = ""
		if !triglyceridesView.stringValue.isEmpty || triglyceridesView.stringValue != "" {
			 triglyceridesString = "Triglycerides (fat): \(triglyceridesView.stringValue).\nNormal is less than 150. Decrease the amount of fat in your diet to positively affect this number.\n"
		}
		var hdlsString = ""
		if !hdlsView.stringValue.isEmpty || hdlsView.stringValue != "" {
			 hdlsString = "HDL Cholesterol: \(hdlsView.stringValue).\nNormal is above 40 and the goal is above 50. This is the \"good\" cholesterol and protects against heart attacks.  Exercise will improve this number.\n"
		}
		var ldlsString = ""
		if !ldlsView.stringValue.isEmpty || ldlsView.stringValue != "" {
			 ldlsString = "LDL Cholesterol: \(ldlsView.stringValue).\nFair is less than 130, good is less than 100, and excellent is less than 70.  This is the \"bad\" cholesterol. Lifestyle changes such as diet and exercise can decrease this number."
		}
		var ldlConcentrationString = ""
		if !ldlConcentrationView.stringValue.isEmpty || ldlConcentrationView.stringValue != "" {
			 ldlConcentrationString = "LDL Particle Concentration: \(ldlConcentrationView.stringValue)\(tab)"
		}
		var smallLDLString = ""
		if !smallLDLView.stringValue.isEmpty || smallLDLView.stringValue != "" {
			 smallLDLString = "Small Dense LDL: \(smallLDLView.stringValue)"
		}
		var hemoglobinA1cString = ""
		if !hemoglobinA1cView.stringValue.isEmpty || hemoglobinA1cView.stringValue != "" {
			 hemoglobinA1cString = "Hemoglobin A1c: \(hemoglobinA1cView.stringValue).  The goal is less than 7 and normal is less than 6.  This number equals a 3 month average blood sugar of \(averageGlucoseView.stringValue) (the goal is less than 150)."
		}
		var microAlbuminString = ""
		if !microalbuminView.stringValue.isEmpty || microalbuminView.stringValue != "" {
			 microAlbuminString = "Urine Microalbumin: \(microalbuminView.stringValue)"
		}
		var glucoseString = ""
		if !glucoseView.stringValue.isEmpty || glucoseView.stringValue != "" {
			 glucoseString = "Glucose: \(glucoseView.stringValue)\(tab)"
		}
		var creatinineString = ""
		if !creatinineView.stringValue.isEmpty || creatinineView.stringValue != "" {
			creatinineString = "Creatinine: \(creatinineView.stringValue)\(tab)"
		}
		var potassiumString = ""
		if !potassiumView.stringValue.isEmpty || potassiumView.stringValue != "" {
			potassiumString = "Potassium: \(potassiumView.stringValue)"
		}
		var eGFRAAString = ""
		if !eGFRAAView.stringValue.isEmpty || eGFRAAView.stringValue != "" {
			eGFRAAString = "eGFR African American: \(eGFRAAView.stringValue)"
		}
		var eGFRNonAAString = ""
		if !eGFRNonAAView.stringValue.isEmpty || eGFRNonAAView.stringValue != "" {
			eGFRNonAAString = "eGFR Non-African American: \(eGFRNonAAView.stringValue)"
		}
		var proteinString = ""
		if !proteinView.stringValue.isEmpty || proteinView.stringValue != "" {
			if proteinView.stringValue == "Norm" {
				proteinString = "Liver panel results within normal range."
			} else {
				proteinString = "Protein: \(proteinView.stringValue)"
			}
		}
		var albuminString = ""
		if !albuminView.stringValue.isEmpty || albuminView.stringValue != "" {
			albuminString = "Albumin: \(albuminView.stringValue)"
		}
		var calculatedGlobString = ""
		if !calculatedGlobView.stringValue.isEmpty || calculatedGlobView.stringValue != "" {
			calculatedGlobString = "Globulin: \(calculatedGlobView.stringValue)"
		}
		var bilirubinString = ""
		if !bilirubinView.stringValue.isEmpty || bilirubinView.stringValue != "" {
			bilirubinString = "Bilirubin: \(bilirubinView.stringValue)"
		}
		var alkPhosphataseString = ""
		if !alkPhosphataseView.stringValue.isEmpty || alkPhosphataseView.stringValue != "" {
			alkPhosphataseString = "Alk Phosphatase: \(alkPhosphataseView.stringValue)"
		}
		var astString = ""
		if !astView.stringValue.isEmpty || astView.stringValue != "" {
			astString = "SGOT (AST): \(astView.stringValue)"
		}
		var altString = ""
		if !altView.stringValue.isEmpty || altView.stringValue != "" {
			altString = "SGPT (ALT): \(altView.stringValue)"
		}
		var tshString = ""
		if !tshView.stringValue.isEmpty || tshView.stringValue != "" {
			tshString = "TSH: \(tshView.stringValue)"
		}
		var freeT3String = ""
		if !freeT3View.stringValue.isEmpty || freeT3View.stringValue != "" {
			freeT3String = "Free T3: \(freeT3View.stringValue)"
		}
		var freeT4String = ""
		if !freeT4View.stringValue.isEmpty || freeT4View.stringValue != "" {
			freeT4String = "Free T4: \(freeT4View.stringValue)"
		}
		var psaString = ""
		if !psaView.stringValue.isEmpty || psaView.stringValue != "" {
			psaString = "PSA: \(psaView.stringValue)"
		}
		var cortisolString = ""
		if !cortisolView.stringValue.isEmpty || cortisolView.stringValue != "" {
			cortisolString = "Cortisol: \(cortisolView.stringValue)"
		}
		var ckTotalString = ""
		if !ckTotalView.stringValue.isEmpty || ckTotalView.stringValue != "" {
			ckTotalString = "Creatinine Kinase: \(ckTotalView.stringValue)"
		}
		var cReactiveProteinString = ""
		if !cReactiveProteinView.stringValue.isEmpty || cReactiveProteinView.stringValue != "" {
			cReactiveProteinString = "C-Reactive Protein: \(cReactiveProteinView.stringValue)"
		}
		var vitaminDString = ""
		if !vitaminDView.stringValue.isEmpty || vitaminDView.stringValue != "" {
			vitaminDString = "Vitamin D: \(vitaminDView.stringValue)"
		}
		var vitaminB12String = ""
		if !vitaminB12View.stringValue.isEmpty || vitaminB12View.stringValue != "" {
			vitaminB12String = "Vitamin B12: \(vitaminB12View.stringValue)"
		}
		var ironString = ""
		if !ironView.stringValue.isEmpty || ironView.stringValue != "" {
			ironString = "Iron: \(ironView.stringValue)"
		}
		var wbcString = ""
		if !wbcView.stringValue.isEmpty || wbcView.stringValue != "" {
			if wbcView.stringValue == "Norm" {
				wbcString = "Blood count results within normal range."
			} else {
				wbcString = "White Blood Count: \(wbcView.stringValue)"
			}
		}
		var hgbString = ""
		if !hgbView.stringValue.isEmpty || hgbView.stringValue != "" {
			hgbString = "Hemoglobin: \(hgbView.stringValue)"
		}
		var hctString = ""
		if !hctView.stringValue.isEmpty || hctView.stringValue != "" {
			hctString = "Hematocrit: \(hctView.stringValue)"
		}
		var plateletsString = ""
		if !plateletsView.stringValue.isEmpty || plateletsView.stringValue != "" {
			plateletsString = "Platelets: \(plateletsView.stringValue)"
		}
		var sedRateString = ""
		if !sedRateView.stringValue.isEmpty || sedRateView.stringValue != "" {
			sedRateString = "Sedimentation Rate: \(sedRateView.stringValue)"
		}
		var agRatioString = ""
		if !agRatioView.stringValue.isEmpty || agRatioView.stringValue != "" {
			agRatioString = "A/G Ratio: \(agRatioView.stringValue)"
		}
		var other1String = ""
		if !other1View.stringValue.isEmpty || other1View.stringValue != "" {
			other1String = "\(other1View.stringValue)"
		}
		var other2String = ""
		if !other2View.stringValue.isEmpty || other2View.stringValue != "" {
			other2String = "\(other2View.stringValue)"
		}
		var other3String = ""
		if !other3View.stringValue.isEmpty || other3View.stringValue != "" {
			other3String = "\(other3View.stringValue)"
		}
		var other4String = ""
		if !other4View.stringValue.isEmpty || other4View.stringValue != "" {
			other4String = "\(other4View.stringValue)"
		}
		var other5String = ""
		if !other5View.stringValue.isEmpty || other5View.stringValue != "" {
			other5String = "\(other5View.stringValue)"
		}
		var other6String = ""
		if !other6View.stringValue.isEmpty || other6View.stringValue != "" {
			other6String = "\(other6View.stringValue)"
		}
		
		
		//Create the strings for the different sections
			//Cholesterol
		var aNewLine = ""
		if (ldlConcentrationString != "") || (smallLDLString != "") {
			aNewLine = "\n"
		}
		var cholesterolResults: String = totalCholesterolString + triglyceridesString + hdlsString + ldlsString + aNewLine + ldlConcentrationString + smallLDLString
		var cholesterolFinal = ""
		if cholesterolResults != "" {
			cholesterolFinal = "CHOLESTEROL\n\(cholesterolResults)\n\n"
		}
		
			//CBC
		var bloodCountArray = [String]()
		let cbcTestingArray = [wbcString, hgbString, hctString, plateletsString]
		for var i = 0; i < cbcTestingArray.count; i++ {
			if cbcTestingArray[i] != "" {
				bloodCountArray.append(cbcTestingArray[i])
			}
		}
		let bcArrayCount = bloodCountArray.count
		var bloodCountResults = ""
		if bcArrayCount > 0 {
			if bcArrayCount <= 3 {
				bloodCountResults = tab.join(bloodCountArray)
			} else if bcArrayCount > 3 {
				bloodCountResults = "\(wbcString)\(tab)\(hgbString)\(tab)\(hctString)\n\(plateletsString)"
			}
		}
		var bloodCountFinal = ""
		if bloodCountResults != "" {
			bloodCountFinal = "BLOOD COUNT\n\(bloodCountResults)\n\n"
		}
		
			//CMP
		var cmpResults = ""
		var cmpResultsArray = [String]()
		let cmpArray = [glucoseString, creatinineString, potassiumString]
		for i in cmpArray {
			if i != "" {
				cmpResultsArray.append(i)
			}
		}
		if !cmpResultsArray.isEmpty {
		cmpResults = tab.join(cmpResultsArray)
		}
		var eGFRResults = ""
		if eGFRAAString != "" {
			if cmpResults != "" {
				eGFRResults = "\n\(eGFRAAString)\(tab)\(eGFRNonAAString)"
			} else {
				eGFRResults = "\(eGFRAAString)\(tab)\(eGFRNonAAString)"
			}
		}
		var cmpFinal = ""
		if cmpResults != "" {
			cmpFinal = "COMPLETE METABOLIC PANEL\n\(cmpResults)\(eGFRResults)\n\n"
		}
		
			//Liver Panel
		var liverArray = [String]()
		let liverTestingArray = [proteinString, albuminString, calculatedGlobString, bilirubinString, alkPhosphataseString, agRatioString, astString, altString]
		for var i = 0; i < liverTestingArray.count; i++ {
			if liverTestingArray[i] != "" {
				liverArray.append(liverTestingArray[i])
			}
		}
		let liverArrayCount = liverArray.count
		var liverResults = ""
		if liverArrayCount < 4 {
			liverResults = tab.join(liverArray)
		} else if (liverArrayCount > 3) && (liverArrayCount < 7) {
			var basicLiverArray1 = liverArray[0..<3]
			var basicLiverArray2 = liverArray[3..<liverArrayCount]
			liverResults = tab.join(basicLiverArray1) + "\n" + tab.join(basicLiverArray2)
		} else if liverArrayCount > 6 {
			var basicLiverArray1 = liverArray[0..<3]
			var basicLiverArray2 = liverArray[3..<6]
			var basicLiverArray3 = liverArray[6..<liverArrayCount]
			liverResults = tab.join(basicLiverArray1) + "\n" + tab.join(basicLiverArray2) + "\n" + tab.join(basicLiverArray3)
		}
		var liverFinal = ""
		if liverResults != "" {
			liverFinal = "LIVER PANEL\n\(liverResults)\n\n"
		}
		
		
		
		
			//HbA1c/Microalbumin
		var hgbMicroResults = ""
		var hgbMicroResultsArray = [String]()
		let hgbMicroArray = [hemoglobinA1cString, microAlbuminString]
		for i in hgbMicroArray {
			if i != "" {
				hgbMicroResultsArray.append(i)
			}
		}
		hgbMicroResults = "\n".join(hgbMicroResultsArray)
		var hgbMicroFinal = ""
		if hgbMicroResults != "" {
			hgbMicroFinal = "BLOOD SUGAR AVERAGE/MICROALBUMIN\n\(hgbMicroResults)\n\n"
		}
		
		
			//Thyroid
		var thyroidResults = ""
		var thyroidResultsArray = [String]()
		let thyroidArray = [tshString, freeT3String, freeT4String]
		for i in thyroidArray {
			if i != "" {
				thyroidResultsArray.append(i)
			}
		}
		thyroidResults = tab.join(thyroidResultsArray)
		var thyroidFinal = ""
		if thyroidResults != "" {
			thyroidFinal = "THYROID FUNCTION\n\(thyroidResults)\n\n"
		}
		
			//Other
		var otherArray = [String]()
		let otherTestingArray = [psaString, ckTotalString, cReactiveProteinString, cortisolString, sedRateString, vitaminB12String, vitaminDString, ironString, other1String, other2String, other3String, other4String, other5String, other6String]
		for var i = 0; i < otherTestingArray.count; i++ {
			if otherTestingArray[i] != "" {
				otherArray.append(otherTestingArray[i])
			}
		}
		let otherArrayCount = otherArray.count
		var otherResults = ""
		if otherArrayCount < 4 {
			otherResults = tab.join(otherArray)
		} else if (otherArrayCount > 3) && (otherArrayCount < 7) {
			var basicOtherArray1 = otherArray[0..<3]
			var basicOtherArray2 = otherArray[3..<otherArrayCount]
			otherResults = tab.join(basicOtherArray1) + "\n" + tab.join(basicOtherArray2)
		} else if (otherArrayCount > 6) && (otherArrayCount < 10) {
			var basicOtherArray1 = otherArray[0..<3]
			var basicOtherArray2 = otherArray[3..<6]
			var basicOtherArray3 = otherArray[6..<otherArrayCount]
			otherResults = tab.join(basicOtherArray1) + "\n" + tab.join(basicOtherArray2) + "\n" + tab.join(basicOtherArray3)
		} else if (otherArrayCount > 9) && (otherArrayCount < 13) {
			var basicOtherArray1 = otherArray[0..<3]
			var basicOtherArray2 = otherArray[3..<6]
			var basicOtherArray3 = otherArray[6..<9]
			var basicOtherArray4 = otherArray[9..<otherArrayCount]
			otherResults = tab.join(basicOtherArray1) + "\n" + tab.join(basicOtherArray2) + "\n" + tab.join(basicOtherArray3) + "\n" + tab.join(basicOtherArray4)
		} else if (otherArrayCount > 12) && (otherArrayCount < 16) {
			var basicOtherArray1 = otherArray[0..<3]
			var basicOtherArray2 = otherArray[3..<6]
			var basicOtherArray3 = otherArray[6..<9]
			var basicOtherArray4 = otherArray[9..<12]
			var basicOtherArray5 = otherArray[12..<otherArrayCount]
			otherResults = tab.join(basicOtherArray1) + "\n" + tab.join(basicOtherArray2) + "\n" + tab.join(basicOtherArray3) + "\n" + tab.join(basicOtherArray4) + "\n" + tab.join(basicOtherArray5)
		}
		var otherFinal = ""
		if otherResults != "" {
			otherFinal = "OTHER\n\(otherResults)"
		}
		
		
		//Compose the final letter from the substrings
		let letterString = "\(letterDateString)\n\n\(patientNameString)\n\n\(labDateString)\n\n\(bloodCountFinal)\(cholesterolFinal)\(hgbMicroFinal)\(cmpFinal)\(liverFinal)\(thyroidFinal)\(otherFinal)\n\nPlease call my office and make an appointment if you have any questions about these results.\nSincerely,\n\nDawn R. Whelchel, M.D."
		
		//Pass the final results to the clipboard
		var pasteBoard = NSPasteboard.generalPasteboard()
		pasteBoard.clearContents()
		pasteBoard.setString(letterString, forType: NSPasteboardTypeString)
		
	}
	


}

