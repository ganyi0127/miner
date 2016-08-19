//
//  Lover.swift
//  Miner
//
//  Created by ganyi on 16/8/17.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class Lover: SKSpriteNode {
    
    var task:Task?
    
    init(){
        super.init(texture: nil, color: .greenColor(), size: CGSize(width: 50, height: 80))
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        position = CGPoint(x: showSize.width / 2, y: size.height / 2)
        zPosition = 1
    }
    
    private func createContents(){
        
       throwLoop()
    }
    
    private func addTextures(){
    
    }
    
    func throwLoop(){
        
        if isBegin{
            
            throwHeart(1)
        }
        
        task = delay(1){
            
            self.throwLoop()
        }
    }
    
    //MARK:丢♥️
    private func throwHeart(count:Int = 1){
        
        let cubeList = ((parent as! ShowLayer).scene as! GameScene).cubeLayer.cubeList
        let cubeListCount = cubeList.count
        let index = Int(arc4random_uniform(UInt32(cubeListCount)))
        let cube = cubeList[index]
        let cubePosition = cube.position
        let selfPosition = convertPoint(cubePosition, fromNode: ((parent as! ShowLayer).scene as! GameScene).cubeLayer)
        
        let heart = Heart()
        heart.position = .zero
        addChild(heart)
        
        let mvAct = SKAction.moveTo(selfPosition, duration: 1)
        let rmAct = SKAction.removeFromParent()
        let seqAct = SKAction.sequence([mvAct, rmAct])
        heart.runAction(seqAct){
            
            cube.marked = true
        }
    }
    
    deinit{
        cancel(task)
    }
}
