//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

pragma Singleton

import QtQuick			2.11
import QtQuick.Controls 2.4

QtObject {
	readonly property real uiScale:							preferencesModel.uiScale

	readonly property color white:							"white"
	readonly property color whiteBroken:					"#F5F5F5"
	readonly property color black:							"black"
	readonly property color gray:							"#d1d1d1"
	readonly property color grayDarker:						"#9A9A9A"
	readonly property color grayLighter:					"#E0E0E0"
	readonly property color grayMuchLighter:				"#ECECEC"
	readonly property color grayVeryMuchLighter:			"#F4F6F7"
	readonly property color blue:							"#419BF9"
	readonly property color blueDarker:						"#0069D9"
	readonly property color blueLighter:					"#97C4F2"
	readonly property color blueMuchLighter:				"#DCF1FB"
	readonly property color red:							"#FC625D"
	readonly property color redDarker:						"#CD0A0A"
	readonly property color green:							"#36CE4C"
	readonly property color yellowLight:					"#FFFFCA"
	readonly property color rose:							"#FFC0CB"
	readonly property color roseLight:						"#FEF1EC"
	readonly property color cyan:							"#39CEF9"
	readonly property color shadow:							"#33000000"

	readonly property color textEnabled:					black
	readonly property color textDisabled:					grayDarker
	readonly property color uiBackground:					grayMuchLighter
	readonly property color uiBorder:						grayDarker
	readonly property color fileMenuLightBorder:			grayMuchLighter
	readonly property color fileMenuColorBackground:		grayVeryMuchLighter

	readonly property color buttonColor:					uiBackground
	readonly property color buttonColorHovered:				grayLighter
	readonly property color buttonColorPressed:				gray
	readonly property color buttonBorderColor:				gray
	readonly property color buttonBorderColorHovered:		black

	readonly property color itemHighlight:					blueMuchLighter

	readonly property int itemPadding:						8	* uiScale
	readonly property int minPanelWidth:					200 * uiScale
	readonly property int resultWidth:						600	* uiScale
	readonly property int formWidth:						625	* uiScale
	readonly property int formMargin:						10	* uiScale
	readonly property int formExpanderHeaderHeight:			40  * uiScale

	readonly property int rowGridSpacing:					15 * uiScale
	readonly property int columnGridSpacing:				30 * uiScale
	readonly property int rowGroupSpacing:					5  * uiScale
	readonly property int columnGroupSpacing:				10 * uiScale
	readonly property int indentationLength:				20 * uiScale
	readonly property int borderRadius:						4  * uiScale
	readonly property int generalAnchorMargin:				8  * uiScale
	readonly property int generalMenuMargin:				12  * uiScale
	readonly property int rowSpacing:						12 * uiScale
	readonly property int subOptionOffset:					40 * uiScale

	readonly property int sliderWidth:						4   * uiScale
	readonly property int switchHeight:						15  * uiScale
	readonly property int shadowRadius:						10	* uiScale
	readonly property int labelSpacing:						4   * uiScale
	readonly property int spinBoxWidth:						50  * uiScale
	readonly property int sliderLength:						80  * uiScale
	readonly property int spinBoxHeight:					30  * uiScale
	readonly property int comboBoxHeight:					20  * uiScale
	readonly property int textFieldWidth:					200 * uiScale
	readonly property int textFieldHeight:					20  * uiScale
	readonly property int splitHandleWidth:					20  * uiScale
	readonly property int numericFieldWidth:				40  * uiScale
	readonly property int subMenuIconHeight:				13	* uiScale
	readonly property int titleBottomMargin:				5   * uiScale
	readonly property int jaspControlPadding:				3   * uiScale
	readonly property int ribbonButtonHeight:				72  * uiScale
	readonly property int variablesListTitle:				20  * uiScale
	readonly property int ribbonButtonPadding:				10  * uiScale
	readonly property int groupContentPadding:				10  * uiScale
	readonly property int sliderHandleDiameter:				16  * uiScale
	readonly property int defaultTextAreaHeight:			250 * uiScale
	readonly property int jaspControlHighlightWidth:		Math.max(2, 3 * uiScale)
	readonly property int defaultVariablesFormHeight:		350 * uiScale
	readonly property int defaultSingleItemListHeight:		49  * uiScale
	readonly property int defaultRectangularButtonHeight:	32 * uiScale
	readonly property int smallDefaultVariablesFormHeight:	200 * uiScale

	readonly property int scrollbarBoxWidth:				12  * uiScale
	readonly property int scrollbarBoxWidthBig:				16  * uiScale

	readonly property int messageBoxButtonHeight:			40  * uiScale
	readonly property int maximumFlickVelocity:				preferencesModel.maxFlickVelocity
	readonly property int hoverTime:						400
	readonly property int fileMenuSlideDuration:			150

	readonly property real ribbonScaleHovered:				1.1

	readonly property int menuItemHeight:					20  * uiScale
	readonly property int menuGroupTitleHeight:				40  * uiScale
	readonly property int menuHeaderHeight:					50  * uiScale
	readonly property real menuSpacing:						1   * uiScale
	readonly property real menuPadding:						10  * uiScale

	property font font
	font.bold:			false
	font.underline:		false
	font.pixelSize:		12 * uiScale
	font.family:		"SansSerif"

	property font fontLabel
	fontLabel.bold:			true
	fontLabel.underline:	false
	fontLabel.pixelSize:	18 * uiScale
	fontLabel.family:		"SansSerif"

	property font fontRibbon
	fontRibbon.bold:		false
	fontRibbon.underline:	false
	fontRibbon.pixelSize:	14 * uiScale
	fontRibbon.family:		"SansSerif"

	property font fontGroupTitle
	fontGroupTitle.bold:		true
	fontGroupTitle.underline:	false
	fontGroupTitle.pixelSize:	14 * uiScale
	fontGroupTitle.family:		"SansSerif"

	property font fontPrefOptionsGroupTitle
	fontPrefOptionsGroupTitle.bold:			true
	fontPrefOptionsGroupTitle.underline:	false
	fontPrefOptionsGroupTitle.pixelSize:	13 * uiScale
	fontPrefOptionsGroupTitle.family:		"SansSerif"

	readonly property color borderColor:					gray
	readonly property color focusBorderColor:				blueLighter
	readonly property color dependencyBorderColor:			green
	readonly property color dependencySelectedColor:		cyan
	readonly property color containsDragBorderColor:		green
	readonly property color itemHoverColor:					blueMuchLighter
	readonly property color itemSelectedColor:				blueDarker
	readonly property color itemSelectedNoFocusColor:		grayLighter
	readonly property color analysisBackgroundColor:		grayMuchLighter
	readonly property color controlBackgroundColor:			white
	readonly property color disableControlBackgroundColor:	whiteBroken
	readonly property color rowEvenColor:					controlBackgroundColor
	readonly property color rowOnevenColor:					whiteBroken
	readonly property color controlErrorBackgroundColor:	roseLight
	readonly property color controlErrorTextColor:			redDarker

	readonly property color buttonBackgroundColor:			blue
	readonly property color tooltipBackgroundColor:			yellowLight
	readonly property color debugBackgroundColor:			rose
	readonly property color errorMessagesBackgroundColor:	red
	readonly property color sliderPartOn:					blue
	readonly property color sliderPartOff:					grayDarker

	readonly property int toolTipDelay:		1500
	readonly property int toolTipTimeout:	4500

	readonly property Item _toolTipOverrideItem: Item
	{
		//These properties override those for ALL attached ToolTips in the application
		ToolTip.toolTip.background: Rectangle { color: tooltipBackgroundColor }
		ToolTip.toolTip.font:		font
	}
}
