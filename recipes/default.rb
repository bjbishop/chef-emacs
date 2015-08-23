# railway's isn't working right now

# homebrewalt_tap "railwaycat/emacsmacport"
# package "emacs-mac"

# using default homebrew
package "emacs"

execute "Turn off Mac keybind 'Control-Command-D'" do
  action :run
  command "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'"
  user node['current_user']
end

Chef::Log.info "#{cookbook_name}: A reboot is needed for the Mac keybind to take effect."
