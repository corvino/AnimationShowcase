//
//  BoxViewController.swift
//  AnimationShowcase
//
//  Created by Nathan Corvino on 8/17/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

import Cocoa

class BoxViewController: NSViewController {

    @IBOutlet weak var canvasView: NSView!
    @IBOutlet weak var buttonBarView: NSView!

    @IBOutlet weak var boxCheckbox: NSButton!
    @IBOutlet weak var openCheckbox: NSButton!
    @IBOutlet weak var showZCheckbox: NSButton!
    @IBOutlet weak var persepectiveCheckbox: NSButton!

    var canvasSubLayer = CALayer()
    var side1 = CALayer()
    var side2 = CALayer()
    var side3 = CALayer()
    var side4 = CALayer()
    var side5 = CALayer()
    var side6 = CALayer()

    var perspective = CATransform3DIdentity
    var orientation = CATransform3DIdentity
    var startingRotation = CATransform3DIdentity


    override func viewDidLoad() {
        super.viewDidLoad()

        // Homogeneous perspective transform
        perspective.m34 = -1.0 / 500.0
    }

    override func viewWillAppear() {
        super.viewDidAppear()

        if (nil == side1.superlayer) {
            view.layer?.backgroundColor = NSColor.blackColor().CGColor
            canvasSubLayer.frame = canvasView.bounds

            buttonBarView.layer?.backgroundColor = NSColor.whiteColor().CGColor

            let boxSize = CGSize(width: 100, height: 100)
            side1.backgroundColor = NSColor.orangeColor().CGColor
            side1.borderWidth = 2
            side1.borderColor = NSColor.whiteColor().CGColor
            side1.bounds = CGRect(origin: CGPointZero, size: boxSize)
            side1.anchorPoint = CGPoint(x: 1, y: 0.5)
            addTextToSide("1", box: side1)

            side2.backgroundColor = NSColor.greenColor().CGColor
            side2.borderWidth = 2
            side2.borderColor = NSColor.whiteColor().CGColor
            side2.bounds = CGRect(origin: CGPointZero, size: boxSize)
            side2.anchorPoint = CGPoint(x: 0, y: 0.5)
            addTextToSide("2", box: side2)

            side3.backgroundColor = NSColor.blueColor().CGColor
            side3.borderWidth = 2
            side3.borderColor = NSColor.whiteColor().CGColor
            side3.bounds = CGRect(origin: CGPointZero, size: boxSize)
            side3.anchorPoint = CGPoint(x: 0.5, y: 1)
            addTextToSide("3", box: side3)

            side4.backgroundColor = NSColor.cyanColor().CGColor
            side4.borderWidth = 2
            side4.borderColor = NSColor.whiteColor().CGColor
            side4.bounds = CGRect(origin: CGPointZero, size: boxSize)
            side4.anchorPoint = CGPoint(x: 0.5, y: 0)
            addTextToSide("4", box: side4)

            side5.backgroundColor = NSColor.brownColor().CGColor
            side5.borderWidth = 2
            side5.borderColor = NSColor.whiteColor().CGColor
            side5.bounds = CGRect(origin: CGPointZero, size: boxSize)
            side5.anchorPoint = CGPoint(x: 0.5, y: 0)
            addTextToSide("5", box: side5)

            side6.backgroundColor = NSColor.redColor().CGColor
            side6.borderWidth = 2
            side6.borderColor = NSColor.whiteColor().CGColor
            side6.bounds = CGRect(origin: CGPointZero, size: boxSize)
            addTextToSide("6", box: side6)

            let canvasCenter = CGPoint(x: canvasView.bounds.size.width / 2, y: canvasView.bounds.size.height / 2)
            side1.position = CGPoint(x: canvasCenter.x - 50, y: canvasCenter.y)
            side2.position = CGPoint(x: canvasCenter.x + 50, y: canvasCenter.y)
            side3.position = CGPoint(x: canvasCenter.x, y: canvasCenter.y - 50)
            side4.position = CGPoint(x: canvasCenter.x, y: canvasCenter.y + 50)
            side5.position = CGPoint(x: canvasCenter.x, y: canvasCenter.y - 50)
            side6.position = CGPoint(x: canvasCenter.x, y: canvasCenter.y)

            canvasView.layer?.addSublayer(canvasSubLayer)
            canvasSubLayer.addSublayer(side1)
            canvasSubLayer.addSublayer(side2)
            canvasSubLayer.addSublayer(side3)
            canvasSubLayer.addSublayer(side4)
            canvasSubLayer.addSublayer(side6)
            canvasSubLayer.addSublayer(side5)

            applySublayerTransform()
        }
    }

    override func viewWillLayout() {
        // The view wants to change this back to true for us.
        canvasView.layer?.masksToBounds = false
    }

    func addTextToSide(string : String, box : CALayer) {
        let layer = CATextLayer()
        let bounds = string.boundingRectWithSize(CGSize(width: 100, height: 100), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : layer.font])
        layer.string = string
        layer.frame = bounds

        layer.position = CGPoint(x: box.bounds.size.width / 2, y: box.bounds.size.height / 2)
        box.addSublayer(layer)
    }

    func degreesToRadians(degrees: Double) -> Double {
        return degrees * 2 * M_PI / 360
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
        }
    }

    @IBAction func openCheckboxChanged(sender: AnyObject) {
        if (NSOnState == openCheckbox.state) {
            side5.transform = CATransform3DMakeRotation(CGFloat(degreesToRadians(90)), 1, 0, 0)
        } else {
            side5.transform = CATransform3DIdentity
        }
    }

    @IBAction func showZCheckboxChanged(sender: AnyObject) {
        if (NSOnState == showZCheckbox.state) {
            side5.zPosition = 100
        } else {
            side5.zPosition = 0
        }
    }

    @IBAction func perspectiveCheckboxChanged(sender: AnyObject) {
        applySublayerTransform()
    }

    @IBAction func resetButtonPressed(sender: AnyObject) {
        startingRotation = CATransform3DIdentity
        applySublayerTransform()
    }

    @IBAction func didPan(panner: NSPanGestureRecognizer) {
        let disp = panner.translationInView(canvasView)
        let angle = sqrt(disp.x * disp.x + disp.y * disp.y)
        orientation = CATransform3DMakeRotation(CGFloat(degreesToRadians(Double(angle))), -disp.y, disp.x, 0)
        applySublayerTransform()

        if (.Ended == panner.state) {
            startingRotation = CATransform3DConcat(orientation, startingRotation)
            orientation = CATransform3DIdentity
        }
    }

    func applySublayerTransform() {
        let transform = CATransform3DConcat(orientation, startingRotation)

        if (NSOnState == persepectiveCheckbox.state) {
            canvasSubLayer.sublayerTransform = CATransform3DConcat(transform, perspective)
        } else {
            canvasSubLayer.sublayerTransform = transform
        }
    }
}
