doorbell_cat(){
	(
	if [ "$USER" == 'ahmbasar' ]; then # :D
		exit 0;
	fi
	if [ $(uname -s) == "Linux" ]; then
		xdg-open https://i1.sndcdn.com/artworks-CRPdY5qe2qqO4kDy-9FQlyw-t1080x1080.jpg&
		firefox -new-window https://i1.sndcdn.com/artworks-CRPdY5qe2qqO4kDy-9FQlyw-t1080x1080.jpg&
		firefox -new-window https://i1.sndcdn.com/artworks-CRPdY5qe2qqO4kDy-9FQlyw-t1080x1080.jpg&
		firefox -new-window https://i1.sndcdn.com/artworks-CRPdY5qe2qqO4kDy-9FQlyw-t1080x1080.jpg&
		firefox -new-window https://i1.sndcdn.com/artworks-CRPdY5qe2qqO4kDy-9FQlyw-t1080x1080.jpg&
		firefox -new-window https://i1.sndcdn.com/artworks-CRPdY5qe2qqO4kDy-9FQlyw-t1080x1080.jpg&
	fi
	) &>/dev/null
}
