build:
	docker build -t kicad-exports:v2.0 . > build.log

install:
#	echo 'docker run -u $$(id -u $$USER):$$(id -g $$USER) -v "$$PWD:$$HOME:rw" kicad-exports $$@' > kicad-exports
	echo 'docker run --user "$$(id -u):$$(id -g)" \
		--workdir="/home/$$USER" \
	    --volume="$$PWD:/home/$$USER:rw" \
	    --volume="/etc/group:/etc/group:ro" \
    	--volume="/etc/passwd:/etc/passwd:ro" \
    	--volume="/etc/shadow:/etc/shadow:ro" \
		kicad-exports:v2.0 $$@' > kicad-exports

	chmod +x kicad-exports
	mv -f kicad-exports ~/.local/bin/kicad-exports

clean:
	docker image rm -f kicad-exports
	git clean -f -x

test:
# https://github.com/nektos/act
	act

shell: 
	docker run -it --entrypoint '/bin/bash' -v "$$PWD:/home/$$USER:rw" kicad-exports:v2.0