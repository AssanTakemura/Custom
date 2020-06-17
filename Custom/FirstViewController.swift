//
//  FirstViewController.swift
//  Custom
//
//  Created by 竹村明日香 on 2020/05/24.
//  Copyright © 2020 Takemura assan. All rights reserved.
//

import UIKit
import RealmSwift
import FSCalendar

class FirstViewController: UIViewController, UNUserNotificationCenterDelegate, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var nitiLabel: UILabel!
    
    var Item: Results<Register>!
    
    let realm = try! Realm()
    let register = try! Realm().objects(Register.self)
    var notificationToken: NotificationToken?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                if granted {
                    print("通知許可")
                    let center = UNUserNotificationCenter.current()
                    center.delegate = self
                } else {
                    print("通知拒否")
                }
            })
        } else {
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        // Do any additional setup after loading the view.
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            register.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddTableViewCell
            cell.customLabel.text = register[indexPath.row].regi
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
            let storyboard: UIStoryboard = self.storyboard!
            let second = storyboard.instantiateViewController(withIdentifier: "second")
            self.present(second, animated: true, completion: nil)
            
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
    }
    
    @IBAction func kiroku(){
        self.performSegue(withIdentifier: "ViewController", sender: nil)
    }
    
    
}


//
//     func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//         self.view.layoutIfNeeded()
//     }
//
//     func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//
//         let formatter = DateFormatter()
//         formatter.dateFormat = "yyyy年MM月dd日"
//         let date = formatter.string(from: date)
//         nitiLabel.text = date
//         let realm = try! Realm()
//         let results = realm.objects(Register.self)
//         for ev in results {
//             if ev.date == date {
//                 Item = realm.objects(Register.self)
//                 let data = AddPlan(timeOne: ev.regi)
//
//             }
//         }
//         tableView.reloadData()
//     }
//
//
