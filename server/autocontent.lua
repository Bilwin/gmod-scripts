local workshop_items = engine.GetAddons()
for i = 1, #workshop_items do resource.AddWorkshop(workshop_items[i].wsid) end