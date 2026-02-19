if [ ! -d "$HOME/.ssh" ]; then
  mkdir "$HOME/.ssh"
  murlog "creating ~/.ssh directory" "$log_file"
  cecho "[murmurbox]: Created ~/.ssh directory." "green" "bold"
fi
cd "$HOME/.ssh"
if [ ! -f "$HOME/.ssh/ssh_host_rsa_key" ]; then
	ssh-keygen -t rsa -f ssh_host_rsa_key -N ""
	murlog "creating ssh_host_rsa_key" "$log_file"
	cecho "[murmurbox]: Created ssh_host_rsa_key." "green" "bold"
fi
if [ ! -f "$HOME/.ssh/ssh_host_ed25519_key" ]; then
	ssh-keygen -t ed25519 -f ssh_host_ed25519_key -N ""
	murlog "creating ssh_host_ed25519_key" "$log_file"
	cecho "[murmurbox]: Created ssh_host_ed25519_key." "green" "bold"
fi
if [ ! -f "$HOME/.ssh/sshd_config" ]; then
	cat > sshd_config <<EOF
Port 4444
HostKey $HOME/.ssh/ssh_host_rsa_key
HostKey $HOME/.ssh/ssh_host_ed25519_key
PidFile $HOME/.ssh/sshd.pid
#UseIPv6 no
#UsePrivilegeSeparation no
ChallengeResponseAuthentication yes
UsePAM yes
GSSAPIAuthentication yes
GSSAPICleanupCredentials yes
PasswordAuthentication yes
EOF
	murlog "creating sshd_config" "$log_file"
	cecho "[murmurbox]: Created sshd_config." "green" "bold"
fi

# check --user service file
if [ "$os" == "Linux" ]; then
  if [ ! -d "$HOME/.config/systemd/user" ]; then
	mkdir -p "$HOME/.config/systemd/user"
	murlog "creating systemd user directory" "$log_file"
	cecho "[murmurbox]: Created systemd user directory." "green" "bold"
  fi
  if [ ! -f "$HOME/.config/systemd/user/sshd.service" ]; then
	cat > "$HOME/.config/systemd/user/sshd.service" <<EOF
[Unit]
Description=OpenBSD Secure Shell user server
After=network.target auditd.service
#ConditionPathExists=!/etc/ssh/sshd_not_to_be_run

[Service]
#EnvironmentFile=-/etc/default/ssh
ExecStartPre=/usr/sbin/sshd -t -f "$HOME/.ssh/sshd_config"
ExecStart=/usr/sbin/sshd -f "$HOME/.ssh/sshd_config" -h "$HOME/.ssh/ssh_host_rsa_key" -h "$HOME/.ssh/ssh_host_ed25519_key" -D $SSHD_OPTS
ExecReload=/usr/sbin/sshd -t -f "$HOME/.ssh/sshd_config"
ExecReload=/bin/kill -HUP \$MAINPID
KillMode=process
Restart=on-failure
RestartPreventExitStatus=255
Type=notify
#RuntimeDirectory=sshd
#RuntimeDirectoryMode=0755

[Install]
WantedBy=multi-user.target
#Alias=sshd.service
EOF
	murlog "creating systemd user service file" "$log_file"
	cecho "[murmurbox]: Created systemd user service file." "green" "bold"
  fi
fi

if [ "$os" == "Linux" ]; then
	systemctl --user daemon-reload
	systemctl --user enable sshd.service
	systemctl --user start sshd.service
	murlog "started sshd.service" "$log_file"
	cecho "[murmurbox]: SSH server started on port 4444." "green" "bold"
elif [ "$os" == "Darwin" ]; then
	echo "SSH server setup is not supported on macOS in this script. Please set it up manually if needed." >&2
fi

read -p "Press Enter to continue..."
