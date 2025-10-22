
-- Define the color of the plugin object in the design
local Colors = {
    White = {255, 255, 255},
    Grey = {232, 232, 232},
    DarkGrey = {50, 50, 50},
    Black = {0, 0, 0},
    Red = {255, 0, 0},
    Green = {0, 255, 0},
    LightBlue = {65, 211, 248},
    Stroke = {156, 171, 175  },
    FaderBlue = {50,90,117}
}

OutputRouting = {0,0,0,0,0,0,0,0} -- Output to Input mapping table
Sw_Mode_AFV = false
Sw_Mode_BreakAudio = false

Sw_Video = false
Sw_Audio = false


--getIPos: returns position in grid layout
-- qty: quantity of items already placed
-- rowlen: number of items per row
-- base: base position {x=,y=}  starting point
-- ofs: offset {x=,y=} distance between items  in x and y direction
local function GetIPos(qty, rowlen, base, ofs)
    local row,col = (qty-1)//(rowlen),(qty-1)%rowlen
    return { base.x + col*ofs.x, base.y + row*ofs.y }
end

function FeedbackColor (input,output)
    for i = 0, 8 do
        if i == input then
        Controls["Route_"..i.."_"..output].Color = "Green"
        else
        Controls["Route_"..i.."_"..output].Color = "Black"
        end
    end
end


