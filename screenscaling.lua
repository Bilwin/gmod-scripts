
do
    local scale_factor_x = 1 / 1920
    local scale_factor_y = 1 / 1080

    function math.Scale(size)
      return math.floor(size * (ScrH() * scale_factor_y))
    end

    function math.ScaleX(size)
      return math.floor(size * (ScrW() * scale_factor_x))
    end

    function math.ScaleSize(x, y)
      return math.ScaleX(x), math.Scale(y)
    end

    math.ScaleY      = math.Scale
    math.ScaleW  = math.ScaleX
    math.ScaleH = math.Scale
end

function VerticalScale(size)
	return size * (ScrH() / 480.0)
end
VScale = VerticalScale

function ScreenScaleMin(size)
	return math.min(SScale(size), VScale(size))
end
SScaleMin = ScreenScaleMin

function YScale(size)
	return math.Round(size * math.min(ScrW(), ScrH())/1080)
end