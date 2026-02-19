if [ ! -d "$HOME/.vogsphere" ]; then
	mkdir -p "$HOME/.vogsphere"
	git -C "$HOME/.vogsphere" init --bare
	murlog "creating .vogsphere directory" "$log_file"
	cecho "[murmurbox]: Created .vogsphere directory." "green" "bold"
fi

read -p "Press Enter to continue..."
