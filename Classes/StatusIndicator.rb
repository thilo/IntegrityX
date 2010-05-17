#
#  StatusIndicator.rb
#  IntegrityX
#
#  Created by Thilo on 1.7.09.
#  Copyright (c) 2009 Upstream Agile GmbH. All rights reserved.
#

class StatusIndicator
	attr_writer :menu
	
	def initialize
	  bar = NSStatusBar.systemStatusBar
	  @theItem = bar.statusItemWithLength NSVariableStatusItemLength
	  @theItem.setHighlightMode true
	end
	
	def awakeFromNib
		@theItem.setMenu @menu #Set Menu. This should be posible in IB?
		show_inactive
	end
	
	def show_no_project
	 p "no projects"
	 p @menu.indexOfItem(no_project_item)
	 @menu.indexOfItem(no_project_item) > -1 || @menu.addItem(no_project_item)
	 p @menu.indexOfItem(NSMenuItem.alloc.initWithTitle('No Projects', action:nil, keyEquivalent: ''))
	 show_inactive
	end
	
	def hide_no_project
		p "some projects"
		@menu.indexOfItem(no_project_item) > -1 && @menu.removeItem(no_project_item)
	end
	
	def show_inactive
		@theItem.setImage(status_image("icon-inactive.png"))
	end
	
	def change_status(state, forProject:name)
		p "change status for #{name} to #{state}"
		project_item_index = @menu.indexOfItemWithTitle(name)
		menu_item = @menu.itemAtIndex(project_item_index)
		if menu_item
			menu_item.state = state.include?('success') ? NSOnState : NSOffState
		end
	end
	
	def status_image(file_name)
		bundle = NSBundle.mainBundle
		image = bundle.pathForImageResource(file_name)
		NSImage.alloc.initByReferencingFile(image)
	end
	
	def no_project_item
		 @no_project_item ||= NSMenuItem.alloc.initWithTitle('No Projects', action:nil, keyEquivalent: '')
	end
	
end
