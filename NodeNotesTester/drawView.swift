//
//  drawView.swift
//  NodeNotesTester
//
//  Created by Samuil Agranovich on 5/29/17.
//  Copyright © 2017 cmartin. All rights reserved.
//

import UIKit

class drawView: UIImageView {
    
    var currentMap = WorldMap(width: 1000, height: 1000)
    var bg = UIImageView()
    var lf = UIImageView()
    var savedImage = UIImage()
    
    let layers = Dictionary<Int, UIImageView>()
    
    func setBackgroundLayer() -> UIImageView {
        let bg = currentMap.background
        let layer = UIImageView()
        layer.image = bg
        addSubview(layer)
        layer.isOpaque = true
        layer.frame = CGRect(x: 0, y: 0, width: currentMap.width, height: currentMap.height)
        return layer
    }
    
    func setLandformsLayer() -> UIImageView {
        let lf = currentMap.landforms
        let layer = UIImageView()
        layer.image = lf
        addSubview(layer)
        layer.isOpaque = true
        layer.frame = CGRect(x: 0, y: 0, width: currentMap.width, height: currentMap.height)
        return layer
    }
    
    func drawMap() {
        bg = setBackgroundLayer()
        lf = setLandformsLayer()
    }
    
    
    
}
