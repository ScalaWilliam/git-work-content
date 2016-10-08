default: build
fedora-setup:
	sudo yum -y install saxon parallel npm nodejs
	sudo npm install -g browser-sync
	echo '#!/bin/bash' | sudo tee /usr/bin/saxon
	echo 'exec java -jar /usr/share/java/saxon/saxon.jar "$$@"' | sudo tee -a /usr/bin/saxon
	sudo chmod +x /usr/bin/saxon
centos-setup:
	sudo yum -y install saxon parallel npm nodejs
	sudo npm install -g browser-sync
	echo '#!/bin/bash' | sudo tee /usr/bin/saxon
	echo 'exec java -jar /usr/share/java/saxon.jar "$$@"' | sudo tee -a /usr/bin/saxon
	sudo chmod +x /usr/bin/saxon
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
inotify-watch:
	inotifywait -m -e close_write --exclude '.*\.html' . | xargs -n1 make build
	dsads
browser-sync:
	browser-sync start --files '*.html' --files '*.css' -s .
browser-sync-no-open:
	browser-sync start --files '*.html' --files '*.css' -s . --no-open
clean:
	rm -f *.xhtml
develop-headless: browser-sync-no-open watch
develop: browser-sync watch
docker:
	docker run -v .:/opt/gw w
