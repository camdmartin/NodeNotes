//
//  DetailViewController.swift
//  NodeNotesTester
//
//  Created by Cameron Martin on 4/10/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	var workspace = Workspace(name: "Default")
	
	@IBOutlet var workspaceNavigationBar: UINavigationItem!
	@IBOutlet weak var detailDescriptionLabel: UILabel!

	func configureView() {
		if let label = self.detailDescriptionLabel {
			label.text = workspace.name
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		workspaceNavigationBar.title = workspace.name
		self.configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	var detailItem: NSDate? {
		didSet {
		    // Update the view.
		    self.configureView()
		}
	}


}

