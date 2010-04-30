#
#  AvailableProjectsConnectionDelegate.rb
#  IntegrityX
#
#  Created by Thilo on 9.7.09.
#  Copyright (c) 2009 Upstream Agile GmbH. All rights reserved.
#

class AvailableProjectsConnectionDelegate
	attr_writer :project_list_view
	attr_writer :settings
		
	def updateProjectList(sender)
		@project_list_view.dataSource.available_projects.clear
		@project_list_view.reloadData
		if @settings["ProjectUrl"]
			NSLog "Delete Selected Projects"
			@settings["SelectedProjects"] = []
			NSLog("Update Project List from #{@settings["ProjectUrl"]}")
			url = NSURL.URLWithString @settings["ProjectUrl"] # "http://builder.integrityapp.com/irc-notifier"
			request = NSMutableURLRequest.requestWithURL url
			NSURLConnection.connectionWithRequest(request, delegate: self)
		end
	end
	
	def connection(connection, didReceiveData:data)
		@receivedData ||= NSMutableData.new
		@receivedData.appendData(data)
	end

	
	def connectionDidFinishLoading(connection)
		NSLog("Received New Project List")
		doc = NSXMLDocument.alloc.initWithData(@receivedData,
                                           options:NSXMLDocumentTidyHTML,
                                           error:nil)
		@receivedData = NSMutableData.new
		get_project_names doc
		@receivedData = NSMutableData.new
	end
	
	def get_project_names(doc)
	 	project_nodes = doc.nodesForXPath('//*[(@id = "projects")]//a', error:nil)
		
		if project_nodes 
		  project_list = []
		  @project_list_view.dataSource.available_projects.clear()
		  project_nodes.each do |project_node|
		    project_list << project_node.stringValue
			@project_list_view.dataSource.available_projects << project_node.stringValue
		  end
		  @settings["AvailableProjects"] = project_list
		  @project_list_view.reloadData
		end
	
	end
end
