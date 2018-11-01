upstream fansik {
    ip_hash;
    server 192.168.0.37:8888 weight=1 max_fails=2 fail_timeout=30s;
    server 192.168.0.38:8888 weight=1 max_fails=2 fail_timeout=30s;
    server 192.168.0.39:8888 weight=1 max_fails=2 fail_timeout=30s;
}

server {
     listen       80;
     server_tokens off;
     server_name www.fansik.com;
     location ~/* {
         index  index.html index.htm;
         include proxy.conf;
         proxy_pass http://fansik;
     }
     error_page   500 502 503 504  /50x.html;
     location = /50x.html {
         root   html;
     }
     location ~ /\.ht {
         deny  all;
     }
}

