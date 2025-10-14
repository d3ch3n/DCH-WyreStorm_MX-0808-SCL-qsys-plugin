

-- Configuração de Rede
table.insert(ctrls, {
  Name = "DeviceIP",
  ControlType = "Text",
  Count = 1,
  UserPin = false,
  PinStyle = "none"
})

table.insert(ctrls, {
  Name = "DevicePort",
  ControlType = "Text",
  Count = 1,
  UserPin = false,
  PinStyle = "none"
})
table.insert(ctrls, {
    Name = "Status",
    ControlType = "Indicator",
    IndicatorType = "Status",
    PinStyle = "Output",
    UserPin = true,
    Count = 1
  })

-- Cabeçalhos das Entradas
for inp = 1, 8 do
  table.insert(ctrls, {
    Name = "HeaderIN"..inp,
    ControlType = "Label",
    Count = 1,
    UserPin = false,
    PinStyle = "none"
  })
end

-- Grade de botões de chaveamento (8x8)
for outp = 1, 8 do
  -- Label da saída
  table.insert(ctrls, {
    Name = "LabelOUT"..outp,
    ControlType = "Label",
    Count = 1,
    UserPin = false,
    PinStyle = "none"
  })

  -- Botões de seleção de entrada para cada saída
  for inp = 1, 8 do
    table.insert(ctrls, {
      Name = "Route_"..inp.."_"..outp,
      ControlType = "Button",
      Count = 1,
      UserPin = false,
      PinStyle = "none"
    })
  end
end
-- Feedback de status
  table.insert(ctrls, {
    Name = "Feedback",
    ControlType = "Text",
    Count = 8,
    UserPin = false,
    PinStyle = "none"
  })

  --[[
  -- Audio Follow Video (radio)
table.insert(ctrls, {
  Name = "AudioFollowVideo",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

-- Break Audio (radio)
table.insert(ctrls, {
  Name = "BreakAudio",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

  -- Audio Follow Video (radio)
table.insert(ctrls, {
  Name = "SwVideo",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

-- Break Audio (radio)
table.insert(ctrls, {
  Name = "SwAudio",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Input"
})

]]

-----Presets
for i = 1, 6 do
  table.insert(ctrls, {
    Name = "SavePreset"..i,
    ControlType = "Button",
    ButtonType = "Momentary",
    UserPin = true,
    PinStyle = "Both"
  })
  table.insert(ctrls, {
    Name = "RestorePreset"..i,
    ControlType = "Button",
    ButtonType = "Momentary",
    UserPin = true,
    PinStyle = "Both"
  })
end

-------cec

for outp = 1, 8 do

    -- Botão Power Toggle
    table.insert(ctrls, {
        Name = "CEC_PWR_OUT"..outp,
        ControlType = "Button",
        ButtonType = "Momentary",
        Boolean = false  -- Inicialmente desligado
    })

    -- Botão Power ON
    table.insert(ctrls, {
        Name = "CEC_PWR_ON_OUT"..outp,
        ControlType = "Button",
        ButtonType = "Toggle",
        UserPin = true,
        PinStyle = "Both"
    })

    -- Botão Power OFF
    table.insert(ctrls, {
        Name = "CEC_PWR_OFF_OUT"..outp,
        ControlType = "Button",
        ButtonType = "Toggle",
        UserPin = true,
        PinStyle = "Both"
    })

    -- Botão AutoCEC Power
    table.insert(ctrls, {
        Name = "AUTOCEC_OUT"..outp,
        ControlType = "Button",
        ButtonType = "Toggle",
        Boolean = false,  -- Inicialmente desligado
        UserPin = true,
        PinStyle = "Both"
    })
  end


  -- HDCP Inputs
for inp = 1, 8 do
    -- Botão ON
    table.insert(ctrls, {
        Name = "HDCP_IN"..inp.."_ON",
        ControlType = "Button",
        ButtonType = "Momentary",
        Boolean = false,
        UserPin = true,
        PinStyle = "Both"
    })

    -- Botão OFF
    table.insert(ctrls, {
        Name = "HDCP_IN"..inp.."_OFF",
        ControlType = "Button",
        ButtonType = "Momentary",
        Boolean = false,
        UserPin = true,
        PinStyle = "Both"
    })

    -- Feedback Boolean
    table.insert(ctrls, {
        Name = "HDCP_IN"..inp.."_FB",
        ControlType = "Indicator",
        Boolean = false,
        UserPin = false
    })
end

-- HDCP Outputs
for outp = 1, 8 do
    -- Botão ON
    table.insert(ctrls, {
        Name = "HDCP_OUT"..outp.."_ON",
        ControlType = "Button",
        ButtonType = "Momentary",
        Boolean = false,
        UserPin = true,
        PinStyle = "Both"
    })

    -- Botão OFF
    table.insert(ctrls, {
        Name = "HDCP_OUT"..outp.."_OFF",
        ControlType = "Button",
        ButtonType = "Momentary",
        Boolean = false,
        UserPin = true,
        PinStyle = "Both"
    })

    -- Feedback Boolean
    table.insert(ctrls, {
        Name = "HDCP_OUT"..outp.."_FB",
        ControlType = "Indicator",
        Boolean = false,
        UserPin = false
    })
end
