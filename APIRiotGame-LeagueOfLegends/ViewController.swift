//
//  ViewController.swift
//  APIRiotGame-LeagueOfLegends
//
//  Created by Alain on 17-11-20.
//  Copyright © 2017 Alain. All rights reserved.
//
//  Description: Exemple d'utilisation de l'API de riotgame
//
//  Note: L'API retourne une clé par item.  Il faut donc faire preuve d'imagination
//          pour créer un tableau de 'Champions' à partir de chacune des clés.

import UIKit

class ViewController: UIViewController {

    var tableauPersonnages = Array<Champion>()
    
    // *****************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenirLesDonnéesViaURL()
        print("Il y a \(tableauPersonnages.count) champions dans le tableau")
        afficherLesPersonnages()
    } // viewDidLoad

    // *****************************************************
    func obtenirLesDonnéesViaURL(){
        let url = URL(string: RIOT_API + RIOT_API_KEY)
        if let _data = NSData(contentsOf: url!) as Data? {
            let donnéeJSON = try! JSONSerialization.jsonObject(with: _data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
            if let data = donnéeJSON["data"] as? Dictionary<String, AnyObject>{
                // Créer un tableaux à partir des clés du dictionnaire
                let keys = data.flatMap(){ $0.0 as? String }; //print(keys)
                
                // Pour chaque items dans tableau keys, créer un Champion
                for nomPerso in keys {
                    // Convertir le Dictionnaire (champion) courant en format JSON
                    let jsonData = try! JSONSerialization.data(withJSONObject: data[nomPerso]! /*, options: .prettyPrinted*/ )
                    // Construire un personnage à partir du format JSON courant
                    let perso = try! JSONDecoder().decode(Champion.self, from: jsonData)
                    #if DEBUG
                        // print("Je suis le héro: ", perso.name)
                    #endif
                    // Ajouter le personnage courant au tableau des personnages
                    tableauPersonnages.append(perso)
                    // ajouterTableauPersonnage Personnage(nomPerso)
                } // for nomPerso in keys
                
                
            } // if let data = donnéeJSON["data"]
        } // if let _data = NSData(contentsOf: url
    } // obtenirLesDonnéesViaURL()
    
    // *****************************************************
    func afficherLesPersonnages() {
        for personnage in tableauPersonnages {
             print("Je suis le héro: ", personnage.name)
        } // for personnage
    } // afficherLesPersonnages
    
} // ViewControler

