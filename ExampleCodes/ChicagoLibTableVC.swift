//
//  ChicagoLibTableVC.swift
//  ExampleCodes
//
//  Created by boqian cheng on 2017-10-03.
//  Copyright © 2017 boqiancheng. All rights reserved.
//

import UIKit

class ChicagoLibTableVC: UITableViewController {
    
    var libListStruct: [Library] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        netWorkProvider.requestWithProgress(.libInfo).subscribe { [unowned self] event in
            switch event {
            case .next(let response):
                if response.completed {
                    do {
                        if let jsonArray = try response.response?.mapJSON() as? Array<Any> {
                            if jsonArray.count > 0 {
                                for libJSON: [String : Any] in jsonArray as! [[String : Any]] {
                                    let libStruct = Library(object: libJSON)
                                    self.libListStruct.append(libStruct)
                                }
                            }
                        }
                        self.tableView.reloadData()
                    } catch {
                        debugPrint("Mapping Error: \(error.localizedDescription)")
                    }
                }
            case .error(let error):
                debugPrint("Mapping Error: \(error.localizedDescription)")
            default:
                break
            }
        }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.libListStruct.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "librow", for: indexPath)
        
        // Configure the cell...
        
        let theLibStruct = self.libListStruct[indexPath.row]
        cell.textLabel?.text = theLibStruct.name_
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let theLibStruct: Library = self.libListStruct[(indexPath.row)]
                let detaiVC = segue.destination as! LibLocationMapVC
                detaiVC.theLibStruct = theLibStruct
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

}
