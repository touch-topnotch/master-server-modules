echo "Starting all services..."

echo "Starting master server..."
/root/master-server-modules/scripts/start-master.sh

echo "Starting ssh tunnels..."
/root/master-server-modules/scripts/start-ssh-tunnels.sh

echo "Starting vkid-gpt..."
/root/master-server-modules/scripts/start-vkid-gpt.sh

echo "Starting website..."
/root/master-server-modules/scripts/start-website.sh
