# kill simmer app
kill -9 `ps -ef | grep "node /opt/joebotics/node-projects/simmer/simmer.js --workers 1 --port 8080" | awk '{print $2}'`

# kill chromium
kill -9 `ps -ef | grep "/usr/lib/chromium-browser/chromium-browser --enable-pinch --kiosk --app=http://localhost:8080" | awk '{print $2}'`

