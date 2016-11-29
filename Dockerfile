# Dockerfile to run the JKA steam bot
FROM ubuntu:14.04
MAINTAINER Dan Padgett <dumbledore3@gmail.com>

RUN apt-get update
RUN apt-get install -y mono-complete

RUN useradd -ms /bin/bash steambot

# copy the nice dotfiles that dockerfile/ubuntu gives us:
RUN cd && cp -R .bashrc .profile /home/steambot

WORKDIR /home/steambot

RUN chown -R steambot:steambot /home/steambot

USER steambot
ENV HOME /home/steambot
ENV USER steambot

# copy over the steambot binaries
USER root
COPY ChatterBotAPI.dll Newtonsoft.Json.dll protobuf-net.dll SteamAuth.dll SteamBot.exe SteamKit2.dll SteamTrade.dll .
RUN chown steambot:steambot *
RUN mkdir -p /mnt/config
RUN chown steambot:steambot /mnt/config
VOLUME /mnt/config
USER steambot
RUN ln -s /mnt/config/settings.json settings.json

CMD mono SteamBot.exe
