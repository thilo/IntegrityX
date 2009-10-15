#
#  MainDelegate.rb
#  IntegrityX
#
#  Created by Thilo on 23.5.09.
#  Copyright (c) 2009 Upstream Agile GmbH. All rights reserved.
#

class MainDelegate
	attr_accessor :errors
	attr_writer :connection_delegate
	attr_writer :settings
	
	
	
	def	applicationDidFinishLaunching(notification)
	  @settings
		@current_index ||= 0
	  start_call_loop
	end
	
	def start_call_loop
		timer = NSTimer.scheduledTimerWithTimeInterval 3, target: self, selector: 'request_exception_data:', userInfo: nil, repeats:true
		timer.fire
	end
	
	def request_exception_data(timer)
		
		if @settings["ProjectUrl"] != nil && @settings["SelectedProjects"] != nil && !@settings["SelectedProjects"].empty?
			server_url_part = @settings["ProjectUrl"] # e.g. "http://ci.atonie.org/irc-notifier"
			p next_project_url
			p 'XXXXXXXXXXXXXXX'
			project_url_part = next_project_url
			p "Request update from #{server_url_part + '/' + project_url_part}"
			url = NSURL.URLWithString server_url_part + '/' + project_url_part
			request = NSURLRequest.requestWithURL url
			@connection = NSURLConnection.connectionWithRequest(request, delegate: @connection_delegate)
		end
	end
	
	def next_project_url
		p 'Determin next url'
		project_index =  @current_index % @settings["SelectedProjects"].size
		project_index = 0 if (project_index < 0 || project_index >= @settings["SelectedProjects"].length)
		@current_index = @current_index + 1
		
		@settings["SelectedProjects"][project_index]
	end
end
