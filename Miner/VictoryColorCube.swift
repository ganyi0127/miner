//
//  VictoryColorCube.swift
//  Miner
//
//  Created by ganyi on 16/8/19.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class VictoryColorCube: ColorCube {
    
    private var label = SKLabelNode(fontNamed: "hei")
    private var originCount:Int?
    
    var count:Int?{
        didSet{
            
            guard var c = count else{
                return
            }
            
            if c < 0{
                c = 0
            }
            
            label.text = "\(c)/\(originCount!)"
        }
    }
    
    init(colorIndex: Int, cubeCount:Int) {
        super.init(colorIndex: colorIndex)
        
        originCount = cubeCount
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
    }
    
    private func createContents(){
        
        label.position = CGPoint(x: size.width * 0.6, y: 0)
        label.fontColor = .whiteColor()
        label.horizontalAlignmentMode = .Left
        label.verticalAlignmentMode = .Center
        addChild(label)
    }
}
