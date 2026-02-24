function updateColorbar(tcl,event)
    cb = findobj(tcl,Type="Colorbar");
    if isscalar(cb)
        if event.NewGridSize(1) > event.NewGridSize(2)
            cb.Layout.Tile = "south";
        else
            cb.Layout.Tile = "east";
        end
    end
end