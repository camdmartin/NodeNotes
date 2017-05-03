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
        print("Linked")
    }
	
}
