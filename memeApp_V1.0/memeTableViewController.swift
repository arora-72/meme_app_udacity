//
//  memeTableViewController.swift
//  memeApp_V1.0
//
//  Created by arora_72 on 15/04/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import UIKit

class memeTableViewController: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "sent items"
        
            }
    
    @IBAction func reloadData(_ sender: Any) {
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.memes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let meme = appDelegate.memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        
        print(cell)
       
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let meme = appDelegate.memes[indexPath.row]
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "memeDetailViewController") as! memeDetailViewController
        detail.memeSelected = meme
        navigationController?.pushViewController(detail, animated: true)
        

    }

    
}
