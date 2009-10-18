class ConnectionDelegate
  
  attr_writer :status_indicator
  
  def connection(connection, didReceiveData:data)
		@receivedData ||= NSMutableData.new
		@receivedData.appendData(data)
  end
	
	def connection(connection, didFailWithError:error)
		NSLog "Connection failed"
	end
	
	def connectionDidFinishLoading(connection)
		NSLog "finished loading"
		doc = NSXMLDocument.alloc.initWithData(@receivedData,
                                           options:NSXMLDocumentTidyHTML,
                                           error:nil)
	  if doc
			get_status(doc)
	  end
	  @receivedData = NSMutableData.new
	end
	
	def get_status(doc)
		NSLog("getting status")
	 	
		
		error_nodes = doc.nodesForXPath('//*[(@id = "last_build")]//h1', error:nil)
		if error_nodes && !error_nodes.empty?
			
			p "got status #{error_nodes.first.stringValue}"
			p "for project #{status_for_project(doc)}"
			@status_indicator.change_status(error_nodes.first.stringValue.gsub(" and", "")[0..-2], forProject: status_for_project(doc))
		end
	
	end
	
	def status_for_project(doc)
		project_name_nodes = doc.nodesForXPath('//*[(@id = "header")]//h1', error:nil)
		unless project_name_nodes.empty?
			project_for_path(project_name_nodes.first.stringValue)
		end
	end
	
	def project_for_path(path)
		path.match(/\/\s*(.+)\n/)[1]
	end
end