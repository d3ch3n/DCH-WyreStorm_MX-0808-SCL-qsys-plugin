
-- Global Variables
EmptyIPMessage = "Enter an IP Address"
Status = Controls.Status
IPAddress = Controls["DeviceIP"].String
Port = 23

-- Constants
EOL = "" --"\n" -- End of line character as defined in device's API
EOLCharacter = TcpSocket.EOL.CrLfStrict -- EOL Character lookup for TCPSocket ReadLine
StatusState = {OK=0, COMPROMISED=1, FAULT=2, NOTPRESENT=3, MISSING=4, INITIALIZING=5}

-- Timers
PollTimer = Timer.New()

-- Sockets
TCP = TcpSocket.New()
TCP.ReadTimeout = 5
TCP.WriteTimeout = 5
TCP.ReconnectTimeout = 5

-- Variables
PollTime = 3
LoggedIn = false

-- Debug level
DebugTx, DebugRx, DebugFunction = false, false, false
DebugPrint = Properties["Debug Print"].Value
if DebugPrint == "Tx/Rx" then
  DebugTx, DebugRx = true, true
elseif DebugPrint == "Tx" then
  DebugTx = true
elseif DebugPrint == "Rx" then
  DebugRx = true
elseif DebugPrint == "Function Calls" then
  DebugFunction = true
elseif DebugPrint == "All" then
  DebugTx, DebugRx, DebugFunction = true, true, true
end
  
  

  -- *** Functions ***
  -- Helper Functions
  function ReportStatus(state, msg)
    local msg = msg or ""
    Status.Value = StatusState[state]
    Status.String = msg
  end

  function Send(cmd)
    if DebugFunction then print("Send() called") end
    if IsConnected() then
      if DebugTx then print("Tx: " .. cmd) end
      TCP:Write(cmd .. "\x0d\x0a")
    else
      print("Error - Disconnected; unable to send " .. cmd)
    end
  end

  function IsConnected()
    return TCP.IsConnected
  end


  function IsLoggedIn()
    return LoggedIn
  end

  function Connect()
    if DebugFunction then print("Connect() called") end
      print("Connecting to " .. IPAddress .. ":" .. Port)  
      TCP:Connect(IPAddress, Port)
  end

  function Disconnect()
    if DebugFunction then print("Disconnect() called") end
    TCP:Disconnect()
    Disconnected()
  end

  function Connected()
    if DebugFunction then print("Connected() called") end
    --add initialization commands here

    PollTimer:Start(PollTime)
    
  end

  function Disconnected()
    if DebugFunction then print("Disconnected() called") end
    PollTimer:Stop()
    LoggedIn = false
  end
  

  -- TCP socket callbacks
  TCP.Connected = function()
    if DebugFunction then print("TCPSocket Connected Handler called") end
    ReportStatus("OK")
    Connected()
  end

  TCP.Reconnect = function()
    if DebugFunction then print("TCPSocket Reconnect Handler called") end
    Disconnected()
  end

  TCP.Closed = function()
    if DebugFunction then print("TCPSocket Closed Handler called") end
    ReportStatus("MISSING", "Socket closed")
    Disconnected()
  end

  TCP.Error = function()
    if DebugFunction then print("TCPSocket Error Handler called") end
    ReportStatus("MISSING", "Socket error")
    Disconnected()
  end

  TCP.Timeout = function()
    if DebugFunction then print("TCPSocket Timeout Handler called") end
    ReportStatus("MISSING", "Timeout")
    Disconnected()
  end

  TCP.Data = function()
    if DebugFunction then print("TCPSocket Data Handler called") end
    --print("Data received:")
    ParseResponse()
  end
  

  



  function PollDevice()
    if DebugFunction then print("PollDevice() called") end
    --add polling commands here
    Send("GET MP all")
    Send("GET AUDIOSW_M")
  end


  function PrintOutputRouting()
    print("Current Output Routing:")
    for outp = 1, 8 do
      local input = OutputRouting[outp]
      print("OUT"..outp.." -> "..input)
      Controls.Feedback[outp].String = " -> "..input
    end
  end

  function ParseResponse()
    if DebugFunction then print("ParseResponse() called") end
    local rx = TCP:ReadLine(EOLCharacter)
    local buffer = {}
      if DebugRx then print("Rx: " .. rx) end
      table.insert(buffer, rx)
    while next(buffer) ~= nil do
      local line = table.remove(buffer, 1)
      if line then
        if DebugRx then print("Processing line: " .. line) end

        
        -- Process the line here
        -- Example: Check for specific responses and update controls
       
        if string.find(line, "AUDIOSW_M") then
          local AudioMode = string.match(line, "AUDIOSW_M%s+(%S+)")
          print (AudioMode)
          if AudioMode == "independent" then
            Sw_Mode_BreakAudio = true
            Sw_Mode_AFV = false
            Sw_Video = true
            Sw_Audio = false
            print ("definido independent")
          elseif AudioMode =="follow" then
            Sw_Mode_BreakAudio = false
            Sw_Mode_AFV = true
            print ("definido follow")
          end

          Controls["BreakAudio"].Boolean = Sw_Mode_BreakAudio
          Controls["AudioFollowVideo"].Boolean = Sw_Mode_AFV
          Controls["SwVideo"].IsInvisible = Sw_Mode_AFV
          Controls["SwAudio"].IsInvisible = Sw_Mode_AFV
          Controls["SwVideo"].Boolean = Sw_Video
          Controls["SwAudio"].Boolean = Sw_Audio
        
        elseif string.find(line, "SW") then
          print ("Switch command response received: " .. line)
          local input, output = string.match(line, "SW in(%d+) out(%d+)")
          if input and output then
            output = tonumber(output)
            input = tonumber(input)
            OutputRouting[output] = input
            FeedbackColor(input,output)
          end
          PrintOutputRouting()

        elseif string.find(line, "MP") then
          print ("Switch command response received: " .. line)
          local input, output = string.match(line, "MP in(%d+) out(%d+)")
          if input and output then
            output = tonumber(output)
            input = tonumber(input)
            OutputRouting[output] = input
            FeedbackColor(input,output)
          end
          PrintOutputRouting()

        elseif string.find(line, "AUDIOMP") then -----precisa verificar se o in e OUT é maiusculo ou minusculo
          print ("Switch Audio MAP response received: " .. line)
          local input, output = string.match(line, "AUDIOMP in(%d+) lineout(%d+)")
          if input and output then
            output = tonumber(output)
            input = tonumber(input)
            OutputRouting[output] = input
            FeedbackColor(input,output)
          end
          PrintOutputRouting()

        elseif string.find(line, "AUDIOSW") then -----precisa verificar se o in e OUT é maiusculo ou minusculo
          print ("Switch Audio command response received: " .. line)
          local input, output = string.match(line, "AUDIOSW in(%d+) lineout(%d+)")
          if input and output then
            output = tonumber(output)
            input = tonumber(input)
            OutputRouting[output] = input
            FeedbackColor(input,output)
          end
          PrintOutputRouting()

          -----------------add new parsing here.
        
        elseif string.find(line, "CEC_PWR") then
        -- Exemplo: "CEC_PWR out1 on"
          local outp, state = string.match(line, "CEC_PWR out(%d+) (%a+)")
          if outp and state then
            outp = tonumber(outp)
            local isOn = (state == "on")

            -- Atualiza botão toggle
            Controls["CEC_PWR_OUT"..outp].Boolean = isOn

            -- Atualiza botão Power ON
            Controls["CEC_PWR_ON_OUT"..outp].Boolean = isOn

            -- Atualiza botão Power OFF
            Controls["CEC_PWR_OFF_OUT"..outp].Boolean = not isOn

            if DebugRx then
                print("CEC Power status OUT"..outp.." = "..state)
            end
          end
        elseif string.find(line, "AUTOCEC_FN") then
          -- Exemplo: "AUTOCEC_FN out1 on"
          local outp, state = string.match(line, "AUTOCEC_FN out(%d+) (%a+)")
          if outp and state then
              outp = tonumber(outp)
              local isOn = (state == "on")

              -- Atualiza botão toggle
              Controls["AUTOCEC_OUT"..outp].Boolean = isOn

              if DebugRx then
                  print("AUTOCEC status OUT"..outp.." = "..state)
              end
          end
        elseif string.find(line, "HDCP_S in") then
          local num, state = string.match(line, "HDCP_S in(%d+) (%a+)")
          if num and state then
              num = tonumber(num)
              local isOn = (state == "on")
              Controls["HDCP_IN"..num.."_FB"].Boolean = isOn
          end

        elseif string.find(line, "HDCP_S out") then
          local num, state = string.match(line, "HDCP_S out(%d+) (%a+)")
          if num and state then
              num = tonumber(num)
              local isOn = (state == "on")
              Controls["HDCP_OUT"..num.."_FB"].Boolean = isOn
          end


        -- Add more parsing as needed based on device's API responses
        end
      end
    end
  end
  
  

  -- *** Event Handlers ***
  Controls["DeviceIP"].EventHandler = function()
    if DebugFunction then print("IPAddress handler called") end
    IPAddress = Controls["DeviceIP"].String
    if IPAddress == "" or IPAddress == "Enter an IP Address" then
      IPAddress = EmptyIPMessage
      Disconnect()
    else
      Connect()
    end
  end

  Controls["DevicePort"].EventHandler = function()
    if DebugFunction then print("Port handler called") end
    Port = tonumber(Controls["DevicePort"].String)
    print("Port set to " .. Port)
    Disconnect()
    Connect()
  end

  Controls["DevicePort"].String = tostring(Port)
  Controls["DeviceIP"].String = IPAddress

  --PollTimer.EventHandler = PollDevice

  -- Run at start
  Connect()
