class ProjectSettings
	def initialize
		@defaults = NSUserDefaults.standardUserDefaults
	end
	
	def [](key)
		@defaults[key]
	end
	
	def []=(key,value)
		@defaults[key]=value
		value
	end
	
	
end