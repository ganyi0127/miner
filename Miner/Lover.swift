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
            
            throwHeart(1){
                gameover in
            }
        }
        
        task = delay(1){
            
            self.throwLoop()
        }
    }
    
    //MARK:丢♥️ true:找到合适的cube false:查找不到空位
    private func throwHeart(count:Int = 1, closure: (Bool)->()){
        
        let cubeList = ((parent as! ShowLayer).scene as! GameScene).cubeLayer.cubeList
        
        //判断是否有空位
        let copyList = Array(cubeList).filter(){!$0.marked}
        if copyList.isEmpty{
            closure(true)
            return
        }
        
        let cubeListCount = copyList.count
        //选中的cube
        globalThread(){
            
            var cube:Cube?
           
            let index = Int(arc4random_uniform(UInt32(cubeListCount)))
            cube = copyList[index]
            
            mainThread(){
                
                let cubePosition = cube!.position
                let selfPosition = self.convertPoint(cubePosition, fromNode: ((self.parent as! ShowLayer).scene as! GameScene).cubeLayer)
                
                let heart = Heart()
                heart.position = .zero
                self.addChild(heart)
                
                let mvAct = SKAction.moveTo(selfPosition, duration: 1)
                let rmAct = SKAction.removeFromParent()
                let seqAct = SKAction.sequence([mvAct, rmAct])
                heart.runAction(seqAct){
                    
                    cube!.marked = true
                }
                closure(false)
            }
        }
       
    }
    
    deinit{
        cancel(task)
    }
}
