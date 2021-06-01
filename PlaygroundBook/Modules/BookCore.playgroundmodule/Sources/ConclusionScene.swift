//
//  ConclusionScene.swift
//  BookCore
//
//  Created by Mateus Fernandes on 19/04/21.
//

import SpriteKit
import PlaygroundSupport

public class ConclusionScene: SKScene{
    
    var grid: [SKShapeNode] = []
    let pixel_size: CGFloat = 100

    let thanksNode: SKSpriteNode = SKSpriteNode(imageNamed: "credits.png")
    
    var page: Int = 1
    var widthN: Int = 0
    var heightN: Int = 0
    
    convenience init(size: CGSize, page: Int) {
        self.init(size: size)
        self.page = page
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override public func didMove(to view: SKView) {
        scene?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.widthN = Int(ceil(size.width/200))
        self.heightN = Int(ceil(size.width/200))
        
        self.makeGrid()
        thanksNode.size = CGSize(width: thanksNode.size.width*1.2, height: thanksNode.size.height*1.2)
        
        self.addChild(thanksNode)
    }
    
    @discardableResult
    public func drawLine(from pointA: CGPoint, to pointB: CGPoint, withAlpha alpha: CGFloat = 0.2, withWidth width: CGFloat = 1) -> SKShapeNode {
        let yourline = SKShapeNode()
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: pointA)
        pathToDraw.addLine(to: pointB)
        yourline.path = pathToDraw
        yourline.lineWidth = width
        yourline.alpha = alpha
        yourline.zPosition = -10
        yourline.strokeColor = .black
        self.addChild(yourline)
        return yourline
    }
    
    public func makeGrid() {
        
        var line: SKShapeNode
        
        for i in -widthN...widthN {
            line = drawLine(from: CGPoint(x: 50-CGFloat(i)*pixel_size, y: self.size.height/2),
                            to: CGPoint(x: 50-CGFloat(i)*pixel_size, y: -self.size.height/2))
            grid.append(line)
        }
        for i in -heightN...heightN {
            line = drawLine(from: CGPoint(x: -self.size.width/2, y: 50-CGFloat(i)*pixel_size),
                            to: CGPoint(x: self.size.width/2, y: 50-CGFloat(i)*pixel_size))
            grid.append(line)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
