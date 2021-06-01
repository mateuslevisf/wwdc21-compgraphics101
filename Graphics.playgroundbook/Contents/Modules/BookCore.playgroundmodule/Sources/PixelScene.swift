//
//  PixelScene.swift
//  BookCore
//
//  Created by Mateus Fernandes on 11/04/21.
//

import SpriteKit
import PlaygroundSupport

public class PixelScene: SKScene, PixelDelegate {
    
    let single_pixel: SKSpriteNode = SKSpriteNode(color: .black, size: CGSize(width: 100, height: 100))
    let resetButton: SKSpriteNode = SKSpriteNode(imageNamed: "reset")
        
    var flag: Bool = false
    var grid: [SKShapeNode] = []
    var test_selected: [(CGFloat, CGFloat)] = []
    var test_touched: [(CGFloat, CGFloat)] = []
    var pixels: [SKSpriteNode] = []
    
    var page: Int = 1
    var drawingFlag = 0
    
    let pixel_size: CGFloat = 100
    var widthN: Int = 0
    var heightN: Int = 0
    
    let tileColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    convenience init(size: CGSize, page: Int) {
        self.init(size: size)
        self.page = page
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override public func didMove(to view: SKView) {
        scene?.backgroundColor = tileColor
        
        self.widthN = Int(ceil(size.width/200))
        self.heightN = Int(ceil(size.width/200))
        
        self.makeGrid()
        if page == 1 {
            single_pixel.zPosition = 10.0
            single_pixel.color = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.0)
            self.addChild(single_pixel)
        }
        
        if page == 2 {
            resetButton.size = CGSize(width: resetButton.size.width/1.2, height: resetButton.size.height/1.2)
            resetButton.position = CGPoint(x: 0, y: view.frame.width/2.1)
            resetButton.zPosition = 10.0
            resetButton.name = "resetButton"
            self.addChild(resetButton)
        }
    }
    
    public func updatePixel(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        single_pixel.color = UIColor(displayP3Red: r, green: g, blue: b, alpha: alpha)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if drawingFlag == 1 {
            return
        }
        if page == 1 {
            if single_pixel.contains(pos) {
                if flag {
                    flag = false
                    single_pixel.run(.resize(toWidth: 100, height: 100, duration: 0.2))
                } else {
                    flag = true
                    single_pixel.run(.resize(toWidth: 500, height: 500, duration: 0.2))
                }
            }
        }
        else if page == 2 {
            let array = nodes(at: pos)
            let row = ceil(-(pos.x+50)/pixel_size)
            let col = ceil(-(pos.y+50)/pixel_size)
            if array.isEmpty && !resetButton.contains(pos) {
                test_selected.append((row, col))
                let square: SKSpriteNode = SKSpriteNode(color: tileColor, size: CGSize(width: 98, height: 98))
                let mark: SKSpriteNode = SKSpriteNode(imageNamed: "circle")
                mark.addChild(square)
                mark.name = "mark"
                mark.size = CGSize(width: 60, height: 60)
                mark.position = CGPoint(x: -row*pixel_size, y: -col*pixel_size)
                self.addChild(mark)
            } else {
                for element in array {
                    if element.name == "resetButton" {
                        for child in self.children {
                            if child.name == "mark" {
                                child.removeFromParent()
                            }
                        }
                        test_selected = []
                        test_touched = []
                        for pixel in pixels {
                            pixel.removeFromParent()
                        }
                    } else if element is SKSpriteNode {
                        element.removeFromParent()
                        test_touched.append((row, col))
                        test_selected.removeAll(where: {$0 == (row,col)})
                    }
                }
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        return
    }
    
    func touchUp(atPoint pos : CGPoint) {
        test_touched = []
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if drawingFlag == 1 {
            return
        }
        if page == 2 {
            for t in touches {
                let pos = t.location(in: self)
                if !resetButton.contains(pos) {
                    let row = ceil(-(pos.x+50)/pixel_size)
                    let col = ceil(-(pos.y+50)/pixel_size)
                    if test_touched.contains(where: {$0 == (row,col)}) {
                        continue
                    }
                    if !test_selected.contains(where: {$0 == (row,col)}) {
                        test_selected.append((row,col))
                        let square: SKSpriteNode = SKSpriteNode(color: tileColor, size: CGSize(width: 98, height: 98))
                        let mark: SKSpriteNode = SKSpriteNode(imageNamed: "circle")
                        mark.addChild(square)
                        mark.size = CGSize(width: 60, height: 60)
                        mark.name = "mark"
                        mark.position = CGPoint(x: -row*pixel_size, y: -col*pixel_size)
                        self.addChild(mark)
                    }
                }
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
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
    
    func drawSelectedPixels(serial: Bool) {
        var actions: [SKAction] = []
        let fade_in = SKAction.fadeIn(withDuration: 0.1)
        var c = 1
        if !test_selected.isEmpty {
            for element in test_selected {
                let pos = CGPoint(x: -element.0*pixel_size, y: -element.1*pixel_size)
                let array = nodes(at: pos)
                for element in array {
                    if element is SKSpriteNode {
                        element.removeFromParent()
                    }
                }
                
                let new_pixel: SKSpriteNode = SKSpriteNode(color: .black, size: CGSize(width: 100, height: 100))
                new_pixel.position = CGPoint(x: pos.x, y: pos.y)
                new_pixel.alpha = 0.0
                new_pixel.name = "pixel\(c)"
                self.addChild(new_pixel)
                pixels.append(new_pixel)
                actions.append(SKAction.run(fade_in, onChildWithName: new_pixel.name!))
                if serial {
                    actions.append(SKAction.wait(forDuration: 0.5))
                }
                c += 1
            }
            self.drawingFlag = 1
            self.run(SKAction.sequence(actions), completion: {self.drawingFlag = 0})
        }
        test_selected = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
