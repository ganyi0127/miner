//
//  GameScene.swift
//  Miner
//
//  Created by ganyi on 16/8/4.
//  Copyright (c) 2016年 ganyi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private let background = Background()
    let cubeLayer = CubeLayer()
    let showLayer = ShowLayer()
    
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
        addChild(showLayer)
        
        showLayer.successDistroy = Distroy(heart: 5, red: 2, green: 0, blue: 12, yellow: 13, black: 5)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !isBegin{
            isBegin = true
        }
    }
   
    override func update(currentTime: CFTimeInterval) {

        cubeLayer.update(currentTime)
    }
}
