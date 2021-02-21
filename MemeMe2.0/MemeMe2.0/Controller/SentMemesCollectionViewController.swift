//
//  SentMemesCollectionViewController.swift
//  MemeMe2.0
//
//  Created by Jonathan Gerardo on 2/13/21.
//
import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoWhenInView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
           flowLayout.minimumInteritemSpacing = space
           flowLayout.minimumLineSpacing = space
           flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
        toDoWhenInView()
    }
    
    func toDoWhenInView() {
        memes = appDelegate.memes
        collectionView.reloadData()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as! CollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.SentMemeCollectionImage?.image = meme.memedImage
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    

}

