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
      @theItem.setTitle "Loading..."
	  @theItem.setHighlightMode true
	end
	
	def awakeFromNib
	  @theItem.setMenu @menu #Set Menu. This should be posible in IB?
	end
	
	def change_status(state)
	 @theItem.setTitle(state)
	end
end
