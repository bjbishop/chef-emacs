include_recipe "duplicity::default"

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

Chef::Log.warn "#{cookbook_name}: A reboot is needed for the Mac keybind to take effect.\n\n"

passwd = ::File.readlines(::File.join(::Dir.home(node['current_user']), '.box'))[1].chomp

duplicity_restore "Restore folder .emacs.d into ~/.emacs.d" do
  restore_item ".emacs.d"
  local_path ::File.join(::Dir.home(node["current_user"]), ".emacs.d")
  remote_path node["duplicity"]["webdav_remote"]
  restore_as_user node['current_user']
  restore_as_group node['current_user']
  remote_path_password passwd
  encryption_password passwd
  # If restoring files from a backup using a different UID,
  # use the option: --ignore-errors
  duplicity_options [
    "--no-print-statistics",
    "--numeric-owner",
  ]
  not_if { ::Dir.exists?(::File.join(::Dir.home(node["current_user"]), ".emacs.d")) }
end
