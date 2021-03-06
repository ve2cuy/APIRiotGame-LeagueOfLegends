//
//  ViewController+UITableViewDataSource.swift
//  APIRiotGame-LeagueOfLegends
//
//  Created by Alain on 17-11-20.
//  Copyright © 2017 Alain. All rights reserved.
//

import UIKit

// *****************************************************
extension ViewController : UITableViewDataSource {

    // MARK:- Méthodes du protocole UITableViewDataSource
    // *****************************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Pour contourner les limites de l'API (max 10 requêtes par minute)
        return tableauPersonnages.count > RIOT_API_MAX_REQUEST ? RIOT_API_MAX_REQUEST : tableauPersonnages.count
    } // tableView numberOfRowsInSection
    
    // *****************************************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celluleCourante = UITableViewCell()
        celluleCourante.textLabel?.text = tableauPersonnages[indexPath.row].name
        // Solution bloquante pour l'image
        let strURL = "https://ddragon.leagueoflegends.com/cdn/7.10.1/img/champion/" + (tableauPersonnages[indexPath.row].image?.full)!
        
        if let _url = URL(string: strURL) {
            // Obtenir l'image à partir d'une URL
            do {
                let _data = try Data(contentsOf: _url, options: Data.ReadingOptions.alwaysMapped)
                celluleCourante.imageView?.image = UIImage(data: _data)
            } // do, try
            catch  {
                print("Ligne \(#line), \(error), ### Exception: Problème avec les données à: \(strURL)")
            } // do, try, catch
        } // if let _url
        
        return celluleCourante
    } // tableView cellForRowAt

} // extension ViewController : UITableViewDataSource
