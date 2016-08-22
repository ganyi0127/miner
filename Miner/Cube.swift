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
    case Purple
    case Black
    case Frozen
}

//MARK:可变颜色
let cubeColors:[SKColor] = [
    SKColor(red: 255 / 255, green: 68 / 255, blue: 75 / 255, alpha: 1.0), //red
    SKColor(red: 70 / 255, green: 255 / 255, blue: 75 / 255, alpha: 1.0), //green
    SKColor(red: 79 / 255, green: 114 / 255, blue: 255 / 255, alpha: 1.0), //blue
    SKColor(red: 255 / 255, green: 224 / 255, blue: 88 / 255, alpha: 1.0), //yellow
    SKColor(red: 211 / 255, green: 182 / 255, blue: 255 / 255, alpha: 1.0)  //purple
]

private let cubeTex = SKTexture(imageNamed: "color_origin")
private let frozenTex = SKTexture(imageNamed: "color-4")

class Cube: SKSpriteNode {
    
    //MARK:坐标位置
    struct Coordinate{
        var x:Int?
        var y:Int?
    }
    
    //MARK:标记变换，仅变换颜色
    var transformed:Bool?
    
    //MARK:方块类型,根据类型来切换固有颜色,Frozen切换贴图
    var currentType:CubeType?{
        didSet{
            
            guard let type = currentType else{
                return
            }
            
            switch type {
            case .Frozen:
                transformed = nil
                texture = frozenTex
            case .Black:
                //切换黑洞贴图
                transformed = nil
                texture = frozenTex
            default:
                //切换固有颜色
                color = cubeColors[type.rawValue]
                blendMode = .Alpha
                colorBlendFactor = 1.0
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
            let posY = size.height / 2 + CGFloat(coordinate!.y!) * size.height
            
            let mvAct = SKAction.moveToY(posY, duration: 0.5)
            runAction(mvAct)
            
            label.text = "x:\(coordinate!.x!)\ny:\(coordinate!.y!)"
        }
    }
    
    private let label = SKLabelNode(fontNamed: "hei")
    
    //MARK:标记是否需要被消除
    var needDistroy = false
    
    //MARK:标记是否带♥️
    var marked = false{
        didSet{
            guard marked else{
                return
            }
            
            let heart = Heart()
            addChild(heart)
        }
    }
    
    //MARK:初始化----------------------------------------------------------
    init(x:Int,y:Int){
        super.init(texture: cubeTex, color: .clearColor(), size: cubeTex.size())
        
        coordinate = Coordinate(x: x, y: y)
        
        config()
        createContents()
    }
    
    private func config(){
        
        //初始化类型与颜色 普通方块概率 于 特殊方块概率
        var rand:Int?
        if arc4random_uniform(10) < 9 {
            //五种基础方块
            rand = Int(arc4random_uniform(5))
        }else{
            //两种特殊方块
            rand = Int(arc4random_uniform(2)) + 5
        }
        currentType = CubeType(rawValue: rand!)
        
        //初始化位置
        zPosition = 1
        
        position = CGPoint(x: winSize.width / CGFloat(widthCount) * CGFloat(coordinate!.x!) + size.width / 2,
                           y: winSize.height + size.height / 2)
        
        //修改并执行动画
        let posY = size.height / 2 + CGFloat(coordinate!.y!) * size.height
        
        let mvAct = SKAction.moveToY(posY, duration: 0.5)
        runAction(mvAct)
        
        label.fontColor = .purpleColor()
        label.zPosition = 50
        addChild(label)
    }
    
    private func createContents(){
        
    }
    
    //MARK:自动变换颜色 nil:随机
    func transform(colorIndex:Int?){
        
        guard let flag = transformed where !flag else{
            return
        }
        
        var colorRand:Int
        var toColor:UIColor?
        var toType:CubeType?
        
        //判断是否为随机或指定颜色
        if let index = colorIndex{
            toColor = cubeColors[index]
            toType = CubeType(rawValue: index)
        }else{
            //类型相同，则变换，否则跳过
            repeat{
                
                colorRand = Int(arc4random_uniform(5))
                toColor = cubeColors[colorRand]
                toType = CubeType(rawValue: colorRand)
            }while toType == currentType
        }
        
        transformed = true
        
        let colorAct = SKAction.colorizeWithColor(toColor!, colorBlendFactor: 1.0, duration: 1.0)
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
