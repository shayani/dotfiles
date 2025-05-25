docker run -d \
  --name selenium \
  -e SE_VNC_NO_PASSWORD=1 \
  -p 7900:7900 \
  --shm-size="2gb" \
  --restart unless-stopped \
  selenium/standalone-chromium
