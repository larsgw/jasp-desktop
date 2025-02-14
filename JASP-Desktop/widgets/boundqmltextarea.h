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


#ifndef BOUNDQMLTEXTAREA_H
#define BOUNDQMLTEXTAREA_H

#include "analysis/boundqmlitem.h"
#include "analysis/options/optionstring.h"
#include "lavaansyntaxhighlighter.h"
#include "listmodeltermsavailable.h"

#include <QObject>


class BoundQMLTextArea : public QObject, public BoundQMLItem
{
	Q_OBJECT
	
	enum TextType {Default, Lavaan, Model, Rcode};
	
public:
	BoundQMLTextArea(QQuickItem* item, AnalysisForm* form);

	void	bindTo(Option *option)						override;
	Option* createOption()								override;
	bool	isOptionValid(Option* option)				override;
	bool	isJsonValid(const Json::Value& optionValue) override;
	Option* boundTo()									override { return _boundTo; }
	void	resetQMLItem(QQuickItem *item)				override;
	void	rScriptDoneHandler(const QString &result)	override;
	
	ListModelTermsAvailable* allVariablesModel() { return _allVariablesModel; }

private slots:
	void checkSyntax();
	void dataSetChangedHandler();
    
protected:
	OptionString*				_boundTo = nullptr;
	QString						_text;
	TextType					_textType;
	QString						_applyScriptInfo;
	
	LavaanSyntaxHighlighter*	_lavaanHighlighter = nullptr;
	ListModelTermsAvailable*	_allVariablesModel = nullptr;
};


#endif // BOUNDQMLTEXTAREA_H
