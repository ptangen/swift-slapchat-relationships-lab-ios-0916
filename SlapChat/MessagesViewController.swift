//
//  MessagesViewController.swift
//  SlapChat
//
//  Created by Paul Tangen on 11/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView2: UITableView!
    var recipient1: Recipient!
    
    @IBAction func onClickAddButton(_ sender: Any) {
        performSegue(withIdentifier: "openAddMessage", sender: self)   //segue.destination as! AddMessageViewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! AddMessageViewController
        destinationViewController.recipient1 = self.recipient1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView2.delegate = self
        self.tableView2.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView2.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tvArray = recipient1.messages?.allObjects as! [Message]
        return tvArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        let tvArray = recipient1.messages?.allObjects as! [Message]
        cell.textLabel?.text = tvArray[indexPath.row].content
        return cell
    }

}
