//
//  Cube.swift
//  Miner
//
//  Created by ganyi on 16/8/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
//MARK:方块类型:Black-黑洞,Frozen:不可选
enum CubeType:Int {
    case Red = 0
    case Green
    case Blue
    case Yellow
    case Black
    case Frozen
}


class Cube: SKSpriteNode {
    
    //MARK:坐标位置
    struct Coordinate{
        var x:Int?
        var y:Int?
    }
    
    //MARK:可变颜色
    private let cubeColors:[UIColor] = [
        .redColor(),
        .greenColor(),
        .blueColor(),
        .yellowColor(),
        .blackColor()
    ]
    
    //宽度百分比
    private var widthPercent:CGFloat = 0.12
    
    //MARK:标记变换，仅变换颜色
    private var transformed:Bool?
    
    //MARK:方块类型,根据类型来切换固有颜色,Frozen切换贴图
    var currentType:CubeType?{
        didSet{
            
            guard let type = currentType else{
                return
            }
            
            switch type {
            case .Frozen:
                //切换冰冻贴图
                transformed = nil
            default:
                //切换固有颜色
                color = cubeColors[type.rawValue]
                guard transformed != nil else{
                    transformed = false
                    return
                }
            }
        }
    }
    
    //MARK:坐标位置
    var coordinate:Coordinate?{
        didSet{
            //修改并执行动画
            let posX = winSize.width * widthPercent / 2 + CGFloat(coordinate!.x!) * winSize.width * widthPercent
            let posY = winSize.width * widthPercent / 2 + CGFloat(coordinate!.y!) * winSize.width * widthPercent
            
            let mvAct = SKAction.moveTo(CGPoint(x: posX,y: posY), duration: 0.5)
            runAction(mvAct)
            
            label.text = "x:\(coordinate!.x!)\ny:\(coordinate!.y!)"
        }
    }
    
    private let label = SKLabelNode(fontNamed: "hei")
    
    //MARK:标记是否需要被消除
    var needDistroy = false
    
    //MARK:初始化----------------------------------------------------------
    init(x:Int,y:Int){
        super.init(texture: nil, color: .whiteColor(), size: CGSize(width: winSize.width * widthPercent, height: winSize.width * widthPercent))
        
        coordinate = Coordinate(x: x, y: y)
        
        config()
        createContents()
    }
    
    private func config(){
        
        //初始化类型与颜色
        let rand = Int(arc4random_uniform(6))
        currentType = CubeType(rawValue: rand)
        blendMode = .Alpha
        colorBlendFactor = 1.0
        
        //初始化位置
        zPosition = 1
        
        position = CGPoint(x: size.width / 2 + CGFloat(coordinate!.x!) * size.width, y: winSize.height + size.height / 2)
        
        //修改并执行动画
        let posX = winSize.width * widthPercent / 2 + CGFloat(coordinate!.x!) * size.width
        let posY = winSize.width * widthPercent / 2 + CGFloat(coordinate!.y!) * size.height
        
        let mvAct = SKAction.moveTo(CGPoint(x: posX,y: posY), duration: 0.5)
        runAction(mvAct)
        
        label.fontColor = .purpleColor()
        label.zPosition = 50
        addChild(label)
    }
    
    private func createContents(){
        
    }
    
    //MARK:自动变换颜色
    func transform(){
        
        guard let flag = transformed where !flag else{
            return
        }
        
        let colorRand = Int(arc4random_uniform(5))
        let toColor = cubeColors[colorRand]
        
        //类型不同，则变换，否则跳过
        guard let toType = CubeType(rawValue: colorRand), curType = currentType where curType != toType else{
            return
        }
        
        transformed = true
        
        let colorAct = SKAction.colorizeWithColor(toColor, colorBlendFactor: 1.0, duration: 1.0)
        runAction(colorAct){
            self.currentType = toType
            self.transformed = false
        }
    }
    
    //MARK:冰冻
    func forzen(){
        guard let curType = currentType where curType != .Frozen else{
            return
        }
        
        currentType = .Frozen
    }
    
    //MARK:消除
    func distroy(){
        
        let rmAct = SKAction.removeFromParent()
        
        runAction(rmAct)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
