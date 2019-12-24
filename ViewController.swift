//
//  ViewController.swift
//  Test
//
//  Created by Сергей Дорошенко on 23.12.2019.
//  Copyright © 2019 Сергей Дорошенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    
    @IBOutlet weak var undoButton: UIButton!
    
    @IBOutlet var colorButtons: [UIButton]!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.frame = view.frame
        canvas.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        view.addSubview(canvas)
        
        canvas.addSubview(undoButton)
        canvas.addSubview(resetButton)
        canvas.addSubview(slider)
        colorButtons.forEach{canvas.addSubview($0) }
    }
    
    @IBAction func touchUndoButton(_ sender: UIButton) {
        guard !canvas.lines.isEmpty else { return }
        canvas.lines.removeLast()
        canvas.setNeedsDisplay()
    }
    
    @IBAction func touchResetButton(_ sender: UIButton) {
        canvas.lines.removeAll()
        canvas.setNeedsDisplay()
    }
    
    var strokeWidth: CGFloat = 5.0
    var color: CGColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    
    @IBAction func touchSlider(_ sender: UISlider) {
        strokeWidth = CGFloat(sender.value)
    }
    
    
    @IBAction func touchColorButton1(_ sender: UIButton) {
        color = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
    }
    
    @IBAction func touchColorButton2(_ sender: UIButton) {
        color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
    
    @IBAction func touchColorButton3(_ sender: UIButton) {
        color = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        if !canvas.lines.isEmpty {
            canvas.lines[canvas.lines.count - 1].points += [point]
        }
        
        canvas.setNeedsDisplay()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        let newLine = Line(color: color, strokeWidth: strokeWidth, points: [point])
        canvas.lines += [newLine]
        canvas.setNeedsDisplay()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let prevWidth = view.bounds.width
        let prevHeight = view.bounds.height
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            self?.canvas.frame = self?.view.frame ?? CGRect.zero
            self?.view.addSubview(self?.canvas ?? UIView())
            self?.canvas.setNeedsDisplay()
            let numberOfLines = self?.canvas.lines.count ?? 0
            for i in 0..<numberOfLines {
                for j in 0..<(self?.canvas.lines[i].points.count)! {
                    let x = self?.canvas.lines[i].points[j].x ?? 0
                    let y = self?.canvas.lines[i].points[j].y ?? 0
                    self?.canvas.lines[i].points[j] = CGPoint(x: x * (self?.view.bounds.width ?? 0) / prevWidth, y: y * (self?.view.bounds.height ?? 0) / prevHeight)
                }
            }
        }
    }
    
}

