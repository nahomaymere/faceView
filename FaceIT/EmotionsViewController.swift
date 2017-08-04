//
//  EmotionsViewController.swift
//  FaceIT
//
//  Created by Nahom Hailu on 03/08/2017.
//  Copyright © 2017 Nahom. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    private let EmotionalFaces : [String: FacialExpression] = [
        "angry": FacialExpression(eyes:.Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy": FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried": FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischivious": FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        var destinationvc = segue.destination
        if let navcon = destinationvc as? UINavigationController{
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        if let facevc = destinationvc as? FaceViewController{
            if let identifier = segue.identifier{
                if let expression = EmotionalFaces[identifier]{
                    facevc.expression = expression
                    if let senderButton = sender as? UIButton {
                        facevc.navigationItem.title = senderButton.currentTitle
                    }
                }
            }
        }
    }
 
}
