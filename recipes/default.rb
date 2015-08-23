homebrewalt_tap "railwaycat/emacsmacport"

package "emacs-mac"

execute "Turn off Mac keybind 'Control-Command-D'" do
  action :run
  command "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'"
  user node['current_user']
end
