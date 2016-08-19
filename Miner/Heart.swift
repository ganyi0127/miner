//
//  Heart.swift
//  Miner
//
//  Created by ganyi on 16/8/18.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class Heart: SKSpriteNode {
    init(){
        
        super.init(texture: nil, color: .redColor(), size: CGSize(width: 20, height: 20))
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        zPosition = 2
    }
}
