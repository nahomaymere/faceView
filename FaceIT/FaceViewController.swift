//
//  ViewController.swift
//  FaceIT
//
//  Created by Nahom Hailu on 27/07/2017.
//  Copyright © 2017 Nahom. All rights reserved.
//

import UIKit


class FaceViewController: UIViewController {
    var expression: FacialExpression = FacialExpression(eyes: .Closed, eyeBrows: .Relaxed, mouth: .Smirk){ didSet{ updateUI() } }
    
    @IBOutlet weak var faceView:FaceView!{
        didSet{
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target:self, action: #selector(FaceViewController.increaseSaddness)
            )
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    @IBAction func toggledEyes(recognizer:  UITapGestureRecognizer){
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open:
                faceView.eyesOpen = false
            case .Closed:
                faceView.eyesOpen = true
            case .Squinting:
                break
            }
        }
   
    }
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func increaseSaddness(){
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0, .Smirk:-0.5, .Neutral:0.0,.Grin:0.5, .Smile:1.0 ]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5, .Furrowed:-0.5, .Normal:0.0 ]
    private func updateUI(){
        if faceView != nil {
            switch expression.eyes {
            case .Open:
                faceView.eyesOpen = true
            case .Closed:
                faceView.eyesOpen = false
            case .Squinting:
                faceView.eyesOpen = false
                
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
            
                
        
    }
    
}

