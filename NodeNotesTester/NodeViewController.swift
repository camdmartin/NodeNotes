//
//  NodeViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit
import Foundation

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
	
	@IBOutlet var nodeNavigationBar: UINavigationItem!
	
	@IBOutlet var nodeTextView: UITextView!
	

	var node = Node(name: "Default", value: -1)
	
   // var attributes = Array<Array<Int>>()
    var addedAttributes = Array<String>()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		nodeNavigationBar.title = node.name
		nodeTextView.text = node.text
	}
	
	override func viewWillDisappear(_ animated : Bool) {
		super.viewWillDisappear(animated)
		
		if (self.isMovingFromParentViewController) {
			node.text = nodeTextView.text
			print("returning to workspace")
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func textViewDidChange(_ textView: UITextView) {
		node.text = textView.text
		print("text changed to \(textView.text)")
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
										var enteredString = NSMutableAttributedString(
											string: (self?.nodeTextView.text)! + " " + enteredText!,
											attributes: [NSFontAttributeName: UIFont(
                                        name: "System Font Regular",
                                        size: 14.0)!])
                                        self?.addedAttributes.append((enteredText)!)
                                        for attribute in (self?.addedAttributes)!{
                                            if (enteredString.string.contains(attribute)){
                                            enteredString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(
                                                location: enteredString.string.distance(from: enteredString.string.startIndex, to: enteredString.string.range(of: attribute)!.lowerBound),
                                                length:(enteredText?.characters.count)!))
                                        }
                                        }
											//, NSForegroundColorAttributeName: UIColor.blue])**/
										enteredText = enteredString.string
                                        print(enteredString.string)
										self?.nodeTextView.attributedText = enteredString
									}
                                    
		})
		alertController?.addAction(action)
		self.present(alertController!,
		             animated: true,
		             completion: nil)
		
		
		print("Linked")
	}
	
}

