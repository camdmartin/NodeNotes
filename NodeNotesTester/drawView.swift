//
//  drawView.swift
//  NodeNotesTester
//
//  Created by Samuil Agranovich on 5/29/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class drawView: UIImageView {
    
    var bg = UIImageView()
    var savedImage = UIImage()
	
    func setBackgroundLayer() -> UIImageView {
        let layer = UIImageView()
        layer.image = bg.image
        addSubview(layer)
        layer.isOpaque = true
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        return layer
    }
	
    func draw() {
        bg = setBackgroundLayer()
    }
}
