//
//  ViewController.swift
//  Box
//
//  Created by Nathan Corvino on 8/15/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

import Cocoa
import AppKit

class BoxViewController: NSViewController {

    @IBOutlet weak var canvasView: NSView!
    @IBOutlet weak var buttonBarView: NSView!

    @IBOutlet weak var boxCheckbox: NSButton!
    @IBOutlet weak var openCheckbox: NSButton!
    @IBOutlet weak var showZ: NSButton!

    var canvasSubLayer = CALayer()
    var side1 = CALayer()
    var side2 = CALayer()
    var side3 = CALayer()
    var side4 = CALayer()
    var side5 = CALayer()
    var side6 = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func addTextToSide(string : String, box : CALayer) {
        let layer = CATextLayer()
        let bounds = string.boundingRectWithSize(CGSize(width: 100, height: 100), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : layer.font])
        layer.string = string
        layer.frame = bounds

        layer.position = CGPoint(x: box.bounds.size.width / 2, y: box.bounds.size.height / 2)
        box.addSublayer(layer)
    }

    override func viewWillAppear() {
        super.viewDidAppear()

        if (nil == side1.superlayer) {
            view.layer?.backgroundColor = NSColor.blackColor().CGColor
            let eyeZ = 500.0
            var perspective = CATransform3DIdentity
            perspective.m34 = -1.0 / CGFloat(eyeZ)
            canvasView.layer?.masksToBounds = false
            canvasView.layer?.sublayerTransform = perspective
            canvasSubLayer.sublayerTransform = perspective

            buttonBarView.layer?.backgroundColor = NSColor.whiteColor().CGColor

            side1.backgroundColor = NSColor.orangeColor().CGColor
            side1.borderWidth = 2
            side1.borderColor = NSColor.whiteColor().CGColor
            side1.frame = CGRect(origin: CGPoint(x: 100, y: 150), size: CGSize(width: 100, height: 100))
            side1.anchorPoint = CGPoint(x: 1, y: 0.5)
            addTextToSide("1", box: side1)

            side2.backgroundColor = NSColor.greenColor().CGColor
            side2.borderWidth = 2
            side2.borderColor = NSColor.whiteColor().CGColor
            side2.frame = CGRect(origin: CGPoint(x: 200, y: 150), size: CGSize(width: 100, height: 100))
            side2.anchorPoint = CGPoint(x: 0, y: 0.5)
            addTextToSide("2", box: side2)

            side3.backgroundColor = NSColor.blueColor().CGColor
            side3.borderWidth = 2
            side3.borderColor = NSColor.whiteColor().CGColor
            side3.frame = CGRect(origin: CGPoint(x: 150, y: 100), size: CGSize(width: 100, height: 100))
            side3.anchorPoint = CGPoint(x: 0.5, y: 1)
            addTextToSide("3", box: side3)

            side4.backgroundColor = NSColor.cyanColor().CGColor
            side4.borderWidth = 2
            side4.borderColor = NSColor.whiteColor().CGColor
            side4.frame = CGRect(origin: CGPoint(x: 150, y: 200), size: CGSize(width: 100, height: 100))
            side4.anchorPoint = CGPoint(x: 0.5, y: 0)
            addTextToSide("4", box: side4)

            side5.backgroundColor = NSColor.brownColor().CGColor
            side5.borderWidth = 2
            side5.borderColor = NSColor.whiteColor().CGColor
            side5.frame = CGRect(origin: CGPoint(x: 150, y: 100), size: CGSize(width: 100, height: 100))
            side5.anchorPoint = CGPoint(x: 0.5, y: 0)
            addTextToSide("5", box: side5)

            side6.backgroundColor = NSColor.redColor().CGColor
            side6.borderWidth = 2
            side6.borderColor = NSColor.whiteColor().CGColor
            side6.frame = CGRect(origin: CGPoint(x: 150, y: 150), size: CGSize(width: 100, height: 100))
            addTextToSide("6", box: side6)

            canvasView.layer?.addSublayer(canvasSubLayer)

            canvasSubLayer.addSublayer(side1)
            canvasSubLayer.addSublayer(side2)
            canvasSubLayer.addSublayer(side3)
            canvasSubLayer.addSublayer(side4)
            canvasSubLayer.addSublayer(side6)
            canvasSubLayer.addSublayer(side5)
        }
    }

    func degreesToRadians(degrees: Double) -> Double {
        return degrees * 2 * M_PI / 360
    }

    override func viewWillLayout() {
        canvasSubLayer.frame = canvasView.bounds
        //canvasSubLayer.frame = CGRect(origin: CGPointZero, size: CGSize(width: 300, height: 300))

//        let canvasCenter = CGPoint(x: canvasView.bounds.size.width / 2 - 150, y: canvasView.bounds.size.height / 2 - 150)
//        side1.position = CGPoint(x: canvasCenter.x - 50, y: canvasCenter.y)
//        side2.position = CGPoint(x: canvasCenter.x + 50, y: canvasCenter.y)
//        side3.position = CGPoint(x: canvasCenter.x, y: canvasCenter.y - 50)
//        side4.position = CGPoint(x: canvasCenter.x, y: canvasCenter.y + 50)
//        side5.position = CGPoint(x: canvasCenter.x, y: canvasCenter.y - 50)
//        side6.position = CGPoint(x: canvasCenter.x, y: canvasCenter.y)
    }

    @IBAction func showZChanged(sender: AnyObject) {
        if (NSOnState == showZ.state) {
            side5.zPosition = 100
        } else {
            side5.zPosition = 0
        }
    }

    @IBAction func boxCheckboxChanged(sender: AnyObject) {
        if (NSOnState == boxCheckbox.state) {
            side1.transform = CATransform3DMakeRotation(CGFloat(degreesToRadians(90)), 0, 1, 0)
            side2.transform = CATransform3DMakeRotation(CGFloat(degreesToRadians(-90)), 0, 1, 0)
            side3.transform = CATransform3DMakeRotation(CGFloat(degreesToRadians(-90)), 1, 0, 0)
            side4.transform = CATransform3DMakeRotation(CGFloat(degreesToRadians(90)), 1, 0, 0)
            side5.zPosition = 100
        } else {
            side1.transform = CATransform3DIdentity
            side2.transform = CATransform3DIdentity
            side3.transform = CATransform3DIdentity
            side4.transform = CATransform3DIdentity
            side5.zPosition = 0
            side6.transform = CATransform3DIdentity
        }
    }

    @IBAction func openCheckboxChanged(sender: AnyObject) {
        if (NSOnState == openCheckbox.state) {
            side5.transform = CATransform3DMakeRotation(CGFloat(degreesToRadians(90)), 1, 0, 0)
        } else {
            side5.transform = CATransform3DIdentity
        }
    }


    @IBAction func didPan(panner: NSPanGestureRecognizer) {
        let disp = panner.translationInView(canvasView)
        if (.Began == panner.state) {
            println("Began: \(disp)")
        } else if (.Changed == panner.state) {
            println("Changed: \(disp)")
        }
        let angle = sqrt(disp.x * disp.x + disp.y * disp.y)
        println("angle: \(angle)")
        let transform = CATransform3DMakeRotation(CGFloat(degreesToRadians(Double(angle))), disp.y, disp.x, 0)
        canvasSubLayer.transform = transform
    }
}
