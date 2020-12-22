//
//  GameViewController.swift
//  PanRacing
//
//  Created by user on 21/12/2020.
//

import UIKit

class GameViewController: UIViewController {
    
    var gameTimer: Timer!
    var PcTimer: Timer!
    var stateSemafor: Int = 1
    var gameTime: Timer!
    var timeLeft = 0

    @IBOutlet weak var pcCar: UIImageView!
    @IBOutlet weak var userCar: UIImageView!
    @IBOutlet weak var finishLine: UIImageView!
    @IBOutlet weak var semaforLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        userCar.image = UIImage(named: userCarImage)

        // Do any additional setup after loading the view.
    }

    @IBAction func startGameAction(_ sender: UIButton) {
        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(intervalTimer), userInfo: nil, repeats: true)
        
        PcTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(pcDrive), userInfo: nil, repeats: true)
        
        gameTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(game), userInfo: nil, repeats: true)
    }
    
    @IBAction func driveCarAction(_ sender: UIButton) {
        if timerLabel.text != "Timer" {
            if stateSemafor == 2 {
                userCar.center.x += 10
            }
            if stateSemafor == 1 {
                userCar.center.x -= 10
            }
            if userCar.center.x > finishLine.center.x {
                gameEnd(message: "You win")
            }
        }
        
    }
    
    @objc func intervalTimer () {
        stateSemafor += 1
        if stateSemafor > 2 {
            stateSemafor = 1
        }
        
        switch stateSemafor {
        case 1:
            semaforLabel.text = "STOP"
            semaforLabel.textColor = .red
        case 2:
            semaforLabel.text = "GO"
            semaforLabel.textColor = .green
        default:
            break
        }
    }
    
    @objc func pcDrive () {
        if stateSemafor == 2 {
            pcCar.center.x += 10
        }
        if pcCar.center.x > finishLine.center.x {
            gameEnd(message: "You lose")
        }
    }
    
    @objc func game() {
        timeLeft += 1
        timerLabel.text = String(timeLeft)
    }
    
    func gameEnd(message: String) {
        gameTimer.invalidate()
        PcTimer.invalidate()
        gameTime.invalidate()
        let alert = UIAlertController(title: "Game End", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        results.append(resultData(playerName: "me", resultGeme: message, timeGame: String(timeLeft)))
        timerLabel.text = "Timer"
        semaforLabel.text = "SemaforState"
        userCar.center.x = 50
        pcCar.center.x = 50
    }
    

}

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
