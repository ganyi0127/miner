//
//  GameoverLayer.swift
//  Miner
//
//  Created by YiGan on 8/22/16.
//  Copyright © 2016 ganyi. All rights reserved.
//

import SpriteKit
class GameoverLayer: SKNode {
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        position = CGPoint(x: 0, y: winSize.height)
        zPosition = ZPos.menu
    }
    
    private func createContents(){
        
    }
    
    //MARK:展开
    private func show(){
        
    }
}
