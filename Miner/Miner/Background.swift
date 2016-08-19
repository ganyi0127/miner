//
//  Background.swift
//  Miner
//
//  Created by ganyi on 16/8/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class Background:SKNode{
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    private func config(){
        
        position = .zero
        zPosition = ZPos.bg
    }
    
    private func createContents(){

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
