node /opt/joebotics/node-projects/simmer/simmer.js --workers 1 --port 8080 &
sleep 5
chromium-browser --kiosk --app=http://localhost:8080

