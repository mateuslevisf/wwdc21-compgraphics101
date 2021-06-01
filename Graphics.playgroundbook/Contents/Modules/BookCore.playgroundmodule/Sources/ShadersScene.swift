//
//  ShaderScene.swift
//  BookCore
//
//  Created by Mateus Fernandes on 14/04/21.
//

import SpriteKit
import PlaygroundSupport

public class ShadersScene: SKScene, ShadersDelegate {
    
    let imageNode = SKSpriteNode(imageNamed: "shader_image.png")
    var explanations: [String: SKSpriteNode] = [:]
    var shaders: [String: SKShader] = [:]
    let helpButton = SKSpriteNode(imageNamed: "help.png")
    
    let colorizeNode: SKSpriteNode = SKSpriteNode(imageNamed: "colorize.png")
    let embossNode: SKSpriteNode = SKSpriteNode(imageNamed: "emboss.png")
    let pixelateNode: SKSpriteNode = SKSpriteNode(imageNamed: "pixelate.png")
    var currentShader: String = "None"
    var closeFlag: Bool = false
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override public func didMove(to view: SKView) {
        shaders["Colorize"] = createColorizeShader()
        shaders["Pixelate"] = createPixelateShader()
        shaders["Emboss"] = createEmbossShader()
        shaders["Water"] = createWaterShader()
        
        explanations["Colorize"] = colorizeNode
        explanations["Pixelate"] = pixelateNode
        explanations["Emboss"] = embossNode
        
        scene?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageNode.size = CGSize(width: imageNode.size.width/3.0, height: imageNode.size.height/3.0)
        imageNode.position = CGPoint(x: 0.0, y: -view.frame.width/10.0)
        imageNode.setValue(SKAttributeValue(size: imageNode.size), forAttribute: "a_size")
        self.addChild(imageNode)
        
        helpButton.position = CGPoint(x: 0, y: view.frame.width/2.2)
        helpButton.name = "helpButton"
        self.addChild(helpButton)
        
        colorizeNode.isHidden = true
        pixelateNode.isHidden = true
        embossNode.isHidden = true
        colorizeNode.zPosition = 20
        pixelateNode.zPosition = 20
        embossNode.zPosition = 20
        self.addChild(colorizeNode)
        self.addChild(pixelateNode)
        self.addChild(embossNode)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if helpButton.contains(pos) {
            var buttonTexture = SKTexture(imageNamed: "close.png")
            if closeFlag {
                buttonTexture = SKTexture(imageNamed: "help.png")
            }
            switch currentShader {
            case "Colorize":
                helpButton.texture = buttonTexture
                colorizeNode.isHidden = !colorizeNode.isHidden
                closeFlag = !closeFlag
            case "Emboss":
                helpButton.texture = buttonTexture
                embossNode.isHidden = !embossNode.isHidden
                closeFlag = !closeFlag
            case "Pixelate":
                helpButton.texture = buttonTexture
                pixelateNode.isHidden = !pixelateNode.isHidden
                closeFlag = !closeFlag
            default:
                helpButton.run(SKAction.shake(initialPosition: helpButton.position, duration: 0.5))
            }
        }
    }

    func touchMoved(toPoint pos : CGPoint) {
        return
    }
    
    func touchUp(atPoint pos : CGPoint) {
        return
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func update(_ currentTime: TimeInterval) {
    }
    
    public func updateShader(shaderName: String) {
        helpButton.texture = SKTexture(imageNamed: "help.png")
        closeFlag = false
        explanations[currentShader]?.isHidden = true
        currentShader = shaderName
        if shaderName == "None" {
            removeShader()
        } else {
            imageNode.shader = shaders[shaderName]
        }
    }
    
    func createColorizeShader() -> SKShader {
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_color", color: .red),
            SKUniform(name: "u_strength", float: 1)]
        let colorize: SKShader = SKShader(fromFile: "SHKColorize", uniforms: uniforms)
        return colorize
    }
    
    func createPixelateShader() -> SKShader {
        let uniforms: [SKUniform] = [SKUniform(name: "u_strength", float: 8)]
        let attributes = [SKAttribute(name: "a_size", type: .vectorFloat2)]
        let pixelate: SKShader = SKShader(fromFile: "SHKPixelate", uniforms: uniforms, attributes: attributes)
        return pixelate
    }
    
    func createEmbossShader() -> SKShader {
        let uniforms: [SKUniform] = [SKUniform(name: "u_strength", float: 10)]
        let attributes: [SKAttribute] = [SKAttribute(name: "a_size", type: .vectorFloat2)]
        let emboss: SKShader = SKShader(fromFile: "SHKEmboss", uniforms: uniforms, attributes: attributes)
        return emboss
    }
    
    func createWaterShader() -> SKShader {
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_speed", float: 3),
            SKUniform(name: "u_strength", float: 2.5),
            SKUniform(name: "u_frequency", float: 10)]
        let water: SKShader = SKShader(fromFile: "SHKWater", uniforms: uniforms)
        return water
    }
    
    func removeShader() {
        imageNode.shader = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
