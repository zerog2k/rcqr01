define start-rtt
  monitor rtt setup 0x20000000 0x4000 "SEGGER RTT"
  monitor rtt start
  monitor rtt server start 9090 0
end
