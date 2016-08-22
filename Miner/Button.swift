//
//  Button.swift
//  Miner
//
//  Created by YiGan on 8/22/16.
//  Copyright © 2016 ganyi. All rights reserved.
//

import SpriteKit
enum ButtonType {
    case Pause
    case Play
    case Shop
    case Info
}
class Button:SKSpriteNode{
    
    var closure: (()->())?
    
    //MARK:init------------------------------------------------
    init(buttonType:ButtonType){
        super.init(texture: nil, color: .clearColor(), size: CGSize(width: 100, height: 60))
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        userInteractionEnabled = true
    }
    
    private func createContents(){
        
    }
}

//MARK:触摸事件
extension Button{
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let block = closure else{
            return
        }
        
        block()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
}
