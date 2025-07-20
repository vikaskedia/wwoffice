FROM accetto/ubuntu-vnc-xfce-g3:latest

USER root

# Install Zoom dependencies and automation tools
RUN apt-get update && apt-get install -y \
    wget curl gnupg2 xdotool wmctrl \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    && apt-get clean

# Install Zoom
RUN wget -O /tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb \
    && apt install -y /tmp/zoom.deb \
    && rm /tmp/zoom.deb

COPY zoom-bot.sh /usr/local/bin/zoom-bot.sh
RUN chmod +x /usr/local/bin/zoom-bot.sh

CMD ["/usr/local/bin/zoom-bot.sh"]
