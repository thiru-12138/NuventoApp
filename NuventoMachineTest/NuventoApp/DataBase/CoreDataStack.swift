//
//  CoreDataStack.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "NuventoMachineTest")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData load error: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    // MARK: - Save Device
    func save(_ device: DeviceModel) {
        let entity = DeviceEntity(context: context)
        entity.id = device.id
        entity.name = device.name
        entity.ipAddress = device.ipAddress
        entity.isReachable = device.isReachable

        saveContext()
    }

    // MARK: - Fetch Devices
    func fetchDevices() -> [DeviceModel] {
        let request: NSFetchRequest<DeviceEntity> = DeviceEntity.fetchRequest()
        let entities = (try? context.fetch(request)) ?? []
        return entities.map { $0.toModel() }
    }

    // MARK: - Update Reachability
    func updateReachability(id: UUID, isReachable: Bool) {
        let request: NSFetchRequest<DeviceEntity> = DeviceEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        if let entity = try? context.fetch(request).first {
            entity.isReachable = isReachable
            saveContext()
        }
    }

    // MARK: - Save Context
    private func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}

extension DeviceEntity {
    func toModel() -> DeviceModel {
        DeviceModel(
            id: id ?? UUID(),
            name: name ?? "",
            ipAddress: ipAddress ?? "",
            isReachable: isReachable
        )
    }
}

