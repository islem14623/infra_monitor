echo "===Memory usage==="
echo "$(free -h)"
echo "=== disk usage ==" 
df -h
echo "=== CPU Usage ==="
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}'
disk_usage=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
if [ "$disk_usage" -gt 75 ]; then
    echo "WARNING: disk is almost full ($disk_usage%)"
fi
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int(100 - $8)}')
echo "CPU usage is $cpu_usage" 
if [ "$cpu_usage" -gt 75 ]; then
    echo "WARNING: cpu is almost full ($cpu_usage%)"
fi
mem_usage=$(free | grep "Mem:" | awk '{print int($3/$2*100)}')
echo "Memory usage is $mem_usage%"
if [ "$mem_usage" -gt 80 ]; then echo "WARNING: memory is almost full ($mem_usage%)"; fi
