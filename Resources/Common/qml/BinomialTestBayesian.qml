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
import QtQuick 2.8
import QtQuick.Layouts 1.3
import JASP.Controls 1.0
import JASP.Widgets 1.0

Form
{
	usesJaspResults: false
	
	VariablesForm
	{
		AssignedVariablesList { name: "variables"; allowedColumns: ["ordinal", "nominal"] }
	}
	
	DoubleField { text: qsTr("Test value: "); name: "testValue"; defaultValue: 0.5 ; doubleValidator { top: 1; decimals: 2 } }
	
	GridLayout
	{
		RadioButtonGroup
		{
			title: qsTr("Hypothesis")
			name: "hypothesis"
			RadioButton { value: "notEqualToTestValue";		text: qsTr("≠ Test value"); checked: true	}
			RadioButton { value: "greaterThanTestValue";	text: qsTr("> Test value")					}
			RadioButton { value: "lessThanTestValue";		text: qsTr("< Test value")					}
		}
		
		GroupBox {
			title: qsTr("Plots")
			CheckBox { name: "plotPriorAndPosterior";				text: qsTr("Prior and posterior"); id: plotPriorAndPosterior }
			CheckBox { name: "plotPriorAndPosteriorAdditionalInfo"; text: qsTr("Additional info"); checked: true; enabled: plotPriorAndPosterior.checked; indent: true }
			CheckBox { name: "plotSequentialAnalysis";				text: qsTr("Sequential analysis") }
		}
		
		BayesFactorType {}
		
		GroupBox
		{
			title: qsTr("Prior")
			DoubleField { name: "priorA"; text: qsTr("Beta prior: parameter a"); defaultValue: 1; doubleValidator { bottom: 0.1; top: 9999; decimals: 1} }
			DoubleField { name: "priorB"; text: qsTr("Beta prior: parameter b"); defaultValue: 1; doubleValidator { bottom: 0.1; top: 9999; decimals: 1} }
		}
	}
}