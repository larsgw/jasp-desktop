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

import QtQuick			2.8
import QtQuick.Layouts	1.3
import JASP.Controls	1.0
import JASP.Widgets		1.0
import JASP.Theme		1.0
import "./common" as ML

Form {

    VariablesForm {
        AvailableVariablesList { name: "variables" }
        AssignedVariablesList {
            id: target
            name: "target"
            title: qsTr("Target")
            singleVariable: true
            allowedColumns: ["scale"]
        }
        AssignedVariablesList {
            id: predictors
            name: "predictors"
            title: qsTr("Predictors")
            singleVariable: false
            allowedColumns: ["scale", "nominal", "ordinal", "nominalText"] 
        }
    }

    GroupBox {
        title: qsTr("Tables")

        CheckBox {
            text: qsTr("Evaluation metrics")
            name: "validationMeasures"
        }  

    }
    
    GroupBox {
        title: qsTr("Plots")

        CheckBox { 
            text: qsTr("Data split") 
            name: "dataSplitPlot"
            checked: true
        }

        CheckBox { 
            text: qsTr("Mean squared error") 
            name: "plotErrorVsK"
            enabled: optimizeModel.checked
        }
        
        CheckBox { 
            text: qsTr("Predictive performance") 
            name: "predictedPerformancePlot"
        }
    }
    
    ML.DataSplit { 
        trainingValidationSplit: optimizeModel.checked 
    }
    
    Section {
        title: qsTr("Training Parameters")
  
        GroupBox {
            title: qsTr("Algorithmic Settings")

            DropDown {
                name: "weights"
                indexDefaultValue: 0
                label: qsTr("Weights:")
                values:
                [
                    { label: "Rectangular", value: "rectangular"},
                    { label: "Epanechnikov", value: "epanechnikov"},
                    { label: "Biweight", value: "biweight"},
                    { label: "Triweight", value: "triweight"},
                    { label: "Cosine", value: "cos"},
                    { label: "Inverse", value: "inv"},
                    { label: "Gaussian", value: "gaussian"},
                    { label: "Rank", value: "rank"},
                    { label: "Optimal", value: "optimal"}
                ]
            }

            DropDown {
                name: "distanceParameterManual"
                indexDefaultValue: 0
                label: qsTr("Distance:")
                values:
                [
                    { label: "Euclidian", value: "2"},
                    { label: "Manhattan", value: "1"}
                ]
            }

            CheckBox { 
                text: qsTr("Scale variables") 
                name: "scaleEqualSD"
                checked: true
            }

            CheckBox { 
                name: "seedBox"
                text: qsTr("Set seed:")
                childrenOnSameRow: true

                DoubleField  { 
                    name: "seed"
                    defaultValue: 1
                    min: -999999
                    max: 999999
                    fieldWidth: 60 
                }
            }
        }

        RadioButtonGroup {
            title: qsTr("Number of Nearest Neighbors")
            name: "modelOpt"

            RadioButton { 
                text: qsTr("Fixed")                     
                name: "optimizationManual" 

                IntegerField { 
                    name: "noOfNearestNeighbours"
                    text: qsTr("Nearest neighbors:")
                    defaultValue: 3
                    min: 1
                    max: 50000
                    fieldWidth: 60
                }
            }
            
            RadioButton { 
                id: optimizeModel
                text: qsTr("Optimized")
                name: "optimizationError"
                checked: true 

                IntegerField { 
                    name: "maxK"
                    text: qsTr("Max. nearest neighbors:") 
                    defaultValue: 10 
                    min: 1
                    max: 50000
                    fieldWidth: 60
                }
            }
        }
    }

    Item {
        height: 			addValues.height*2
        Layout.fillWidth: 	true
        Layout.columnSpan: 2

        CheckBox {
            id: addValues
            name: "addValues"
            text: qsTr("Add predicted values to data")
            enabled:    predictors.count > 0 && target.count > 0
            anchors.top: parent.top

            ComputedColumnField { 
                id: 		valueColumn
                name: 		"valueColumn"
                text: 		"Column name: "
                fieldWidth: 120
                visible:    addValues.checked
            }

        }

        Button 
        {
            id: 			saveModel
            anchors.right: 	parent.right
            text: 			qsTr("<b>Save Model</b>")
            enabled: 		predictors.count > 0 && target.count > 0
            onClicked:      
            {
                
             }
            debug: true	
        }
    }
}
