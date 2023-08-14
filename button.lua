function button(display, functionApplied, w, h)
  return {
    w = w or 100,
    h = h or 100,
    functionApplied = functionApplied or function() print("No function") end,
    display = display or "N/A"
    
    }
end
