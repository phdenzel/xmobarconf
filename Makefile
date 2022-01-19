
xmobarconf: XMobarConf.hs
	ghc -i${HOME}/.config/xmonad/lib/ --make -o xmobarconf XMobarConf.hs
	./xmobarconf

install: .xmobarrc
	cp .xmobarrc ~/.config/xmobar/xmobarrc

clean:
	rm -rf *.o *.hi .xmobarrc xmobarconf
