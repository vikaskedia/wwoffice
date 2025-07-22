# wwoffice

Q1) Why is this project needed?
We want to run a zoom meeting 24x7

Q2) Why use https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-g3 ?
 - uses ubuntu 24.04
 - updated this year

Q3) How to run this container?
docker-compose build
docker-compose up

Q4) How to access this container?
Open http://IP:26901 to view the desktop via noVNC.

Q5) What are the remainign todos?
1. Zoom requires login the first time.
2. Zoom virtual camera does not work with ffmpeg