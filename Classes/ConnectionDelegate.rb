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
			NSLog error_nodes.first.stringValue
			@status_indicator.change_status error_nodes.first.stringValue.gsub(" and", "")[0..-2]
		end
	
	end
end