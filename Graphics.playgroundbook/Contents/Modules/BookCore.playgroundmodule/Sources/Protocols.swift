//
//  Protocols.swift
//  BookCore
//
//  Created by Mateus Fernandes on 12/04/21.
//

import Foundation
import SpriteKit

protocol PixelDelegate {
    func updatePixel(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat)
    func drawSelectedPixels(serial: Bool)
}

protocol ShadersDelegate {
    func updateShader(shaderName: String)
}

protocol LightsDelegate {
    func updateView(lightsOn: Bool, underwater: Bool)
}
