//
//  GameScene.swift
//  Miner
//
//  Created by ganyi on 16/8/4.
//  Copyright (c) 2016年 ganyi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let background = Background()
    let cubeLayer = CubeLayer()
    
    override init() {
        super.init(size: winSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {

        config()
        createContents()
    }
    
    private func config(){
        
    }
    
    private func createContents(){
        
        addChild(background)
        addChild(cubeLayer)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        cubeLayer.removeAll()

    }
   
    override func update(currentTime: CFTimeInterval) {

        cubeLayer.update(currentTime)
    }
}
