
xmobarconf: XMobarConf.hs
	ghc -i${HOME}/.config/xmonad/lib/ --make -o xmobarconf XMobarConf.hs
	./xmobarconf

install: .xmobarrc
	cp .xmobarrc ~/.config/xmobar/xmobarrc
	cp .xmobarrc ../xmobarrc

install2: .xmobarrc
	cp .xmobarrc ~/.config/xmobar/xmobarrc
	cp .xmobarrc ~/.config/xmobar/xmobarrc2
	sed -i 's/%trayerpad%//g' ~/.config/xmobar/xmobarrc2
	cp ~/.config/xmobar/xmobarrc ../xmobarrc
	cp ~/.config/xmobar/xmobarrc2 ../xmobarrc2

clean:
	rm -rf *.o *.hi .xmobarrc xmobarconf
