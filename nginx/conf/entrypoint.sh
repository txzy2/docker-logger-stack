#!/bin/sh
echo "Replacing environment variables in Nginx config..."
envsubst '$GRAFANA_PORT' </etc/nginx/conf.d/default.conf.template >/etc/nginx/conf.d/default.conf

echo "Starting Nginx..."
exec nginx -g 'daemon off;'
