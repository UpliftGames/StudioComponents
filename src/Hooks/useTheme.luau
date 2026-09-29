--[=[
	@class useTheme
	
	A hook used internally by components for reading the selected Studio Theme and thereby visually
	theming components appropriately. It is exposed here so that custom components can use this
	API to achieve the same effect. Calling the hook returns a [StudioTheme] instance. For example:

	```lua
	local function MyThemedComponent()
		local theme = useTheme()
		local color = theme:GetColor(
			Enum.StudioStyleGuideColor.ScriptBackground,
			Enum.StudioStyleGuideModifier.Default
		)
		return React.createElement("Frame", {
			BackgroundColor3 = color,
			...
		})
	end
	```
]=]

-- settings() is plugin-security locked; in a running game this hook can only
-- serve a theme provided through ThemeContext.
local hasStudioAccess, Studio = pcall(function()
	return settings().Studio
end)

local React = require("@pkg/@jsdotlua/react")

local ThemeContext = require("../Contexts/ThemeContext")

local function useTheme()
	local theme = React.useContext(ThemeContext)
	local studioTheme, setStudioTheme = React.useState(if hasStudioAccess then Studio.Theme else nil)

	React.useEffect(function()
		if theme or not hasStudioAccess then
			return
		end
		local connection = Studio.ThemeChanged:Connect(function()
			setStudioTheme(Studio.Theme)
		end)
		return function()
			connection:Disconnect()
		end
	end, { theme })

	return theme or studioTheme
end

return useTheme
