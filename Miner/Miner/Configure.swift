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

//MARK:层级
struct ZPos {
    static let bg:CGFloat = 1
    static let cube:CGFloat = 5
    static let player:CGFloat = 10
    static let menu:CGFloat = 15
}
