if [ "`git -C ~/.murmurbox/ remote get-url origin 2>&1`" != "https://github.com/murmurlab/scripts.git" ]; then 
    (
        rm -rf ~/.murmurbox &> /dev/null;
        git clone https://github.com/murmurlab/scripts.git ~/.murmurbox &> /dev/null;
        # bash ~/.murmurbox/murmurbox.bash u
    );
else
    (
        git -C ~/.murmurbox/ fetch &> /dev/null;
        git -C ~/.murmurbox/ reset --hard origin/master &> /dev/null;
        git -C ~/.murmurbox/ switch master &> /dev/null;
        # bash ~/.murmurbox/murmurbox.bash u;
    );
fi

murmur() {
    if [ "`git -C ~/.murmurbox/ remote get-url origin 2>&1`" != "https://github.com/murmurlab/scripts.git" ]; then 
        (
            rm -rf ~/.murmurbox &> /dev/null;
            git clone https://github.com/murmurlab/scripts.git ~/.murmurbox &> /dev/null;
            # bash ~/.murmurbox/murmurbox.bash u
        );
    else
        (
            if [ -z $DEV ]
            then
                git -C ~/.murmurbox/ fetch &> /dev/null;
                git -C ~/.murmurbox/ reset --hard origin/master &> /dev/null;
                git -C ~/.murmurbox/ switch master &> /dev/null;
            fi
            # bash ~/.murmurbox/murmurbox.bash u;
        );
    fi; bash ~/.murmurbox/murmurbox.bash $@
}
