# PreferencePanel.rb
# IntegrityX
#
# Created by Thilo on 2.5.10.
# Copyright 2010 Upstream-Agile GmbH. All rights reserved.

class PreferencePanel < NSPanel
	def makeActiveAndOrderFront(sender)
		NSApp.activateIgnoringOtherApps(true)
		makeKeyAndOrderFront(sender)
	end
	
end
