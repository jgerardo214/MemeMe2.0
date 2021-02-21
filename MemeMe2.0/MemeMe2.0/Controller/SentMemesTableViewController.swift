//
//  MemeTableViewController.swift
//  MemeMe2.0
//
//  Created by Jonathan Gerardo on 2/13/21.
//
import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController  {
    
    var memes: [Meme] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var memeTableView: SentMemesTableViewController!
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        memes = appDelegate.memes
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        

        
    }
    
    // TODO: viewWillAppear code is needed
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: Table View Data Source
    
    // implement the code for showing the memes in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell", for: indexPath) as! TableViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.SentMemeTableView?.image = meme.memedImage
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    
    
}

