# wwoffice

Q1) What is the business requirement?
We want to run a zoom meeting 24x7 with different breakout rooms for each department to simulate a physical office where people can walk from one department room to another.

Q2) Why is this project needed?

Say this project is not running then say tanmoy comes to work and goes to wwoffice zoom meeting ID.

If “Join Before Host” is Enabled
 -- Participants can join and interact without the host.
 -- They can talk, chat, share screens (depending on settings).
 -- No one gets host controls (e.g., mute all, record, remove participants) unless:
    -- An alternative host joins (and becomes host).
 -- The meeting can continue indefinitely (no 40-minute limit for paid accounts).

So why is this project needed? If the host does not join first then the breakout rooms do not get created.

Q3) Why use https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-g3 ?
 - uses ubuntu 24.04
 - updated this year

Q4) How to run this container?
docker-compose build
docker-compose up

Q5) How to access this container?
Open http://IP:26901 to view the desktop via noVNC.

Q6) What are the remainign todos?
1. Zoom requires login the first time.
2. Zoom virtual camera does not work with ffmpeg