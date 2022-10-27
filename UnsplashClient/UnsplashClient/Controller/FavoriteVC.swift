//
//  FavoriteVC.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 2.10.22.
//

import UIKit
import RealmSwift

class FavoriteVC: UIViewController {
    
    lazy var layout: FavoriteVCLayout = .init()
    let realm = try! Realm()
    var savedPhotos = [PhotoModel]()
    
    
    override func loadView() {
        super.loadView()
        view = layout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        configureNavBar()
        loadPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPhotos()
        DispatchQueue.main.async {
            self.layout.tableView.reloadData()
        }
    }
    
    func setDelegates() {
        layout.tableView.delegate = self
        layout.tableView.dataSource = self
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    func loadPhotos() {
        let photosFromDB = realm.objects(PhotoModel.self)
        savedPhotos.removeAll()
        if(!photosFromDB.isEmpty) {
            for photo in photosFromDB {
                savedPhotos.append(photo)
            }
            layout.tableView.reloadData()
        }
    }
       
    
}

//MARK: - Extensions for managing TableView methods
extension FavoriteVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell
        let savedPhoto = savedPhotos[indexPath.row]
        cell.setData(with: savedPhoto)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dc = DetailedVC()
        let savedPhoto = savedPhotos[indexPath.row]
        dc.photoObject = savedPhoto
        if savedPhoto.downloads == nil {
            dc.fromSearchCollection = true
        }
        dc.layout.photoView.loadImageFromURL(savedPhoto.regularPhoto)
        dc.navigationController?.navigationBar.isTranslucent = false
        navigationController?.pushViewController(dc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
           if editingStyle == .delete {
               let photoToDelete = savedPhotos[indexPath.row]
               try! realm.write({
                   realm.delete(photoToDelete)
                   savedPhotos.remove(at: indexPath.row)
                   layout.tableView.deleteRows(at: [indexPath], with: .fade)
               })
           }
        
       }
    
}
