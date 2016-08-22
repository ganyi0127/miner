//
//  SelectCube.swift
//  Miner
//
//  Created by ganyi on 16/8/18.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class SelectCube: SKSpriteNode {
    init(){
        super.init(texture: nil, color: .whiteColor(), size: CGSize(width: 60, height: 60))
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        zPosition = 0
    }
}
