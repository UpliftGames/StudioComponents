--[=[
	@class MainButton
	
	A variant of a [Button] used to indicate a primary action, for example an 'OK/Accept' button
	in a modal. 

	| Dark | Light |
	| - | - |
	| ![Dark](/StudioComponents/components/mainbutton/dark.png) | ![Light](/StudioComponents/components/mainbutton/light.png) |

	See the docs for [Button] for information about customization and usage.
]=]

local React = require("@pkg/@jsdotlua/react")

local BaseButton = require("./Foundation/BaseButton")
local StyleGuide = require("../StyleGuide")

--[=[
	@within MainButton
	@interface IconProps

	@field Image string
	@field Size Vector2
	@field Transparency number?
	@field Color Color3?
	@field UseThemeColor boolean?
	@field Alignment HorizontalAlignment?
	@field ResampleMode Enum.ResamplerMode?
	@field RectOffset Vector2?
	@field RectSize Vector2?
]=]

--[=[
	@within MainButton
	@interface Props
	@tag Component Props

	@field ... CommonProps
	@field AutomaticSize AutomaticSize?
	@field OnActivated (() -> ())?
	@field Text string?
	@field Icon IconProps?
]=]

local function MainButton(props: BaseButton.BaseButtonConsumerProps)
	local merged = table.clone(props) :: BaseButton.BaseButtonProps
	merged.BackgroundColorStyle = StyleGuide.Color.DialogMainButton
	merged.BorderColorStyle = StyleGuide.Color.DialogButtonBorder
	merged.TextColorStyle = StyleGuide.Color.DialogMainButtonText

	return React.createElement(BaseButton, merged)
end

return MainButton
