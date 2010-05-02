require "rubygems"
require "rake"

require "choctop"

ChocTop.new do |s|
  # Remote upload target (set host if not same as Info.plist['SUFeedURL'])
  s.host     = 'www-data@freaklikeme.de'
  s.remote_dir = '/var/www/sites/freaklikeme.de/pub/res'
  s.build_target = 'Release'

  # Custom DMG
  # s.background_file = "background.jpg"
  # s.app_icon_position = [100, 90]
  # s.applications_icon_position =  [400, 90]
  # s.volume_icon = "dmg.icns"
  # s.applications_icon = "appicon.icns" # or "appicon.png"
end
