local floor = math.floor
local ln    = math.log

local function solved(p, v, k, p0, p1, x)
	local d = p1 - p0

	local function bx(x)
		return floor(ln(d/(d - v*x + v*x/k))/ln(k))
	end

	local function vx(x)
		return v*k^floor(ln(d*k/(d*k + v*x - k*v*x))/ln(k))
	end
	
	local function xb(b)
		return d*k^(1 - b)*(k^b - 1)/((k - 1)*v)
	end

	local function fp(x)
		return (-1)^bx(x)*vx(x)*(x - xb(bx(x)))%d%d
	end

	local function fv(x)
		return vx(x)*(-1)^bx(x)
	end

	if v < 0 then
		v = -v
		return
			p1 - fp(x - (p - p1)/v),
			-fv(x - (p - p1)/v)
	else
		return
			p0 + fp(x + (p - p0)/v),
			fv(x + (p - p0)/v)
	end
end

local bouncer = {}

function bouncer.new(prop)
	local self = {}

	self.tick       = prop.tick       or tick()
	self.position   = prop.position   or 0
	self.velocity   = prop.velocity   or 1
	self.elasticity = prop.elasticity or 1/2
	self.minimum    = prop.minimum    or -1/2
	self.maximum    = prop.maximum    or 1

	return self
end

function bouncer.update(self, tick1)
	self.position, self.velocity = solved(self.position, self.velocity, self.elasticity, self.minimum, self.maximum, tick1 - self.tick)
	self.tick = tick1
end

return bouncer