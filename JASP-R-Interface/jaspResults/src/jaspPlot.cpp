#include "jaspPlot.h"
#include "jaspResults.h"


jaspPlot::~jaspPlot()
{
#ifdef JASP_RESULTS_DEBUG_TRACES
	JASPprint("Destructor of JASPplot("+title+") is called! ");
#endif

	finalizedHandler();
}

std::string jaspPlot::dataToString(std::string prefix) const
{
	std::stringstream out;

	out <<
		prefix << "aspectRatio: "	<< _aspectRatio << "\n" <<
		prefix << "dims:        "	<< _width << "X" << _height << "\n" <<
		prefix << "error:       '"	<< _error << "': '" << _errorMessage << "'\n" <<
		prefix << "filePath:    "	<< _filePathPng << "\n" <<
		prefix << "status:      "	<< _status << "\n" ;//<<
		//prefix << "has plot:    "	<< (_plotObjSerialized.size() > 0 ? "yes" : "no") << "\n";

	return out.str();
}

Json::Value jaspPlot::dataEntry(std::string & errorMessage) const
{
	Json::Value data(jaspObject::dataEntry(errorMessage));

	data["title"]		= _title;
	data["convertible"]	= true;
	data["data"]		= _filePathPng;
	data["height"]		= _height;
	data["width"]		= _width;
	data["aspectRatio"]	= _aspectRatio;
	data["status"]		= _error ? "error" : _status;
	data["name"]		= getUniqueNestedName();

	return data;
}

void jaspPlot::initEnvName()
{
	static int counter = 0;

	_envName = "plot_" + std::to_string(counter++);
}

void jaspPlot::setPlotObject(Rcpp::RObject obj)
{
	Rcpp::List plotInfo = Rcpp::List::create(Rcpp::_["obj"] = obj, Rcpp::_["width"] = _width, Rcpp::_["height"] = _height);
	_filePathPng = "";

	if(!obj.isNULL())
	{
		static Rcpp::Function tryToWriteImage = jaspResults::isInsideJASP() ? Rcpp::Function("tryToWriteImageJaspResults") : Rcpp::Environment::namespace_env("jaspResults")["tryToWriteImageJaspResults"];
		Rcpp::List writeResult = tryToWriteImage(Rcpp::_["width"] = _width, Rcpp::_["height"] = _height, Rcpp::_["plot"] = obj);

		// we need to overwrite plot functions with their recordedplot result
		if(Rcpp::is<Rcpp::Function>(obj) && writeResult.containsElementNamed("obj"))
			plotInfo["obj"] = writeResult["obj"];
		
		if(writeResult.containsElementNamed("png"))
			_filePathPng = Rcpp::as<std::string>(writeResult["png"]);

		if(writeResult.containsElementNamed("error"))
		{
			_error			= "Error during writeImage";
			_errorMessage	= Rcpp::as<std::string>(writeResult["error"]);
		}

		if(_status == "waiting" || _status == "running")
			_status = "complete";
	}

	jaspResults::setObjectInEnv(_envName, plotInfo);
}

Rcpp::RObject jaspPlot::getPlotObject()
{
	Rcpp::RObject plotInfo = jaspResults::getObjectFromEnv(_envName);
	if (!plotInfo.isNULL() && Rcpp::is<Rcpp::List>(plotInfo))
	{
		
		Rcpp::List plotInfoList = Rcpp::as<Rcpp::List>(plotInfo);
		if (plotInfoList.containsElementNamed("obj"))
			return Rcpp::as<Rcpp::RObject>(plotInfoList["obj"]);
			
	}
	return R_NilValue;
}

void jaspPlot::setChangedDimensionsFromStateObject()
{
	Rcpp::RObject plotInfo = jaspResults::getObjectFromEnv(_envName);
	if (plotInfo.isNULL() || !Rcpp::is<Rcpp::List>(plotInfo))
		return;
	
	Rcpp::List plotInfoList = Rcpp::as<Rcpp::List>(plotInfo);
	
	if (plotInfoList.containsElementNamed("width"))
		_width = Rcpp::as<int>(plotInfoList["width"]);
	
	if (plotInfoList.containsElementNamed("height"))
		_height = Rcpp::as<int>(plotInfoList["height"]);
}

Json::Value jaspPlot::convertToJSON() const
{
	Json::Value obj		= jaspObject::convertToJSON();

	obj["aspectRatio"]			= _aspectRatio;
	obj["width"]				= _width;
	obj["height"]				= _height;
	obj["status"]				= _status;
	obj["filePathPng"]			= _filePathPng;
	obj["environmentName"]		= _envName;

	return obj;
}

void jaspPlot::convertFromJSON_SetFields(Json::Value in)
{
	jaspObject::convertFromJSON_SetFields(in);

	_aspectRatio	= in.get("aspectRatio",		0.0f).asDouble();
	_width			= in.get("width",			-1).asInt();
	_height			= in.get("height",			-1).asInt();
	_status			= in.get("status",			"complete").asString();
	_filePathPng	= in.get("filePathPng",		"null").asString();
	_envName		= in.get("environmentName",	_envName).asString();
	
	setChangedDimensionsFromStateObject();
	
	/*JASP_OBJECT_TIMERBEGIN
	std::string jsonPlotObjStr = in.get("plotObjSerialized", "").asString();
	_plotObjSerialized = Rcpp::Vector<RAWSXP>(jsonPlotObjStr.begin(), jsonPlotObjStr.end());
	JASP_OBJECT_TIMEREND(converting from JSON)*/
}

std::string jaspPlot::toHtml()
{
	std::stringstream out;

	out << "<div class=\"status " << _status << "\">" "\n"
		<< htmlTitle() << "\n";

	if(_error || _errorMessage != "")
	{
		out << "<p class=\"error\">\n";
		if(_error		      ) out << "error: <i>'" << _error << "'</i>";
		if(_errorMessage != "") out << (_error       ? " msg: <i>'" : "errormessage: <i>'") << _errorMessage << "'</i>";
		out << "\n</p>";
	}
	else
		out << "<img src=\"" << _filePathPng << "\" height=\"" << _height << "\" width=\"" << _width << "\" alt=\"a plot called " << _title << "\">";

	out << "</div>\n";

	return out.str();
}
