# IntegrityX
#
# Created by Thilo on 11.5.10.
# Copyright 2010 Upstream-Agile GmbH. All rights reserved.
require File.expand_path('../spec_helper', __FILE__)

describe "status indicator operations" do
  describe "show_no_projects" do
    it "should add 'No Projects' into the menu" do
      fakeMenu = NSMenu.alloc.initWithTitle('FakeMenu')
      indicator = StatusIndicator.new
      indicator.menu = fakeMenu
      indicator.show_no_project
      p fakeMenu
      p fakeMenu.itemWithTitle('No Projects')
      fakeMenu.indexOfItemWithTitle("No Projects").should.be > -1
    end
  end
end

