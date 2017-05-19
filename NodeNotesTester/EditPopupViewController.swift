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
	
	@IBOutlet var hsvColorPicker: SwiftHSVColorPicker!
	
	@IBOutlet var saveButton: UIButton!
	
	@IBAction func closeViewAndSave(_ sender: UIButton) {
		//node!.color = hsvColorPicker.color
		
		self.view.removeFromSuperview()
	}
	
}
