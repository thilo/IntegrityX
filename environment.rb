# environment.rb
# IntegrityX
#
# Created by Thilo on 11.5.10.
# Copyright 2010 Upstream-Agile GmbH. All rights reserved.
# Loading the Cocoa framework. If you need to load more frameworks, you can
# do that here too.

# Loading all the Ruby project files.
framework 'Cocoa'

main = File.basename(__FILE__, File.extname(__FILE__))
dir_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
Dir.glob(File.join(dir_path, '*.{rb,rbo}')).map { |x| File.basename(x, File.extname(x)) }.uniq.each do |path|
	p path
	if path != 'rb_main'
    require(path)
  end
end

