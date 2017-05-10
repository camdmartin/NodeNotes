//
//  NodeViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class NodeViewController: UIViewController, UITextViewDelegate {
	
    @IBOutlet var link: UIBarButtonItem!
    
    @IBAction func buttonTouched(_ sender: Any) {
        var alertController: UIAlertController?
        alertController = UIAlertController(title: "Enter Text", message: "Link Text", preferredStyle: .alert)
        alertController!.addTextField { (textField: UITextField) in
            textField.placeholder = "enter something"
        }
        self.present(alertController!,
                                   animated: true,
                                   completion: nil)
    }

	@IBOutlet var nodeNavigationBar: UINavigationItem!
	
	@IBOutlet var nodeTextView: UITextView!
	
	var node = Node(name: "Default", value: -1)
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        let btn1 = UIButton(type: .custom)
        btn1.titleLabel?.text = "Link"
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(createLink), for: .touchUpInside)
        let link = UIBarButtonItem(customView: btn1)
        link.title = "Link"
        
		nodeNavigationBar.title = node.name
		nodeTextView.text = node.text
        
        nodeNavigationBar.setRightBarButtonItems([link], animated: true)

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
    
    func createLink() {
        var alertController: UIAlertController?
        alertController = UIAlertController(title: "Enter Text", message: "Link Text", preferredStyle: .alert)
        alertController!.addTextField { (textField: UITextField) in
            textField.placeholder = "enter something"
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

