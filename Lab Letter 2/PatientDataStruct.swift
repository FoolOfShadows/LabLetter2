//
//  PatientDataStruct.swift
//  Lab Letter 2
//
//  Created by Fool on 2/26/16.
//  Copyright © 2016 Fulgent Wake. All rights reserved.
//

import Cocoa

class PatientData {
	var ptName = String()
	var ptGender = String()
	var labDate = String()
	var nameField: NSTextField
	var dateField: NSTextField
	
	init(nameField: NSTextField, dateField: NSTextField) {
		self.nameField = nameField
		self.dateField = dateField
	}
	
	func clearPatientData() {
		ptName = String()
		ptGender = String()
		labDate = String()
		nameField.stringValue = String()
		dateField.stringValue = String()
	}
}

struct MyVariables {
	
	static var completeLabData:AllTheLabs?
	static var theLabLetter:LabLetter?
	static var thePatient:PatientData?

}