FROM accetto/ubuntu-vnc-xfce-g3:24.04

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

# For the virtual webcam. creates a virtual video device (e.g., /dev/video10) and uses ffmpeg to continuously stream the MP4 to Zoom as a virtual webcam.
RUN apt-get install -y \
    ffmpeg \
    v4l2loopback-dkms \
    v4l2loopback-utils \
    && apt-get clean

COPY zoom-bot-to-run-wwoffice.sh /usr/local/bin/zoom-bot-to-run-wwoffice.sh
COPY zoom-background.mp4 /tmp/zoom-background.mp4
RUN chmod +x /usr/local/bin/zoom-bot-to-run-wwoffice.sh

CMD ["/usr/local/bin/zoom-bot-to-run-wwoffice.sh"]
