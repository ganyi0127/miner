//
//  GameViewController.swift
//  Miner
//
//  Created by ganyi on 16/8/4.
//  Copyright (c) 2016年 ganyi. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        delegate.blockRotation = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        delegate.blockRotation = false
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        let scene = GameScene()
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .Portrait
        } else {
            return .Landscape
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
