# Use the base image
FROM accetto/ubuntu-vnc-xfce-g3:24.04

# Set the maintainer label
LABEL maintainer="your_name@example.com"

# Ensure we are using root to install packages
USER root

# Update package lists and install additional packages (replace 'your-packages' with actual packages)
RUN apt-get update && apt-get -y upgrade 

# Install Zoom dependencies and automation tools
RUN apt-get install -y wget curl gnupg2 xdotool wmctrl libglib2.0-0 libxext6 libsm6 libxrender1 
    
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


EXPOSE 5901 6901

# Set the default command (the base image already starts the necessary VNC server)
CMD ["/home/headless/dir-for-container-from-host/zoom-bot-to-run-wwoffice.sh"]
