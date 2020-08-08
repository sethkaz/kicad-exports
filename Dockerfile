FROM setsoft/kicad_auto:10.3-5.1.5 as kicad
LABEL MAINTAINER nerdyscout <nerdyscout@posteo.de>
LABEL Description="export various files from KiCad projects"
LABEL VERSION="v2.1"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
