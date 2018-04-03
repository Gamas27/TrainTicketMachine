//
//  SearchStationsWorker.swift
//  TrainTicketMachine
//
//  Created by João Gameiro on 28/03/18.
//  Copyright (c) 2018 JG.com. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class SearchStationsWorker {
    func fetchStationsList() -> [Station] {
        return [Station(stationId: 1, name: "LIVERPOOL", location: "LIVERPOOL"),
                Station(stationId: 2, name: "LONDON", location: "LONDON"),
                Station(stationId: 3, name: "MANCHESTER", location: "MANCHESTER"),
                Station(stationId: 4, name: "CORNWALL", location: "CORNWALL"),
                Station(stationId: 5, name: "BRISTOL", location: "BRISTOL"),
                Station(stationId: 6, name: "BRIGHTON", location: "BRIGHTON"),
                Station(stationId: 7, name: "TOWER HILL", location: "TOWER HILL"),
                Station(stationId: 8, name: "TOWER MILL", location: "TOWER MILL")]
    }
}
