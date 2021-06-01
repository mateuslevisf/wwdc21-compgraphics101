//
//  LightScene.swift
//  BookCore
//
//  Created by Mateus Fernandes on 15/04/21.
//

import SpriteKit
import PlaygroundSupport

public class LightScene: SKScene, LightsDelegate {
    
    let lightNode: SKLightNode = SKLightNode()
    var waterShader: SKShader?
    
    override init(size: CGSize) {
        super.init(size: size)
        waterShader = createWaterShader()
    }
    
    override public func didMove(to view: SKView) {
        scene?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let noiseTexture = SKTexture(imageNamed: "background")
        
        let background = SKSpriteNode(texture: noiseTexture,
                                      normalMap: noiseTexture.generatingNormalMap())
        
        let proportion = self.frame.size.height/background.size.height
        background.size = CGSize(width: background.size.width*proportion, height: background.size.height*proportion)
        background.lightingBitMask = 0b0001
        background.zPosition = -2
        self.addChild(background)
        
        let x: CGFloat = 0
        let y = self.size.height/5
        
        // Create a light
        lightNode.position = CGPoint(x: 0, y: 0)
        lightNode.categoryBitMask = 0b0001
        lightNode.lightColor = .white
        lightNode.isHidden = true
        self.addChild(lightNode)
        
//        let size = CGSize(width: 605, height: 484)
        
        // Create two rabbit sprite nodes and assign them with both a lighting and a shadow cast bit mask.
        for position in [CGPoint(x: x, y: y), CGPoint(x: x, y: -y)] {
            let robot = SKSpriteNode(imageNamed: "robot")
            robot.position = position
            //dog.size = size
            robot.lightingBitMask = 0b0001
            robot.shadowCastBitMask = 0b0001
            robot.zPosition = 1
            robot.name = "robot"
            self.addChild(robot)
        }
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let parent = self.scene else {return}
        let touch = touches.first!
        let myLocation = touch.location(in: parent)
        let action = SKAction.move(to: myLocation, duration: 0.01)
        self.lightNode.run(action)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let parent = self.scene else {return}
            let touch = touches.first!
            let myLocation = touch.location(in: parent)
            let action = SKAction.move(to: myLocation, duration: 0.01)
            self.lightNode.run(action)
    }
    
    override public func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    
    func updateView(lightsOn: Bool, underwater: Bool) {
        lightNode.isHidden = !lightsOn
        setWaterShaders(on: underwater)
    }
    
    func setWaterShaders(on: Bool) {
        let robots: [SKNode] = self.children.filter({$0.name == "robot"})
        if on {
            for robot in robots {
                let node = robot as! SKSpriteNode
                node.shader = waterShader
            }
        } else {
            for robot in robots {
                let node = robot as! SKSpriteNode
                node.shader = nil
            }
        }
    }
    
    func createWaterShader() -> SKShader {
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_speed", float: 3),
            SKUniform(name: "u_strength", float: 2.5),
            SKUniform(name: "u_frequency", float: 10)]
        let water: SKShader = SKShader(fromFile: "SHKWater", uniforms: uniforms)
        return water
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
