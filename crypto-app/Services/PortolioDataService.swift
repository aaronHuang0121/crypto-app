//
//  PortolioDataService.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/27.
//

import CoreData
import Foundation
import os

enum CoreDataService {
    static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "CoreData")
}

final class PortolioDataService {
    static let shared = PortolioDataService()

    private let container: NSPersistentContainer
    private let containerName: String = "PortolioContainer"
    private let entitlyName: String = "PortolioEntity"
    
    @Published var saveEntities: [PortolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                CoreDataService.logger.error("Error loading Core Data. \(error.localizedDescription)")
            }
            self.getPortolios()
        }
    }
    
    func updatePortolio(_ coin: Coin, amount: Double) {
        if let entity = saveEntities.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                update(entity, amount: amount)
            } else {
                delete(entity)
            }
        } else {
            add(coin, amount: amount)
        }
    }
    
}

extension PortolioDataService {
    private func getPortolios() {
        let request = NSFetchRequest<PortolioEntity>(entityName: self.entitlyName)
        
        do {
            self.saveEntities = try container.viewContext.fetch(request)
        } catch let error {
            CoreDataService.logger.error("Error fetch Core Data. \(error.localizedDescription)")
        }
    }
    
    private func add(_ coin: Coin, amount: Double) {
        let entity = PortolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        
        applyChanges()
    }

    private func update(_ entity: PortolioEntity, amount: Double) {
        entity.amount = amount
        
        applyChanges()
    }
    
    private func delete(_ entity: PortolioEntity) {
        container.viewContext.delete(entity)
        
        applyChanges()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            CoreDataService.logger.error("Error save Core Data. \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        self.save()
        self.getPortolios()
    }
}
