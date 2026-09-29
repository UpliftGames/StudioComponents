--[=[
	@class StyleGuide

	Drop-in replacements for `Enum.StudioStyleGuideColor` and `Enum.StudioStyleGuideModifier`.
	Those enums only exist in Studio builds, so indexing them in a live game throws. Outside
	Studio, each member is a frozen `{ Name = "MemberName" }` table instead, which a theme provided
	through [ThemeContext] can key on by name.

	```lua
	theme:GetColor(StyleGuide.Color.MainBackground, StyleGuide.Modifier.Hover)
	```
]=]

local function resolve(enumName: string): any
	local ok, enum = pcall(function()
		return (Enum :: any)[enumName]
	end)
	if ok then
		return enum
	end
	return setmetatable({}, {
		__index = function(self, memberName: string)
			local member = table.freeze({ Name = memberName })
			rawset(self, memberName, member)
			return member
		end,
	})
end

return {
	Color = resolve("StudioStyleGuideColor") :: typeof(Enum.StudioStyleGuideColor),
	Modifier = resolve("StudioStyleGuideModifier") :: typeof(Enum.StudioStyleGuideModifier),
}
