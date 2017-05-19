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
	
	@IBOutlet var sizeSlider: UISlider!
	
	@IBOutlet var saveButton: UIButton!
	
	override func viewDidLoad() {
		//self.showAnimate()
		sizeSlider.value = Float(node!.size)
		hsvColorPicker.setViewColor(node!.color)
	}
	
	@IBAction func closeViewAndSave(_ sender: UIButton) {
		node!.color = hsvColorPicker.color
		node!.size = Int(sizeSlider.value)
		if renameField.text != node!.name {
			node?.name = renameField.text!
		}
		
		self.view.removeFromSuperview()
	}
	
	func showAnimate()
	{
		self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
		self.view.alpha = 0.0;
		UIView.animate(withDuration: 0.25, animations: {
			self.view.alpha = 1.0
			self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
		});
	}
	
	func removeAnimate()
	{
		UIView.animate(withDuration: 0.25, animations: {
			self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
			self.view.alpha = 0.0;
		}, completion:{(finished : Bool)  in
			if (finished)
			{
				self.view.removeFromSuperview()
			}
		});
	}
}
