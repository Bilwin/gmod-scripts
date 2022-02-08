function VerticalScale(size)
	return size * (ScrH() / 480.0) -- 640x480 4:3
end; VScale = VerticalScale

function ScreenScaleMin(size)
	return math.min(SScale(size), VScale(size)) -- minvalue from SScale and VScale, useful for non widescreen monitors
end; SScaleMin = ScreenScaleMin