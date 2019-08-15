apt install python -y

export python_binary_dir=`which python`
export get_dir=`pwd`


cat > /etc/systemd/system/tezos-dist.service <<EOF
[Unit]
Description=Tezos dist daemon
After=network-online.target

[Service]
ExecStart=$python_binary_dir pay.py
WorkingDirectory=$get_dir

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/tezos-dist.timer <<EOF
[Unit]
Description=Run tezos dist

[Timer]
OnActiveSec=4096m
Persistent=true
Unit=tezos-dist

[Install]
WantedBy=timers.target
EOF

systemctl daemon-reload && systemctl start tezos-dist.timer
