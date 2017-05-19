//
//  EditPopupViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 5/19/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import Foundation
import UIKit

class EditPopupViewController: UIViewController {
	var node: Node? = nil
	
	@IBOutlet var renameField: UITextField!
	
	@IBOutlet var hsvColorPicker: SwiftHSVColorPicker!
	
	@IBOutlet var saveButton: UIButton!
	
	override func viewDidLoad() {
		hsvColorPicker.setViewColor(node!.color)
	}
	
	@IBAction func closeViewAndSave(_ sender: UIButton) {
		node!.color = hsvColorPicker.color
		if renameField.text != node!.name {
			node?.name = renameField.text!
		}
		
		self.view.removeFromSuperview()
	}
	
}
