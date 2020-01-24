route -p delete 0.0.0.0
route -p delete 10.0.0.0
route -p add 0.0.0.0 mask 0.0.0.0 10.200.0.1
route -p add 10.0.0.0 mask 255.0.0.0 10.18.124.1