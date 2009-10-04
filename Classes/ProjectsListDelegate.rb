#
#  ProjectsListDelegate.rb
#  IntegrityX
#
#  Created by Thilo on 13.7.09.
#  Copyright (c) 2009 Upstream Agile GmbH. All rights reserved.
#

class ProjectsListDelegate
	attr_reader :available_projects
	attr_writer :settings
		
	def awakeFromNib
		@available_projects = @settings["AvailableProjects"] || []
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
  end
  
  def remove_selected_project(name)
    NSLog("remove #{name}")
    selected_projects.delete(name)
		update_selected_projects    
		NSLog("Saved #{NSUserDefaults.standardUserDefaults.objectForKey("SelectedProjects")}")
  end
	
	def update_selected_projects
		@settings["SelectedProjects"] = selected_projects
	end

end
