local CurrentPage = PageNames[props["page_index"].Value]

Logo = '--[[ #encode "Images\Wyrestorm-Logo.png" ]]'
table.insert(graphics,{
  Type="Image",
  Image=Logo,
  Position={4,4},
  Size={150,43}
})



if CurrentPage == "Setup" then

  -- Configuração de Rede
  layout["DeviceIP"] = {
    PrettyName = "Device IP",
    Type = "Text",
    Position = {16, 50},
    Size = {120, 24},
    FontSize = 8,
    Color = Colors.White,
    StrokeColor = Colors.White
  }

  layout["DevicePort"] = {
    PrettyName = "Device Port",
    Type = "Text",
    Position = {150, 50},
    Size = {60, 24},
    FontSize = 8,
    Color = Colors.White,
    StrokeColor = Colors.White
  }

  layout["Status"] = {
    PrettyName = "Connection Status", 
    Position = {428, 38}, 
    Size = {301, 48}
  }


elseif CurrentPage == "Switch" then

  -- Cabeçalho das Entradas
    for inp = 1, 8 do
      table.insert(graphics,{
        Name = "HeaderIN"..inp,
        Type = "Text",
        Position = {100 + (inp-1)*60, 80},
        Size = {50, 20},
        FontSize = 12,
        Color = Colors.Black,
        StrokeColor = Colors.Gray,
        TextColor = Colors.Black,
        Text = "IN "..inp
      })
    end

    -- Labels das Saídas
    for outp = 1, 8 do
      table.insert(graphics,{
        Name = "LabelOUT"..outp,
        Type = "Text",
        Position = {40, 100 + (outp-1)*36},
        Size = {50, 24},
        FontSize = 12,
        Color = Colors.Black,
        StrokeColor = Colors.Gray,
        TextColor = Colors.Black,
        Text = "OUT "..outp
      })
    end


    --[[
    layout["AudioFollowVideo"] = {
      PrettyName = "AudioFollowVideo",
      Type = "Button",
      Position = {300,10},
      Size = {100,24},
      --Color = Colors.Black,
      CornerRadius = 12,
      Legend = "Audio Follow Video",
      FontSize = 9,
    }
    layout["BreakAudio"] = {
      PrettyName = "BreakAudio",
      Type = "Button",
      Position = {450,10},
      Size = {100,24},
      --Color = Colors.Black,
      CornerRadius = 12,
      Legend = "Break Audio",
      FontSize = 9,
    }

    layout["SwVideo"] = {
      PrettyName = "SwVideo",
      Type = "Button",
      Position = {400,40},
      Size = {100,24},
      --Color = Colors.Black,
      CornerRadius = 12,
      Legend = "Video",
      FontSize = 9,
    }
    layout["SwAudio"] = {
      PrettyName = "SwAudio",
      Type = "Button",
      Position = {500,40},
      Size = {100,24},
      --Color = Colors.Black,
      CornerRadius = 12,
      Legend = "Audio",
      FontSize = 9,
    }
      ]]

-- Grade de botões (8 Saídas x 8 Entradas)
    for outp = 1, 8 do
      -- Label da saída na lateral esquerda
      layout["LabelOUT"..outp] = {
        PrettyName = "Label OUT"..outp,
        Type = "Text",
        Position = {40, 100 + (outp-1)*36},
        Size = {50, 24},
        FontSize = 12,
        Color = Colors.Black,
        StrokeColor = Colors.Gray,
        Legend = "OUT "..outp
      }

  -- Botões de chaveamento (linha da saída)
    for inp = 1, 8 do
      layout["Route_"..inp.."_"..outp] = {
        PrettyName = "Route IN"..inp.." -> OUT"..outp,
        Type = "Button",
        ButtonType = "Trigger",
        Legend = tostring(inp),
        Position = {100 + (inp-1)*60, 100 + (outp-1)*36},
        Size = {50, 24},
        FontSize = 12,
        HTextAlign = "Center",
        Padding = 2,
        StrokeWidth = 1,
        Color = Colors.Black,
        StrokeColor = Colors.Black,
        CornerRadius = 6
      }
    end
  end

  -- Feedback textual (qual entrada está em cada saída)
  for outp = 1, 8 do
    layout["Feedback " ..outp] = {
      PrettyName = "Feedback OUT "..outp,
      Type = "Text",
      Position = {600, 100 + (outp-1)*36},
      Size = {70, 24},
      FontSize = 16,
      Color = Colors.Black,
      StrokeColor = Colors.Black,
      TextColor = Colors.White
    }
  end
  -- TBD
elseif CurrentPage == "Presets" then
  
  for i = 1, 3 do
  layout["SavePreset"..i] = {
    PrettyName = "Save Preset "..i,
    Type = "Button",
    Position = { 50, 50 + (i-1)*40 },
    Size = { 100, 30 },
    Legend = "Save Preset "..i,
    FontSize = 9,
    CornerRadius = 8,
    Color = Colors.Blue
  }
  layout["RestorePreset"..i] = {
    PrettyName = "Restore Preset "..i,
    Type = "Button",
    Position = { 170, 50 + (i-1)*40 },
    Size = { 100, 30 },
    Legend = "Restore Preset "..i,
    FontSize = 9,
    CornerRadius = 8,
    Color = Colors.Green
  }
  end
elseif CurrentPage == "CEC" then
  -- ==== LAYOUT CEC CONTROLS ====
    for outp = 1, 8 do
      -- Label da saída
      table.insert(graphics,{
        PrettyName = "CEC Label OUT"..outp,
        Type = "Text",
        Position = {40, 50 + (outp-1)*40},
        Size = {50, 24},
        FontSize = 12,
        Text = "OUT "..outp
      })

            -- Botão Power Toggle
      layout["CEC_PWR_OUT"..outp] = {
        PrettyName = "CEC Power Toggle OUT"..outp,
        Type = "Button",
        ButtonType = "Toggle",
        Position = {120, 50 + (outp-1)*40},
        Size = {100, 30},
        Legend = "Power Toggle",
        FontSize = 9,
        CornerRadius = 8,
        Color = Colors.Orange
      }

      -- Botão Power ON
      layout["CEC_PWR_ON_OUT"..outp] = {
        PrettyName = "CEC Power ON OUT"..outp,
        Type = "Button",
        ButtonType = "Trigger",
        Position = {230, 50 + (outp-1)*40},
        Size = {80, 30},
        Legend = "Power ON",
        FontSize = 9,
        CornerRadius = 8,
        Color = Colors.Green
      }

      -- Botão Power OFF
      layout["CEC_PWR_OFF_OUT"..outp] = {
        PrettyName = "CEC Power OFF OUT"..outp,
        Type = "Button",
        ButtonType = "Trigger",
        Position = {320, 50 + (outp-1)*40},
        Size = {80, 30},
        Legend = "Power OFF",
        FontSize = 9,
        CornerRadius = 8,
        Color = Colors.Red
      }

      -- Botão AutoCEC Power
      layout["AUTOCEC_OUT"..outp] = {
        PrettyName = "AutoCEC OUT"..outp,
        Type = "Button",
        ButtonType = "Toggle",
        Position = {410, 50 + (outp-1)*40},
        Size = {120, 30},
        Legend = "Auto CEC Power",
        FontSize = 9,
        CornerRadius = 8,
        Color = Colors.Purple
      }
    end
  elseif CurrentPage == "HDCP" then
    -- *** HDCP Layout ***

    -- HDCP Inputs
    for inp = 1, 8 do
        -- Label
        table.insert(graphics, {
            PrettyName = "HDCP Label IN"..inp,
            Type = "Text",
            Position = {40, 50 + (inp-1)*40},
            Size = {50, 24},
            FontSize = 12,
            Text = "IN "..inp
        })

        -- Botão ON
        layout["HDCP_IN"..inp.."_ON"] = {
            PrettyName = "HDCP Input "..inp.." ON",
            Type = "Button",
            ButtonType = "Momentary",
            Position = {120, 50 + (inp-1)*40},
            Size = {60, 30},
            Legend = "ON",
            FontSize = 9,
            CornerRadius = 8,
            Color = Colors.Green
        }

        -- Botão OFF
        layout["HDCP_IN"..inp.."_OFF"] = {
            PrettyName = "HDCP Input "..inp.." OFF",
            Type = "Button",
            ButtonType = "Momentary",
            Position = {190, 50 + (inp-1)*40},
            Size = {60, 30},
            Legend = "OFF",
            FontSize = 9,
            CornerRadius = 8,
            Color = Colors.Red
        }

        -- Feedback
        layout["HDCP_IN"..inp.."_FB"] = {
            PrettyName = "HDCP Input "..inp.." Feedback",
            Type = "indicator",
            Style = "Led",
            Position = {260, 50 + (inp-1)*40},
            Size = {24, 24},
            CornerRadius = 8,
            Color = Colors.Gray
        }

      end
        -- HDCP Outputs
      for outp=1,8 do
        -- Label
        table.insert(graphics, {
            PrettyName = "HDCP Label OUT"..outp,
            Type = "Text",
            Position = {300 +20, 50 + (outp-1)*40},
            Size = {50, 24},
            FontSize = 12,
            Text = "OUT "..outp
        })

        -- Botão ON
        layout["HDCP_OUT"..outp.."_ON"] = {
            PrettyName = "HDCP Output "..outp.." ON",
            Type = "Button",
            ButtonType = "Momentary",
            Position = {380 +20, 50 + (outp-1)*40},
            Size = {60, 30},
            Legend = "ON",
            FontSize = 9,
            CornerRadius = 8,
            Color = Colors.Green
        }
        -- Botão ON
        layout["HDCP_OUT"..outp.."_OFF"] = {
            PrettyName = "HDCP Output "..outp.." OFF",
            Type = "Button",
            ButtonType = "Momentary",
            Position = {380 +90, 50 + (outp-1)*40},
            Size = {60, 30},
            Legend = "OFF",
            FontSize = 9,
            CornerRadius = 8,
            Color = Colors.Red
        }
        -- Feedback
        layout["HDCP_OUT"..outp.."_FB"] = {
            PrettyName = "HDCP Input "..outp.." Feedback",
            Type = "indicator",
            Style = "Led",
            Position = {380 + 160, 50 + (outp-1)*40},
            Size = {24, 24},
            CornerRadius = 8,
            Color = Colors.Gray
        }
      end
end