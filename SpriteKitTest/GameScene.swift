//
//  GameScene.swift
//  SpriteKitTest
//
//  Created by 藤治仁 on 2021/11/06.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var touchPosition: CGPoint?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        // キャラクターを手前にする
        guard let girlNode = self.childNode(withName: "girl") else { return }
        girlNode.zPosition = 255
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            self.touchPosition = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) ,
           let touchPosition = self.touchPosition {
            let distance = CGPoint(x: touchPosition.x - location.x,
                                   y: touchPosition.y - location.y)
            
            guard let mapNode = self.childNode(withName: "map") else { return }
            guard let girlNode = self.childNode(withName: "girl") else { return }
            
            let pos = mapNode.position
            let size = mapNode.frame.size
            let girlSize = girlNode.frame.size
            
            let movePos = CGPoint(x: pos.x + distance.x * 1,
                                  y: pos.y + distance.y * 1)

            // 端あたり判定
            // 左
            if movePos.x < (size.width / 2 - girlSize.width / 2) * -1 {
                print("左")
                return
            }
            //右
            if movePos.x > (size.width / 2 - girlSize.width / 2) {
                print("右")
                return
            }
            //上
            if movePos.y < (size.height / 2 - girlSize.height / 2) * -1 {
                print("上")
                return
            }
            //下
            if movePos.y > (size.height / 2 - girlSize.height / 2) {
                print("下")
                return
            }


            let moveAction = SKAction.move(to: movePos, duration: 0.0)
            mapNode.run(moveAction)
            print(mapNode.position)
            self.touchPosition = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
