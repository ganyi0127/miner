//
//  CubeLayer.swift
//  Miner
//
//  Created by ganyi on 16/8/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
class CubeLayer: SKNode {
    
    private let widthCount:Int = 8, heightCount:Int = 12
    
    //MARK:矩阵
    private var matrix = [[Bool]]()
    
    //MARK:保存方块
    var cubeList = [Cube]()
    //MARK:保存需要消除的方块
    var distroyCubeList = [Cube]()
    
    //MARK:是否为活动状态
    var fallAction = false
    var checkAction = false
    
    //MARK:定时任务
    var task:Task?
    
    //MARK:init-------------------------------------------------
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    private func config(){
        
        position = .zero
        zPosition = ZPos.cube
     
     
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
            
            cube.transform()
        }
    }
    
    //MARK:更新
    func update(currentTime: CFTimeInterval){
        
        if !fallAction && !checkAction{
            
            if cubeList.count < widthCount * heightCount{
                if fallCubeList(false){
                    
                    delay(1){
                        self.fallAction = false
                    }
                }
            }else{
                check(){
                    
                    //1秒后调用变幻
                    delay(1){
                        
                        self.choiceCubeToTransform()
                        
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
    private func check(closure:()->()){
        
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
                    if currentType == cube.currentType{
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
                    if currentType == cube.currentType{
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
                }
            }
        }
        
        //销毁
        let removeCubeList = cubeList.filter(){$0.needDistroy}
        cubeList = cubeList.filter(){!$0.needDistroy}
        removeCubeList.forEach(){
            cube in
            matrix[cube.coordinate!.x!][cube.coordinate!.y!] = false
            cube.distroy()
        }
    
        closure()
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
