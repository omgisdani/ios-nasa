//
//  ViewController.swift
//  nasa
//
//  Created by dani v on 06/11/20.
//

import UIKit
import Alamofire


extension Date {
    static func setDates(forDays x: Int) -> [String] {
        let calendar = NSCalendar.current
        var date = calendar.startOfDay(for: Date())
        var dates = [String]()

        for _ in 1 ... x {
            date = calendar.date(byAdding: Calendar.Component.day, value: -1, to: date)!

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            dates.append(dateString)
        }
        return dates
    }
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let days = Date.setDates(forDays: 100)
    var selectedDate: String = ""
    var indexSel = -1
  
    let APIKey =
        "FXrKJcnIdQTGYLPjdkzpQkcF2BvGNeXWtcKGedmi"
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key="
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hue = 1 / CGFloat(days.count) * CGFloat(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FechaCell
        cell.bg.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 0.15)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
         let celldate = dateFormatter.date(from: days[indexPath.row])
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let newdate = dateFormatter.string(from: celldate!)
        cell.dateLabel.text = newdate
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSel = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "seeDetail", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
           if(segue.identifier == "seeDetail"){
               let destination:SingleController = segue.destination as! SingleController
            
            let seldate = days[indexSel]
           
            func sendRequest(completion: @escaping ((Bool) -> Void)) {
                let request = AF.request(apiURL + APIKey + "&date=" + seldate).responseJSON { response in
                        debugPrint(response)
                    switch response.result {
                                    case .success(let value):
                                        if let responseJSON = value as? [String: Any] {
                                            destination.name = responseJSON["title"] as! String
                                       
                                            destination.desc = responseJSON["explanation"] as! String
                                             let img = responseJSON["url"] as! String
                                            print(img)
                                            destination.img = img
                
                                           // destination.imgURL = URL(string: img)!
                                         
                                          //  self.imageView.kf.setImage(with: imgURL)
                                            completion(true)
                                           
                                        }
                                    case .failure(let error):
                                        completion(false)
                                        break
                                        // error handling
                                    }
                 
                    }
            }
            
            sendRequest(completion: {(sucess) in
                if(sucess){
                    print("yay")
                   // self.removeSpinner()
                }
            })
           }
               
        }

}

