build:
	docker build -t kicad-exports:auto . > build.log

install:
#	echo 'docker run -u $$(id -u $$USER):$$(id -g $$USER) -v "$$PWD:$$HOME:rw" kicad-exports $$@' > kicad-exports
	echo 'docker run -v "$$PWD:/mnt:rw" \
	    -v $$PWD:/home/$$USER/ \
	    --user $$USER_ID:$$GROUP_ID \
	    --workdir="/home/$$USER" \
	    --volume="/etc/passwd:/etc/passwd:ro" \
	    --volume="/etc/shadow:/etc/shadow:ro" \
		--volume="/etc/group:/etc/group:ro" \
		kicad-exports:auto $$@' > kicad-exports

	chmod +x kicad-exports
	mv -f kicad-exports ~/.local/bin/kicad-exports

clean:
	docker image rm -f kicad-exports:auto
	git clean -f -x

test:
# https://github.com/nektos/act
	act

shell: 
	docker run -it --entrypoint '/bin/bash' -v "$$PWD:/home/$$USER/:rw" kicad-exports:auto
