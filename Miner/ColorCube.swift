//
//  ColorCube.swift
//  Miner
//
//  Created by ganyi on 16/8/18.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class ColorCube: SKSpriteNode {
    
    var currentIndex:Int?
    
    init(colorIndex:Int){
        
        let color = cubeColors[colorIndex]
        super.init(texture: nil, color: color, size: CGSize(width: 50, height: 50))
        
        currentIndex = colorIndex
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        zPosition = ZPos.cube
    }
    
    private func createContents(){
        
    }
}
