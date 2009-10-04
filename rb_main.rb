#
# rb_main.rb
# ExceptionalX
#
# Created by Thilo on 9.10.08.
# Copyright __MyCompanyName__ 2008. All rights reserved.
#

# Loading the Cocoa framework. If you need to load more frameworks, you can
# do that here too.
framework 'Cocoa'
framework 'AppKit'

# Loading all the Ruby project files.
dir_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
Dir.entries(dir_path).each do |path|
  if path != File.basename(__FILE__) && !path.include?('Vendor') && !path.include?('Spec') && path[-3..-1] == '.rb'
    require(path)
  end
end


# Starting the Cocoa main loop.

app = NSApplicationMain(0, nil)