//
//  SparkView.swift
//  AnimationShowcase
//
//  Created by Nathan Corvino on 8/17/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

import Cocoa

class SparkView : NSView {
    var emitter : CAEmitterLayer!
    var cell : CAEmitterCell!

    override func makeBackingLayer() -> CALayer {
        emitter = CAEmitterLayer()

        emitter.frame = self.bounds
        emitter.backgroundColor = NSColor.blackColor().CGColor

        emitter.renderMode = kCAEmitterLayerAdditive
        emitter.emitterPosition = CGPoint(x: CGRectGetMidX(emitter.bounds), y: CGRectGetMidY(emitter.bounds))

        cell = CAEmitterCell()
        cell.contents = CGImageNamed("spark.png")
        cell.birthRate = 150
        cell.lifetime = 5.0
        cell.color = NSColor(red: 1, green: 0.5, blue: 0.2, alpha: 1.0).CGColor
        cell.alphaSpeed = -0.4
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionRange = CGFloat(M_PI * 2)

        emitter.emitterCells = [cell]

        return emitter
    }

    override func layoutSublayersOfLayer(layer: CALayer!) {
        emitter.emitterPosition = CGPoint(x: CGRectGetMidX(emitter.bounds), y: CGRectGetMidY(emitter.bounds))
        cell.velocity = emitter.bounds.size.height / 5
        cell.birthRate = Float(emitter.bounds.size.height / 3 * 2)
    }

    override func setFrameSize(newSize: NSSize) {
        super.setFrameSize(newSize)
        emitter.frame = self.bounds
        emitter.emitterPosition = CGPoint(x: CGRectGetMidX(emitter.bounds), y: CGRectGetMidY(emitter.bounds))
    }

    override func setBoundsSize(newSize: NSSize) {
        super.setFrameSize(newSize)
        emitter.frame = self.bounds
        emitter.emitterPosition = CGPoint(x: CGRectGetMidX(emitter.bounds), y: CGRectGetMidY(emitter.bounds))
    }

    func CGImageNamed(name : String) ->CGImageRef {
        let url = NSBundle.mainBundle().URLForResource(name, withExtension: nil)
        let source = CGImageSourceCreateWithURL(url, nil)
        let image = CGImageSourceCreateImageAtIndex(source, 0, nil)
        return image
    }
}