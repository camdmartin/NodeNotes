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
	
	@IBOutlet var editPopupView: UIView!
	
	@IBOutlet var renameField: UITextField!
	
	@IBOutlet var hsvColorPicker: SwiftHSVColorPicker!
	
	@IBOutlet var fontSizeSlider: UISlider!
	
	@IBOutlet var fontSizeDisplay: UILabel!
	
	@IBOutlet var sizeSlider: UISlider!
	
	@IBOutlet var nodeSizeDisplay: UILabel!
	
	@IBOutlet var saveButton: UIButton!
	
	override func viewDidLoad() {
		sizeSlider.value = Float(node!.size)
		hsvColorPicker.setViewColor(node!.color)
	}
	
	@IBAction func sliderValueChanged(_ sender: UISlider) {
		switch sender.restorationIdentifier! {
		case "fss": fontSizeDisplay.text = "\(Int(fontSizeSlider.value))"
		case "nss": nodeSizeDisplay.text = "\(Int(sizeSlider.value))"
		default: ()
		}
		
	}
	
	@IBAction func closeViewAndSave(_ sender: UIButton) {
		node!.color = hsvColorPicker.color
		node!.size = Int(sizeSlider.value)
		node!.fontSize = Int(fontSizeSlider.value)
		node!.name = renameField.text!
		
		let vc = self.parent as! NodeViewController
		vc.nodeNavigationBar.title = node?.name
		vc.scrollView.backgroundColor = node?.color
		self.view.removeFromSuperview()
	}
	
	@IBAction func closeViewWithoutSaving(_ sender: UIButton) {
		self.view.removeFromSuperview()
	}
}
