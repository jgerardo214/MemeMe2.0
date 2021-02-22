//
//  MemeTableViewController.swift
//  MemeMe2.0
//
//  Created by Jonathan Gerardo on 2/13/21.
//
import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController  {
    
    var memes: [Meme] {
     
            return (UIApplication.shared.delegate as! AppDelegate).memes
     
    }
    
    @IBOutlet var memeTableView: SentMemesTableViewController!
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dimension = (view.frame.size.height / 10)
        tableView.rowHeight = dimension

        
    }
    
 
    
    // TODO: viewWillAppear code is needed
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    
    // MARK: Table View Data Source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        
        cell.imageView?.image = meme.memedImage
        cell.memedLabel?.text = meme.topText
        
        //[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        //cell.textLabel?.text = meme.topText
        return cell
        
    
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    
    
}

