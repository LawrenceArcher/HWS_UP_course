//
//  ProjectsView.swift
//  UltimatePortfolio
//
//  Created by Lawrence Archer on 08/10/2022.
//

import SwiftUI

struct ProjectsView: View {
    let showClosedProjects: Bool
    
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
        ], predicate: NSPredicate(format: "closed = %d", showClosedProjects)) // TODO: this could be reused in shoppingList
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in //.wrappedValue ensures we're accessing what's in the fetch request rather than the fetch request itself
                    Section(header: Text(project.title ?? "")) {
                        ForEach(project.items?.allObjects as? [Item] ?? []) { item in
                            Text(item.title ?? "")
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext) //tells SwiftUI what context it works in and allows SwiftUI to read Core Data values
            .environmentObject(dataController) // This allows our own code to read those Core Data values
    }
}
