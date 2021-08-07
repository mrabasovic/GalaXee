//
//  ViewController.swift
//  Galaxy
//
//  Created by mladen on 7.8.21..
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var datum: UILabel!
    @IBOutlet weak var changePicButton: UIButton!
    @IBOutlet weak var explanationTxt: UILabel!
    
    //var date : String = ""
    //var img: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callApi(godina: "", mesec: "", dan: "")
    }
    
    func callApi(godina: String, mesec: String, dan: String){
        var nm = NetworkingManager()
        nm.sendDataDelegate = self
        nm.fetchData(year: godina, month: mesec, day: dan)
        
    }

    @IBAction func changeImagePressed(_ sender: UIButton) {
        
        let yearRandom = Int.random(in: 2000...2021)
        let monthRandom = Int.random(in: 1...12)
        var dayRandom : Int
        
        if monthRandom == 2 && yearRandom % 4 == 0{
            dayRandom = Int.random(in: 1...29)
        }
        else if monthRandom == 2 && yearRandom % 4 != 0{
            dayRandom = Int.random(in: 1...28)
        }else if monthRandom % 2 == 1{
            dayRandom = Int.random(in: 1...31)
        }else{
            dayRandom = Int.random(in: 1...30)
        }
        
        let god = String(yearRandom)
        let mes = String(monthRandom)
        let d = String(dayRandom)
        
        callApi(godina: god, mesec: mes, dan: d)
    }
    
   
    
}

extension ViewController : apiDelegate{
    
    func sendData(date: String, image: String, explanation: String) {
        DispatchQueue.main.async {
            let url = URL(string: image)
            let data = try? Data(contentsOf: url!)
            let explanation = explanation
            
            self.imgView.image = UIImage(data: data!)
            self.explanationTxt.text = explanation
            self.datum.text = date
        }
        
    }
    
    
}




