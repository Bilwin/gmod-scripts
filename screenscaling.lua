
function VerticalScale(size)
	return size * (ScrH() / 480.0)
end
VScale = VerticalScale

function ScreenScaleMin(size)
	return math.min(SScale(size), VScale(size))
end
SScaleMin = ScreenScaleMin
