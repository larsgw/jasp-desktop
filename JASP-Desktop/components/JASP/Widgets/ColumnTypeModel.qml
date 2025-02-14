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

import QtQuick 2.0

ListModel
{
	ListElement
	{
		displayText		: "Scale"
		menuImageSource	: "qrc:/icons/variable-scale.svg"
		isEnabled		: true
	}
	ListElement
	{
		displayText		: "Ordinal"
		menuImageSource	: "qrc:/icons/variable-ordinal.svg"
		isEnabled		: true
	}
	ListElement
	{
		displayText		: "Nominal"
		menuImageSource	: "qrc:/icons/variable-nominal.svg"
		isEnabled		: true
	}
}
