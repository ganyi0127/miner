//
//  ShowLayer.swift
//  Miner
//
//  Created by ganyi on 16/8/17.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class ShowLayer: SKNode {
    
    //选择的颜色
//    private var selectColorIndex:Int?
    
    //选择的位置
//    private var selectListIndex:Int?{
//        didSet{
//            
//            guard let index = selectListIndex else{
//                
//                selectCube?.position = colorCubeList[0].position
//                
//                return
//            }
//            
//            if selectCube == nil{
//                selectCube = SelectCube()
//                addChild(selectCube!)
//            }
//            
//            selectCube?.position = colorCubeList[index].position
//        }
//    }
    
    //选择的colorCube
    private var selectColorCube:ColorCube?{
        didSet{
            
            guard let cube = selectColorCube else{
                
                selectCube?.position = colorCubeList[0].position
                
                return
            }
            
            if selectCube == nil{
                selectCube = SelectCube()
                addChild(selectCube!)
            }
            
            selectCube?.position = cube.position
        }
    }
    
    private var colorCubeList = [ColorCube](){
        didSet{
            
            if colorCubeList.isEmpty{
                addNewColorCube(nil)
            }
            
            colorCubeList.enumerate().forEach(){
                index, colorCube in
                colorCube.position = CGPoint(x: 40 + CGFloat(index) * 80, y: showSize.height - 80)
            }
        }
    }
    
    //选择提示框
    private var selectCube:SelectCube? = nil
    
    private let lover = Lover()
    
    //胜利条件
    var successDistroy = Distroy(){
        didSet{
            
            victoryNode.distroy = successDistroy
            
            if successDistroy.heart <= 0 &&
                successDistroy.red <= 0 &&
                successDistroy.green <= 0 &&
                successDistroy.blue <= 0 &&
                successDistroy.yellow <= 0 &&
                successDistroy.black <= 0{
                //游戏胜利
                
            }
            
        }
    }
    
    //提示消除
    var victoryNode = VictoryNode()
    
    //MARK:init-------------------------------------------
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        userInteractionEnabled = true
        
        position = CGPoint(x: 0, y: winSize.height - showSize.height)
        zPosition = ZPos.show
    }
    
    private func createContents(){
        
        addChild(lover)
        addChild(victoryNode)
        
        addNewColorCube(nil)
    }
    
    //MARK: 更新
    func update(currentTime: CFTimeInterval) {
        
        
    }
    
    //MARK:添加新方块
    func addNewColorCube(colorIndex:Int?){
        
        var index:Int?
        if let i = colorIndex{
            index = i
        }else{
            index = Int(arc4random_uniform(4))
            
        }
        let colorCube = ColorCube(colorIndex: index!)
        addChild(colorCube)
        colorCubeList.append(colorCube)
    }
    
    //MARK:移除方块
    func removeColorCube() -> Int?{
        
        if selectColorCube == nil{
            selectColorCube = colorCubeList[0]
        }
        
        let result = selectColorCube?.currentIndex
        if let index = colorCubeList.indexOf(selectColorCube!){
            
            colorCubeList.removeAtIndex(index)
            selectColorCube!.removeFromParent()
            selectColorCube = nil
        }
        
        return result
    }
}

//MARK: 触摸事件
extension ShowLayer{
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        touches.forEach(){
            touch in
            
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            
            //获取点击到的colorCube
            guard let colorCube:ColorCube = node as? ColorCube else{
                return
            }

            selectColorCube = colorCube
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
}