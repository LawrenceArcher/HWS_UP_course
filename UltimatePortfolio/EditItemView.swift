//
//  EditItemView.swift
//  UltimatePortfolio
//
//  Created by Lawrence Archer on 11/10/2022.
//

import SwiftUI

struct EditItemView: View {
    let item: Item
    
    @EnvironmentObject var dataController: DataController
    
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    
    init(item: Item) {
        self.item = item
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Basic Settings")) {
                TextField("Item name", text: $title.onChange(update))
                TextField("Description", text: $detail.onChange(update))
            }
            
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Toggle("Mark completed", isOn: $completed.onChange(update))
            }
        }
        .navigationTitle("Edit item")
        .onDisappear(perform: dataController.save) // save to storage once we're done editing
        // Paul Hudson way is creating an extension - here it's Binding-OnChange
        
        // this essentially is the official way that SwiftUI wants us to do this change
//        .onChange(of:title) {_ in update() } // essentially because on change has to pass on a value in a closure we call this this way in the code. Update doens't actually give a shit as it's updating everything anyway
//        .onChange(of:detail) {_ in update() }
//        .onChange(of:priority) {_ in update() }
//        .onChange(of:completed) {_ in update() }
        
    }
    
    func update() {
        item.project?.objectWillChange.send()
        
        item.title = title
        item.detail = detail
        item.priority = Int16(priority)
        item.completed = completed
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
