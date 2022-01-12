
xmobarconf: imports
	ghc --make -o xmobarconf XMobarConf.hs
	./xmobarconf

imports:
	@bash import_lib

install: .xmobarrc
	cp .xmobarrc ~/.config/xmobar/xmobarrc

clean:
	rm -rf *.o *.hi .xmobarrc xmobarconf
