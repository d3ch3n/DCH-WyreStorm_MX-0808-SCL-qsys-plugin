--[[Controls.SendButton.EventHandler = function()
  print("Hello, World!")
end]]


for outp = 1, 8 do
  for inp = 0, 8 do
    Controls["Route_"..inp.."_"..outp].EventHandler = function ()
      if DebugFunction then print("Route EventHandler called") end
        Send("SET SW hdmiin"..inp.." hdmiout" .. outp)
    end
  end
end

--[[
Controls["AudioFollowVideo"].EventHandler = function()
  if DebugFunction then print("Audio Follow Video called") end
  Send ("SET AUDIOSW_M follow")
end

Controls["BreakAudio"].EventHandler = function()
  if DebugFunction then print("Break Audio called") end
  Send ("SET AUDIOSW_M independent")
end

Controls["SwVideo"].EventHandler = function()
  if DebugFunction then print("Sw Video Called") end
    Send("GET MP all")
    Sw_Video = true
    Sw_Audio = false
    Controls["SwVideo"].Boolean = Sw_Video
    Controls["SwAudio"].Boolean = Sw_Audio
end

Controls["SwAudio"].EventHandler = function()
  if DebugFunction then print("Sw Audio Called") end
    Send("GET AUDIOMP all")
    Sw_Video = false
    Sw_Audio = true
    Controls["SwVideo"].Boolean = Sw_Video
    Controls["SwAudio"].Boolean = Sw_Audio
end
]]

for i = 1, 3 do
  Controls["SavePreset"..i].EventHandler = function()
    if DebugFunction then print("Saving Preset "..i) end
    Send("SAVE PRESET " .. i)
  end

  Controls["RestorePreset"..i].EventHandler = function()
    if DebugFunction then print("Restoring Preset "..i) end
    Send("RESTORE PRESET " .. i)
  end
end


for outp=1, 8 do
    Controls["CEC_PWR_OUT"..outp].EventHandler = function(ctrl)
        if ctrl.Boolean then
            if DebugFunction then print("SET CEC_PWR hdmiout"..outp.." on") end
            Send("SET CEC_PWR hdmiout"..outp.." on")
        else
            if DebugFunction then print("SET CEC_PWR hdmiout"..outp.." off") end
            Send("SET CEC_PWR hdmiout"..outp.." off")
        end
    end

    -- Power ON
    Controls["CEC_PWR_ON_OUT"..outp].EventHandler = function()
        if DebugFunction then print("SET CEC_PWR hdmiout"..outp.." on") end
        Send("SET CEC_PWR hdmiout"..outp.." on")
        Controls["CEC_PWR_OUT"..outp].Boolean = true
    end

    -- Power OFF
    Controls["CEC_PWR_OFF_OUT"..outp].EventHandler = function()
        if DebugFunction then print("SET CEC_PWR hdmiout"..outp.." off") end
        Send("SET CEC_PWR hdmiout"..outp.." off")
        Controls["CEC_PWR_OUT"..outp].Boolean = false
    end

    -- AutoCEC Power Toggle
    Controls["AUTOCEC_OUT"..outp].EventHandler = function(ctrl)
        if ctrl.Boolean then
            if DebugFunction then print("SET AUTOCEC_FN hdmiout"..outp.." on") end
            Send("SET AUTOCEC_FN hdmiout"..outp.." on")
        else
            if DebugFunction then print("SET AUTOCEC_FN hdmiout"..outp.." off") end
            Send("SET AUTOCEC_FN hdmiout"..outp.." off")
        end
    end
end
--[[
-- HDCP Controls para Entradas
for i = 1, 8 do
    Controls["HDCP_IN"..i.."_ON"].EventHandler = function()
        Send("SET HDCP_S in"..i.." on")
        Controls["HDCP_IN"..i.."_FB"].Boolean = true
    end

    Controls["HDCP_IN"..i.."_OFF"].EventHandler = function()
        Send("SET HDCP_S in"..i.." off")
        Controls["HDCP_IN"..i.."_FB"].Boolean = false
    end
end

-- HDCP Controls para Saídas
for i = 1, 8 do
    Controls["HDCP_OUT"..i.."_ON"].EventHandler = function()
        Send("SET HDCP_S out"..i.." on")
        Controls["HDCP_OUT"..i.."_FB"].Boolean = true
    end

    Controls["HDCP_OUT"..i.."_OFF"].EventHandler = function()
        Send("SET HDCP_S out"..i.." off")
        Controls["HDCP_OUT"..i.."_FB"].Boolean = false
    end
end
]]