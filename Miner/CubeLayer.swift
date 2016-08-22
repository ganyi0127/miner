//
//  CubeLayer.swift
//  Miner
//
//  Created by ganyi on 16/8/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
//MARK:消除回调的数据结构
struct Distroy {
    var heart = 0
    var red = 0
    var green = 0
    var blue = 0
    var yellow = 0
    var black = 0
}

class CubeLayer: SKNode {
    
    //MARK:矩阵
    private var matrix = [[Bool]]()
    
    //MARK:保存方块
    var cubeList = [Cube]()
    //MARK:保存需要消除的方块
    var distroyCubeList = [Cube]()
    
    //MARK:是否为活动状态
    var fallAction = false
    var checkAction = false
    
    //MARK:开始触摸标记
    
    
    //MARK:定时任务
    var task:Task?
    
    //技能--消除冰冻技能
    var disfrozenCount = 0{
        didSet{
            
        }
    }
    //技能--展示方块数量
    var selectCount = 1{
        didSet{
            guard let gameScene = scene as? GameScene else{
                return
            }
            //随机添加可选方块
            gameScene.showLayer.addNewColorCube(nil)
        }
    }
    
    //MARK:init-------------------------------------------------
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    private func config(){
        
        position = .zero
        zPosition = ZPos.cube
     
        userInteractionEnabled = true
    }
    
    private func createContents(){
        
        //初始化矩阵
        (0..<widthCount).forEach(){
            _ in
            var xMatrix = [Bool]()
            (0..<heightCount).forEach(){
                _ in
                
                xMatrix.append(false)
            }
            matrix.append(xMatrix)
        }

        fallAction = false
    }
    
    //MARK:测试用
    func removeAll(){
        removeChildrenInArray(cubeList)
        cubeList.removeAll()
        
        (0..<widthCount).forEach(){
            widthIndex in
           
            (0..<heightCount).forEach(){
                heightIndex in
                
                matrix[widthIndex][heightIndex] = false
            }
        }
    }
    
    //MARK:随机变幻cube
    private func choiceCubeToTransform(){
        let min = 3
        let max = Int(arc4random_uniform(10)) + min
        
        var needTransformCubes = [Cube]()
        
        while needTransformCubes.count < max {
            
            let count = UInt32(cubeList.count)
            let randIndex = Int(arc4random_uniform(count))
            let cube = cubeList[randIndex]
            if !needTransformCubes.contains(cube) {
                needTransformCubes.append(cube)
            }
        }
        
        needTransformCubes.forEach(){
            cube in
            
            cube.transform(nil)
        }
    }
    
    //MARK:更新
    func update(currentTime: CFTimeInterval){
        
        if !fallAction && !checkAction{
            
            if cubeList.count < widthCount * heightCount{
                if fallCubeList(false){
                    
                    delay(1){
                        self.check(){
                            distroy in
                    
                            var oldDistroy = (self.scene as! GameScene).showLayer.victoryNode.distroy
                            oldDistroy.heart -= distroy.heart
                            oldDistroy.red -= distroy.red
                            oldDistroy.green -= distroy.green
                            oldDistroy.blue -= distroy.blue
                            oldDistroy.yellow -= distroy.yellow
                            oldDistroy.black -= distroy.black
                            (self.scene as! GameScene).showLayer.victoryNode.distroy = oldDistroy
                            
                            delay(0.5){
                                self.fallAction = false
                                self.checkAction = false

                            }
                        }
                    }
                }
            }else{
                check(){
                    distroy in
                    
                    var oldDistroy = (self.scene as! GameScene).showLayer.victoryNode.distroy
                    oldDistroy.heart -= distroy.heart
                    oldDistroy.red -= distroy.red
                    oldDistroy.green -= distroy.green
                    oldDistroy.blue -= distroy.blue
                    oldDistroy.yellow -= distroy.yellow
                    oldDistroy.black -= distroy.black
                    (self.scene as! GameScene).showLayer.victoryNode.distroy = oldDistroy
                    
                    //1秒后调用变幻
                    delay(1){
                          
//                        if self.cubeList.count == widthCount * heightCount{
//                            
//                            //当矩阵填充满后随机改变cube颜色
//                            self.choiceCubeToTransform()
//                        }
                        
                        delay(0.5){
                            self.checkAction = false
                        }
                    }
                }
            }
        }
    }
    
    //MARK:补充方块
    private func fallCubeList(full:Bool) -> Bool{

        fallAction = true
        
        guard !full else{
            fallAction = false
            return true
        }
        
        for (xIndex, xMatrix) in matrix.enumerate(){
            
            for (yIndex, flag) in xMatrix.enumerate(){
                
                if !flag{
                    var fixIndex = yIndex
                    while fixIndex < heightCount && !matrix[xIndex][fixIndex]{
                        fixIndex += 1
                        if fixIndex == heightCount{
                            fixIndex = yIndex
                            break
                        }
                    }
                    
                    if fixIndex == yIndex{
                        //添加新方块
                        addNewCube(xIndex, y: yIndex)
                    }else{
                        //掉落方块
                        let cubes = Array(cubeList).filter(){$0.coordinate?.x == xIndex && $0.coordinate?.y == fixIndex}
                        cubes.forEach(){
                            cube in
                            cube.coordinate?.y = yIndex
                            matrix[xIndex][fixIndex] = false
                        }
                    }
                    
                    matrix[xIndex][yIndex] = true
                    
                    return fallCubeList(false)
                }
            }
        }
        
        return true
    }
    
    //MARK:检查是否有销毁
    private func check(closure:(distroy:Distroy)->()){
        
        checkAction = true
        
        for xIndex in 0..<widthCount{
            
            for yIndex in 0..<heightCount{
                
                var cubes = Array(cubeList).filter(){$0.coordinate?.x == xIndex && $0.coordinate?.y == yIndex}
                guard let currentCube:Cube = cubes.first else{
                    return
                }
                
                let currentType = currentCube.currentType
                //列 >
                cubes = Array(cubeList).filter(){$0.coordinate?.x == xIndex}.sort({ (cube0, cube1) -> Bool in
                    return cube0.coordinate!.y! < cube1.coordinate!.y!
                })
                
                var distroyCubes = [currentCube]
                var index = currentCube.coordinate!.y! + 1
                while index < heightCount{
                    let cube = cubes[index]
                    if cube.currentType == currentType{
                        distroyCubes.append(cube)
                    }else{
                        break
                    }
                    
                    index += 1
                }
                
                if distroyCubes.count >= 3{
                    distroyCubes.forEach(){
                        cube in
                        cube.needDistroy = true
                    }
                    
                    //判断数量，增加技能
                    if distroyCubes.count > 4{
                        selectCount += 1
                    }
                    
                    if distroyCubes.count > 3{
                        disfrozenCount += 1
                    }
                }
                
                //行 >
                cubes = Array(cubeList).filter(){$0.coordinate?.y == yIndex}.sort({ (cube0, cube1) -> Bool in
                    return cube0.coordinate!.x! < cube1.coordinate!.x!
                })

                distroyCubes.removeAll()
                distroyCubes.append(currentCube)
                
                index = currentCube.coordinate!.x! + 1
                while index < widthCount{
                    let cube = cubes[index]
                    if cube.currentType == currentType{
                        distroyCubes.append(cube)
                    }else{
                        break
                    }
                    index += 1
                }
                
                if distroyCubes.count >= 3{
                    distroyCubes.forEach(){
                        cube in
                        cube.needDistroy = true
                    }
                    
                    if distroyCubes.count > 4{
                        selectCount += 1
                    }
                    
                    if distroyCubes.count > 3{
                        disfrozenCount += 1
                    }
                }
            }
        }
        
        //销毁
        var distroy = Distroy()
        let removeCubeList = cubeList.filter(){$0.needDistroy}
        cubeList = cubeList.filter(){!$0.needDistroy}
        removeCubeList.forEach(){
            cube in
            
            if cube.marked{
                distroy.heart += 1
            }
            
            switch cube.currentType!{
            case .Red:
                distroy.red += 1
            case .Green:
                distroy.green += 1
            case .Blue:
                distroy.blue += 1
            case .Yellow:
                distroy.yellow += 1
            case .Black:
                distroy.black += 1
            default:
                break
            }
            
            matrix[cube.coordinate!.x!][cube.coordinate!.y!] = false
            cube.distroy()
        }
    
        //回调
        closure(distroy: distroy)
    }
    
    //MARK:添加新方块
    private func addNewCube(x:Int, y:Int){
        let cube = Cube(x: x, y: y)
        addChild(cube)
        cubeList.append(cube)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:触摸事件
extension CubeLayer{
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touches.forEach(){
            touch in
            
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
          
            //限制点击条件
            guard !fallAction else{
                return
            }
            
            //获取点击的cube
            guard let cube:Cube = node as? Cube else{
                return
            }
            
            //获取场景
            guard let gameScene:GameScene = scene as? GameScene else{
                return
            }
            
            //获取已选择的颜色，或默认为第一个颜色
            if let colorIndex:Int = gameScene.showLayer.removeColorCube(){
                
                //改变cube颜色
                cube.transform(colorIndex)
            }            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
}