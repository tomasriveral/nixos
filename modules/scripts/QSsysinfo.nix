{
writeShellApplication,
ripgrep,
gawkInteractive,
iproute2,
coreutils,
procps,
upower,
...
}:
writeShellApplication {
name = "QS-sysinfo";
runtimeInputs = [
  ripgrep
  gawkInteractive
  iproute2
  coreutils
  procps
  upower
];
text = ''
# Pad CPU, MEM, DISK to 2 chars (right-aligned)
  
cpu=$(awk '/^cpu /{printf("%.0f", ($2+$4)*100/($2+$4+$5))}' /proc/stat)
cpu=$(printf "%2s" "$cpu")

sum=0
count=0

for f in /sys/class/hwmon/hwmon*/temp*_input; do
  if [ -r "$f" ]; then
    val=$(cat "$f" 2>/dev/null) || continue
    sum=$((sum + val))
    count=$((count + 1))
  fi
done

temp=$(( sum / count / 1000 ))  

sum=0
count=0

for f in /sys/class/hwmon/hwmon*/fan*_input; do
  if [ -r "$f" ]; then
    val=$(cat "$f" 2>/dev/null) || continue
    sum=$((sum + val))
    count=$((count + 1))
  fi
done
fan=$(( sum / count / 1000 ))  
fan=$(printf "%4s" "$fan")

mem=$(free | awk '/Mem:/ {printf("%.0f",$3/$2*100)}')
mem=$(printf "%2s" "$mem")

disk=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
disk=$(printf "%2s" "$disk")

# Pad POWER to 5 chars (XX.XX)
power=$(upower -b | awk -F: '/energy-rate/ {gsub(/^[ \t]+/, "", $2); split($2,a," "); printf("%.2f", a[1])}')
power=$(printf "%5s" "$power")

# network calculations
iface=$(ip route get 1.1.1.1 | awk '{print $5; exit}')

rx1=$(cat "/sys/class/net/$iface/statistics/rx_bytes")
tx1=$(cat "/sys/class/net/$iface/statistics/tx_bytes")

sleep 1

rx2=$(cat "/sys/class/net/$iface/statistics/rx_bytes")
tx2=$(cat "/sys/class/net/$iface/statistics/tx_bytes")

down_speed=$(( (rx2 - rx1) / 1024 ))
up_speed=$(( (tx2 - tx1) / 1024 ))

# Output JSON
echo "{\"cpu\":\"$cpu\",\"temp\":\"$temp\",\"fan\":\"$fan\",\"mem\":\"$mem\",\"disk\":\"$disk\",\"power\":\"$power\",\"down\":\"$down_speed\",\"up\":\"$up_speed\"}"
'';
}
