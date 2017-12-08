FROM alpine:latest as build
MAINTAINER Eugene Agafonov <e.a.agafonov@gmail.com>

# Version 2.6.8 from http://seleniumsoftware.com/downloads.html
ADD https://drive.google.com/uc?id=0B7YOzDQMt_TmS2lNMlpndnJndDA\&export=download /tmp/SMPPSim.tar.gz

RUN mkdir -p /opt/local && \
    tar -xf /tmp/SMPPSim.tar.gz -C /opt/local && \
    chmod +x /opt/local/SMPPSim/startsmppsim.sh

##############################
# Final image (JDK + SMPPSim)
##############################

FROM frolvlad/alpine-oraclejdk8
MAINTAINER Eugene Agafonov <e.a.agafonov@gmail.com>

COPY --from=build /opt/local/SMPPSim /opt/local/SMPPSim
WORKDIR /opt/local/SMPPSim

CMD /opt/local/SMPPSim/startsmppsim.sh
