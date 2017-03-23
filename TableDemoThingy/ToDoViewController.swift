//
//  ToDoViewController.swift
//  TableDemoThingy
//
//  Created by Paul Wilkinson on 23/3/17.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var todoItems: [ToDoItem]?
    
    var cellHeights = [IndexPath:CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.rowHeight = UITableViewAutomaticDimension
       // self.tableview.estimatedRowHeight = 40
        
        self.loadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadData()  {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        if let todoURL = URL(string: "https://jsonplaceholder.typicode.com/todos") {
            
            var request = URLRequest(url: todoURL)
            
            request.timeoutInterval = 60.0 // TimeoutInterval in Second
            request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            let dataTask = session.dataTask(with: request) { (data,response,error) in
                if error != nil{
                    return
                }
                if let data = data,
                    let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] {
                    var itemsArray = [ToDoItem]()
                    for entry in json {
                        if let id = entry["id"] as? Int,
                            let text = entry["title"] as? String,
                            let complete = entry["completed"] as? Bool {
                            let newToDo = ToDoItem(done: complete, itemText: text, id: id)
                            itemsArray.append(newToDo)
                        }
                    }
                    DispatchQueue.main.async {
                        self.todoItems = itemsArray
                        self.tableview.reloadData()
                    }
                }
            }
            
            dataTask.resume()
        }
        
    }
}

extension ToDoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.todoItems![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        cell.toDoText.text = item.itemText
        cell.idLabel.text = String(item.id)
        cell.accessoryType = item.done ? .checkmark:.none
        
        return cell
        
    }
    
}

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let frame = tableView.rectForRow(at: indexPath)
        
        self.cellHeights[indexPath] = frame.size.height
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeights[indexPath] ?? 40.0
    }
    
}
