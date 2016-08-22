//
//  Configure.swift
//  Miner
//
//  Created by ganyi on 16/8/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit

//MARK:尺寸
let viewSize = UIScreen.mainScreen().bounds.size
let winSize = CGSize(width: 1242, height: 2208)
let showSize = CGSize(width: 1242, height: 2208 * 0.15)

//MARK:游戏控制
var isBegin = false

//MARK:矩阵大小
let widthCount:Int = 8, heightCount:Int = 12

//MARK:层级
struct ZPos {
    static let bg:CGFloat = 1
    static let selectCube:CGFloat = 4
    static let cube:CGFloat = 5
    static let lover:CGFloat = 10
    static let heart:CGFloat = 12
    
    static let show:CGFloat = 15
    static let menu:CGFloat = 20
}
