//
//  ViewController.swift
//  TouchIdDemo
//
//  Created by Ben-Hur Santos Ott on 08/10/17.
//  Copyright © 2017 Emerald. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.authenticateWithTouchId()
    }
    
    private func authenticateWithTouchId() {
        let context = LAContext()
        var errorPointer: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &errorPointer) {
            self.requestTouchIdValidation(usingContext: context)
        }
        else {
            // handle not available touchid
        }
    }
    
    private func requestTouchIdValidation(usingContext context: LAContext) {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login using touch ID?") { (success, error) in
            
            if success {
                DispatchQueue.main.async {
                    // CONGRATULATIONS: handle success authentication =)
                }
            }
            else {
                let error = error as! LAError
                
                switch error.code {
                case LAError.authenticationFailed:
                    // failed to provide valid credentials
                    break
                case LAError.userCancel:
                    // canceled by the user
                    break
                case LAError.userFallback:
                    // canceled, fallback button tapped
                    break
                case LAError.touchIDNotEnrolled:
                    // no enrolled fingers
                    break
                case LAError.biometryNotEnrolled:
                    // same of LAError.touchIDNotEnrolled, but for ios 11+
                    break
                case LAError.passcodeNotSet:
                    // passcode not set on device
                    break
                case LAError.systemCancel:
                    // canceled by the system
                    break
                default:
                    // other
                    break
                }
            }
        }
    }
}

