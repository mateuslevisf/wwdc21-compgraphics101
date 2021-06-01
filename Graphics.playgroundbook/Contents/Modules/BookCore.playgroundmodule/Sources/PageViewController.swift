//
//  Page1ViewController.swift
//  BookCore
//
//  Created by Mateus Fernandes on 09/04/21.
//

import UIKit
import SpriteKit
import PlaygroundSupport

class PageViewController: LiveViewController {
    
    public var scene: SKScene?
    public var page: Int!
    
    convenience init(page: Int) {
        self.init()
        self.page = page
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SKView(frame: view.bounds)
        
        if let view = self.view as! SKView? {
            var scene: SKScene!
            let size: CGSize = CGSize(width: view.frame.size.width*2.0, height: view.frame.size.height*2.0)
            if self.page == 1 {
                scene = PixelScene(size: size, page: 1)
            } else if self.page == 2 {
                scene = PixelScene(size: size, page: 2)
            } else if self.page == 3 {
                scene = ShadersScene(size: size)
            } else if self.page == 4 {
                scene = LightScene(size: size)
            } else if self.page == 5 {
                scene = ConclusionScene(size: size)
            }
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            self.scene = scene
        }
    }
    
    override public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        
        if let scene = self.scene as? PixelDelegate {
            if page == 1 {
                if case let .array(array) = message {
                    var red: CGFloat = 0.0
                    var green: CGFloat = 0.0
                    var blue: CGFloat = 0.0
                    var alpha: CGFloat = 1.0
                    
                    if case let .floatingPoint(r) = array[0] {
                        red = CGFloat(r)
                    }
                    if case let .floatingPoint(g) = array[1] {
                        green = CGFloat(g)
                    }
                    if case let .floatingPoint(b) = array[2] {
                        blue = CGFloat(b)
                    }
                    if case let .floatingPoint(a) = array[3] {
                        alpha = CGFloat(a)
                    }
                    scene.updatePixel(r: red, g: green, b: blue, alpha: alpha)
                }
            } else {
                if case let .string(type) = message {
                    var flag: Bool = false
                    if type == "Serial" {
                        flag = true
                    } else {
                        flag = false
                    }
                    scene.drawSelectedPixels(serial: flag)
                }
            }
        } else if let scene = self.scene as? ShadersDelegate {
            if case let .string(shaderName) = message {
                scene.updateShader(shaderName: shaderName)
            }
        } else if let scene = self.scene as? LightsDelegate {
            if case let .array(array) = message {
                var underwater: Bool = false
                var lightsOn: Bool = false
                
                if case let .boolean(l) = array[1] {
                    lightsOn = l
                }
                if case let .boolean(u) = array[0] {
                    underwater = u
                }
                scene.updateView(lightsOn: lightsOn, underwater: underwater)
            }
        }
    }
}

