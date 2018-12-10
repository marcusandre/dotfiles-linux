install: home sway termite

home:
	stow -R bin git vim zsh

bin:
	mkdir -p ~/bin && \
		stow -t ~/bin -R bin

sway: sway/config
	mkdir -p ~/.config/sway && \
	  stow -t ~/.config/sway -R sway

termite: termite/config
	mkdir -p ~/.config/termite && \
	  stow -t ~/.config/termite -R termite

.PHONY: install bin
