-- disable viewrender header when not focused
hook.Add('PreRender', 'viewrender.disable', function() return not system.HasFocus() end)