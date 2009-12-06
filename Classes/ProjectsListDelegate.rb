#
#  ProjectsListDelegate.rb
#  IntegrityX
#
#  Created by Thilo on 13.7.09.
#  Copyright (c) 2009 Upstream Agile GmbH. All rights reserved.
#
framework 'AppKit'


class ProjectsListDelegate
	attr_reader :available_projects
	attr_writer :settings
	attr_writer :menu
		
	def awakeFromNib
		@available_projects = @settings["AvailableProjects"] || []
		initialize_menu_items
	end
	
	def numberOfRowsInTableView(tableView)
		@available_projects.size
	end
  
  def tableView(tableView, willDisplayCell:cell, forTableColumn:tableColumn, row:row)
    cell.setTitle(@available_projects[row])
  end
  
	def tableView(tableView, objectValueForTableColumn:column, row:row)
		NSLog("Asked for row: #{row} column: #{column}")
		if row < (numberOfRowsInTableView -1)
			NSLog("search for #{@available_projects[row]} in #{selected_projects.inspect}")
			return selected_projects.include?(@available_projects[row]) ? NSOnState : NSOffState
		end
		nil
	end
	
	def tableView(tableView, shouldTrackCell:cell, forTableColumn:tableColumn, row:row)
	  if cell.state == NSOffState
	    add_selected_project(cell.title)
    else
      remove_selected_project(cell.title)
    end
    true
  end
	
	def selected_projects
		if @settings["SelectedProjects"]
		  @selected_projects ||= Array.new(@settings["SelectedProjects"])
	  else
	    @selected_projects ||= []
    end
  end
  
  def add_selected_project(name)
    selected_projects << name
    NSLog("add #{name}")
    update_selected_projects
    NSLog("Saved #{@settings["SelectedProjects"].inspect}")
		add_menu_item name
  end
	
	
	def initialize_menu_items
		selected_projects.each do |name| 
			add_menu_item(name)
		end
	end
	
	def add_menu_item(name)
		project_item = NSMenuItem.new
		project_item.title = name
		project_item.setOnStateImage(status_image("icon-success.png"))
		project_item.setOffStateImage(status_image("icon-failure.png"))
		project_item.state = NSOnState
		@menu.addItem(project_item)
	end
	
	def remove_menu_item(name)
		p 'remove menu item'
		project_item_index = @menu.indexOfItemWithTitle(name)
		@menu.removeItemAtIndex(project_item_index)
	end
  
  def remove_selected_project(name)
    NSLog("remove #{name}")
    selected_projects.delete(name)
		update_selected_projects
		remove_menu_item(name)
		NSLog("Saved #{NSUserDefaults.standardUserDefaults.objectForKey("SelectedProjects")}")
  end
	
	def update_selected_projects
		@settings["SelectedProjects"] = selected_projects
	end
	
	def status_image(file_name)
		bundle = NSBundle.mainBundle
		image = bundle.pathForImageResource(file_name)
		NSImage.alloc.initByReferencingFile(image)
	end


end
