//
//  VictoryNode.swift
//  Miner
//
//  Created by ganyi on 16/8/19.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class VictoryNode: SKSpriteNode {
    
    //MARK:胜利条件
    var distroy = Distroy(){
        didSet{
            //初始化保存
            if heartVictoryColorCube == nil{
                heartVictoryColorCube = VictoryColorCube(colorIndex: 0, cubeCount: distroy.heart)
                heartVictoryColorCube?.position = CGPoint(x: -size.width / 2, y: 0)
                addChild(heartVictoryColorCube!)
            }
            if redVictoryColorCube == nil{
                redVictoryColorCube = VictoryColorCube(colorIndex: 0, cubeCount: distroy.red)
                redVictoryColorCube?.position = CGPoint(x: size.width / 6 - size.width / 2, y: 0)
                addChild(redVictoryColorCube!)
            }
            if greenVictoryColorCube == nil{
                greenVictoryColorCube = VictoryColorCube(colorIndex: 1, cubeCount: distroy.green)
                greenVictoryColorCube?.position = CGPoint(x: size.width / 6 * 2 - size.width / 2, y: 0)
                addChild(greenVictoryColorCube!)
            }
            if blueVictoryColorCube == nil {
                blueVictoryColorCube = VictoryColorCube(colorIndex: 2, cubeCount: distroy.blue)
                blueVictoryColorCube?.position = CGPoint(x: size.width / 6 * 3 - size.width / 2, y: 0)
                addChild(blueVictoryColorCube!)
            }
            if yelloVictoryColorCube == nil{
                yelloVictoryColorCube = VictoryColorCube(colorIndex: 3, cubeCount: distroy.yellow)
                yelloVictoryColorCube?.position = CGPoint(x: size.width / 6 * 4 - size.width / 2, y: 0)
                addChild(yelloVictoryColorCube!)
            }
            if blackVictoryColorCube == nil{
                blackVictoryColorCube = VictoryColorCube(colorIndex: 4, cubeCount: distroy.black)
                blackVictoryColorCube?.position = CGPoint(x: size.width / 6 * 5 - size.width / 2, y: 0)
                addChild(blackVictoryColorCube!)
            }
            
            heartVictoryColorCube?.count = distroy.heart
            redVictoryColorCube?.count = distroy.red
            greenVictoryColorCube?.count = distroy.green
            blueVictoryColorCube?.count = distroy.blue
            yelloVictoryColorCube?.count = distroy.yellow
            blackVictoryColorCube?.count = distroy.black
        }
    }
    
    private var heartVictoryColorCube:VictoryColorCube?
    private var redVictoryColorCube:VictoryColorCube?
    private var greenVictoryColorCube:VictoryColorCube?
    private var blueVictoryColorCube:VictoryColorCube?
    private var yelloVictoryColorCube:VictoryColorCube?
    private var blackVictoryColorCube:VictoryColorCube?
    
    init(){
        
        super.init(texture: nil, color: .grayColor(), size: CGSize(width: showSize.width * 0.75, height: showSize.height * 0.3))
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        position = CGPoint(x: showSize.width * 0.5, y: showSize.height * 0.7)
        zPosition = 1
    }
    
    private func createContents(){
        
    }
}
