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
		@theItem.setTitle "Loading..."
	end
	
	def change_status(state)
	 @theItem.setTitle(state)
	end
	
	def change_status(state, forProject:name)
		p "change status for #{name} to #{state}"
		project_item_index = @menu.indexOfItemWithTitle(name)
		menu_item = @menu.itemAtIndex(project_item_index)
		if menu_item
			menu_item.state = state.include?('success') ? NSOnState : NSOffState
		end
	end
	
end
