# Bouncer
Analytical solution to a bouncing ball written in Lua. Evaluate the position of a ball given initial conditions elasticity, lower wall, upper wall, positio, and velocity.

```lua
local bouncer = require("bouncer")

local bouncer0 = bouncer.new({
	position = 0;
	velocity = 3;
	minimum = -1;
	maximum = 2;
	elasticity = 0.83;
})

onupdate(function(time_now)
	bouncer0:update(time_now)
end)
```
