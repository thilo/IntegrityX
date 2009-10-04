class ProjectSettings
	def initialize
		@defaults = NSUserDefaults.standardUserDefaults
	end
	
	def [](key)
		@defaults.objectForKey key
	end
	
	def []=(key,value)
		@defaults.setObject value, forKey: key
		value
	end
	
	
end