//
//  NodeViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class NodeViewController: UIViewController, UITextViewDelegate {
	
	@IBOutlet var toolbar: UIToolbar!
	
	@IBAction func renameNode(_ sender: UIBarButtonItem) {
		var alertController: UIAlertController?
		alertController = UIAlertController(title: "Rename", message: "", preferredStyle: .alert)
		alertController!.addTextField { (textField: UITextField) in
			textField.placeholder = self.node.name
		}
		
		let renameAction = UIAlertAction(title: "OK", style: .default) { (paramAction:UIAlertAction!) in
			self.node.name = (alertController?.textFields?[0].text)!
			self.nodeNavigationBar.title = self.node.name
		}
		
		alertController?.addAction(renameAction)
		
		self.present(alertController!, animated: true, completion: nil)
	}
	
	@IBAction func showPopup(_ sender: UIBarButtonItem) {
		let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editPopup") as! EditPopupViewController
		
		popOverVC.node = self.node
		
		self.addChildViewController(popOverVC)
		
		popOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - self.toolbar.frame.height)
		
		popOverVC.editPopupView.layer.cornerRadius = 12
		popOverVC.editPopupView.layer.borderColor = UIColor.black.cgColor
		popOverVC.editPopupView.layer.borderWidth = 3
		popOverVC.renameField.text = node.name

		self.view.addSubview(popOverVC.view)
		
		popOverVC.didMove(toParentViewController: self)
	}
	
	@IBOutlet var nodeNavigationBar: UINavigationItem!
	
	@IBOutlet var nodeTextView: UITextView!
	
	var node = Node(name: "Default", value: -1)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nodeTextView.text = node.text
	}
	
	override func viewWillAppear(_ animated: Bool) {
		nodeNavigationBar.title = node.name
	}
	
	override func viewWillDisappear(_ animated : Bool) {
		super.viewWillDisappear(animated)
		
		if (self.isMovingFromParentViewController) {
			node.text = nodeTextView.text
			//print("returning to workspace")
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func createLink(_ sender: UIBarButtonItem) {
		var alertController: UIAlertController?
		alertController = UIAlertController(title: "Enter Text", message: "Link Text", preferredStyle: .alert)
		alertController!.addTextField {
			(textField: UITextField) in textField.placeholder = "enter something"
		}
		
		let action = UIAlertAction(title: "Submit",
		                           style: UIAlertActionStyle.default,
		                           handler: {[weak self]
									(paramAction:UIAlertAction!) in
									if let textFields = alertController?.textFields{
										let theTextFields = textFields as [UITextField]
										var enteredText = theTextFields[0].text
										let enteredString = NSAttributedString(
											string: enteredText!,
											attributes: [NSFontAttributeName:UIFont(
												name: "Georgia",
												size: 18.0)!, NSForegroundColorAttributeName: UIColor.blue])
										enteredText = enteredString.string
										self?.nodeTextView.text = (self?.nodeTextView.text)! + " " + enteredText!
									}
		})
		alertController?.addAction(action)
		self.present(alertController!,
		             animated: true,
		             completion: nil)
		
		
		print("Linked")
	}
	
}

