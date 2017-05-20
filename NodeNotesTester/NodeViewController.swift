//
//  NodeViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class NodeViewController: UIViewController, UITextViewDelegate {
		
	@IBOutlet var scrollView: UIScrollView!
	
	@IBOutlet var linkButton: UIButton!
	
	@IBOutlet var nodeNavigationBar: UINavigationItem!
	
	@IBOutlet var nodeTextView: UITextView!
	
	var node = Node(name: "Default", value: -1)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nodeTextView.text = node.text
		
		var i = 0
		
		for l in node.links {
			linkToNode(node: l, linkPosition: i)
			i += 1
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		nodeNavigationBar.title = node.name
		scrollView.backgroundColor = node.color
	}
	
	override func viewWillDisappear(_ animated : Bool) {
		super.viewWillDisappear(animated)
		
		if (self.isMovingFromParentViewController) {
			node.text = nodeTextView.text
		}
	}
	
	func linkToNode(node: Node, linkPosition: Int) {
		let button = NodeSelectButton(node: node, frame: CGRect(origin: CGPoint(x: (CGFloat(linkPosition) * 88 + 8), y: 12), size: CGSize(width: 80, height: 80)))
		
		button.setTitle(button.node?.name, for: .normal)
		button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 10)
		button.addTarget(self, action: #selector(selectNodeFromLink(_:)), for: .touchUpInside)
		
		button.backgroundColor = UIColor.white
		
		button.setTitleColor(UIColor.black, for: .normal)
		
		button.layer.borderColor = button.node?.color.cgColor
		button.layer.borderWidth = 3
		button.layer.cornerRadius = 0.5 * button.bounds.size.width
		
		scrollView.addSubview(button)
	}
	
	func selectNodeFromLink(_ sender: NodeSelectButton) {
		
		guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "NodeViewController") as? NodeViewController else {
			print("Could not instantiate view controller with identifier of type NodeViewController")
			return
		}
		
		vc.node = sender.node!
		vc.navigationController?.navigationBar.barTintColor = vc.node.color
		
		self.navigationController?.popViewController(animated: true)
		self.navigationController?.pushViewController(vc, animated:true)
	}
	
	@IBAction func showPopup(_ sender: UIBarButtonItem) {
		let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editPopup") as! EditPopupViewController
		
		popOverVC.node = self.node
		
		self.addChildViewController(popOverVC)
		
		popOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
		
		popOverVC.editPopupView.layer.cornerRadius = 12
		popOverVC.editPopupView.layer.borderColor = UIColor.black.cgColor
		popOverVC.editPopupView.layer.borderWidth = 3
		
		popOverVC.renameField.text = node.name
		popOverVC.fontSizeSlider.value = Float(node.fontSize)
		popOverVC.sizeSlider.value = Float(node.size)
		popOverVC.fontSizeDisplay.text = "\(self.node.fontSize)"
		popOverVC.nodeSizeDisplay.text = "\(self.node.size)"
		
		self.view.addSubview(popOverVC.view)
		
		popOverVC.didMove(toParentViewController: self)
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

