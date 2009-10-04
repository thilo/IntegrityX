require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')

describe "AvailableProjectsConnectionDelegateSpec" do
  
  #can't stub eg "connection:didReceiveData"
  
  describe "connectionDidFinishLoading" do
    before(:each) do
      @project_list_view = NSTableView.new
      @project_list = ProjectsListDelegate.new
      @project_list_view.setDataSource(@project_list)
      @delegate = AvailableProjectsConnectionDelegate.new
      @delegate.project_list_view = @project_list_view
      
    end
    
    
    describe "with valid date" do
      before(:each) do
        @delegate.instance_variable_set(:@receivedData, response)
      end
      
      it "should assign the available projects form the received html to the project list available projects" do
        @delegate.connectionDidFinishLoading("is_not_important")
        @project_list.available_projects.should == ['Bob the Builder','Bob::Test']
      end
      
      it "should call relaoad data if finished" do
        @project_list_view.should_receive(:reloadData)
        @delegate.connectionDidFinishLoading("is_not_important")
      end
    end
    
    describe "with invalid data" do
      before(:each) do
        invalid_response = "<html>empty</html>".dataUsingEncoding NSUTF8StringEncoding
        @delegate.instance_variable_set(:@receivedData, invalid_response)
      end

      it "should not try to add projects" do
        @delegate.connectionDidFinishLoading("is_not_important")
        @project_list.available_projects.should be_empty
      end
      
      it "should call relaoad data if finished" do
        @project_list_view.should_receive(:reloadData)
        @delegate.connectionDidFinishLoading("is_not_important")
      end
    end
    
    it "should reset received data after connection did finish loading"
  end
  
  describe "updateProjectList" do
    it "should empty selected projects if Server Url Changes"
    it "should not empty selected projects if Server Url is unchanged"
  end
  
  def response
    response_string = <<-HTML
    <html lang='en' xml:lang='en' xmlns='http://www.w3.org/1999/xhtml'>
      <head>
        <meta content='text/html; charset=utf-8' http-equiv='Content-Type' />

        <meta content='en' http-equiv='Content-Language' />
        <title>projects | integrity</title>



      </head>
      <body>
        <div id='header'>
          <h1>projects</h1>

            checked with
            <a href='http://integrityapp.com' title='The fun continuous integration server'>integrity</a>


        </div>
        <div id='content'>
          <ul id='projects'>
            <li class='even success'>
              <a href='/bob-the-builder'>Bob the Builder</a>
              <div class='meta'>
                Built ff8484a successfully
              </div>
            </li>

            <li class='odd success'>
              <a href='/bob-test'>Bob::Test</a>
              <div class='meta'>
                Built 3ef1cee successfully
              </div>
            </li>
          </ul>
          <p id='new'>
            <a href='/new'>Add a new project</a>
          </p>
        </div>
        <div id='footer'>
          Hey there!
          <a href='/login'>Log In</a>

          if you have a user
        </div>
      </body>
    </html>
    HTML
    response_string.dataUsingEncoding NSUTF8StringEncoding
    
  end
end

