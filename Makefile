default: setup build
rpm-setup:
	sudo yum install saxon parallel fswatch npm nodejs
	sudo npm install -g browser-sync
deb-setup:
	sudo apt-get install saxon parallel fswatch npm nodejs
	sudo npm install -g browser-sync
mac-setup:
	brew install saxon parallel fswatch npm nodejs
	npm install -g browser-sync
build:
	ls *.xml | parallel saxon -s:{} -a:on -o:{.}.html
watch:
	fswatch -l 0.2 --exclude '.*\.html' . | xargs -n1 make build
browser-sync:
	browser-sync start --files '*.html' --files '*.css' -s .
clean:
	rm -f *.xhtml
develop:
	parallel -j 2 -k make ::: watch browser-sync
