
QT += core
QT -= gui

include(../JASP.pri)
BUILDING_JASP_ENGINE=true

CONFIG += c++11
linux:CONFIG += -pipe

DESTDIR = ..
TARGET = JASPEngine
CONFIG   += cmdline config
CONFIG   -= app_bundle

TEMPLATE = app

target.path = $$INSTALLPATH
INSTALLS += target

DEPENDPATH = ..
PRE_TARGETDEPS += ../JASP-Common

unix: PRE_TARGETDEPS += ../JASP-Common
LIBS += -L.. -l$$JASP_R_INTERFACE_NAME -lJASP-Common

include(../R_HOME.pri) #needed to build r-packages

windows:CONFIG(ReleaseBuild) {
        LIBS += -llibboost_filesystem-vc141-mt-1_64 -llibboost_system-vc141-mt-1_64 -larchive.dll
}

windows:CONFIG(DebugBuild) {
        LIBS += -llibboost_filesystem-vc141-mt-gd-1_64 -llibboost_system-vc141-mt-gd-1_64 -larchive.dll
}

macx:LIBS += -lboost_filesystem-clang-mt-1_64 -lboost_system-clang-mt-1_64 -larchive -lz

linux {
    LIBS += -larchive
    exists(/app/lib/*)	{ LIBS += -L/app/lib }
    LIBS += -lboost_filesystem -lboost_system
}

$$JASPTIMER_USED {
    windows:CONFIG(ReleaseBuild)    LIBS += -llibboost_timer-vc141-mt-1_64 -llibboost_chrono-vc141-mt-1_64
    windows:CONFIG(DebugBuild)      LIBS += -llibboost_timer-vc141-mt-gd-1_64 -llibboost_chrono-vc141-mt-gd-1_64
    linux:                          LIBS += -lboost_timer -lboost_chrono
    macx:                           LIBS += -lboost_timer-clang-mt-1_64 -lboost_chrono-clang-mt-1_64
}

linux: LIBS += -L$$_R_HOME/lib -lR -lrt # because linux JASP-R-Interface is staticlib
macx:  LIBS += -L$$_R_HOME/lib -lR




macx {
        INCLUDEPATH += ../../boost_1_64_0
}

windows {
        INCLUDEPATH += ../../boost_1_64_0
}

INCLUDEPATH += $$PWD/../JASP-Common/

macx:QMAKE_CXXFLAGS_WARN_ON += -Wno-unused-parameter -Wno-unused-local-typedef
macx:QMAKE_CXXFLAGS += -Wno-c++11-extensions
macx:QMAKE_CXXFLAGS += -Wno-c++11-long-long
macx:QMAKE_CXXFLAGS += -Wno-c++11-extra-semi
macx:QMAKE_CXXFLAGS += -stdlib=libc++

win32:QMAKE_CXXFLAGS += -DBOOST_USE_WINDOWS_H -DNOMINMAX -DBOOST_INTERPROCESS_BOOTSTAMP_IS_SESSION_MANAGER_BASED

win32:LIBS += -lole32 -loleaut32

mkpath($$OUT_PWD/../R/library)

exists(/app/lib/*) {
  #for flatpak we can just use R's own library as it is contained anyway
    InstallJASPRPackage.commands        = \"$$R_EXE\" CMD INSTALL --no-multiarch $$PWD/JASP
    InstallJASPgraphsRPackage.commands	= \"$$R_EXE\" CMD INSTALL --no-multiarch $$PWD/JASPgraphs
} else {
    win32:RemoveJASPRPkgLock.commands   = IF exist \"$$OUT_PWD/../R/library/00LOCK-JASP/\" (rd /s /q \"$$OUT_PWD/../R/library/00LOCK-JASP/\" && echo Lock removed!) ELSE (echo No lock found!);
    win32:InstallJASPRPackage.commands  = \"$$R_EXE\" -e \".libPaths(\'$$OUT_PWD/../R/library\'); install.packages(\'$$PWD/JASP\', lib=\'$$OUT_PWD/../R/library\', repos=NULL, type=\'source\', INSTALL_opts=\'--no-multiarch\')\"
    unix: InstallJASPRPackage.commands  = export JASP_R_HOME=\"$$_R_HOME\" ; \"$$R_EXE\" -e \".libPaths(\'$$_R_HOME/library\'); install.packages(\'$$PWD/JASP\', lib=\'$$OUT_PWD/../R/library\', repos=NULL, type=\'source\', INSTALL_opts=\'--no-multiarch\')\"

    win32:RemoveJASPgraphsRPkgLock.commands   = IF exist \"$$OUT_PWD/../R/library/00LOCK-JASPgraphs/\" (rd /s /q \"$$OUT_PWD/../R/library/00LOCK-JASPgraphs/\" && echo Lock removed!) ELSE (echo No lock found!);
    win32:InstallJASPgraphsRPackage.commands  = \"$$R_EXE\" -e \".libPaths(\'$$OUT_PWD/../R/library\'); install.packages(\'$$PWD/JASPgraphs\', lib=\'$$OUT_PWD/../R/library\', repos=NULL, type=\'source\', INSTALL_opts=\'--no-multiarch\')\"
    unix: InstallJASPgraphsRPackage.commands  = export JASP_R_HOME=\"$$_R_HOME\" ; \"$$R_EXE\" -e \".libPaths(\'$$_R_HOME/library\'); install.packages(\'$$PWD/JASPgraphs\', lib=\'$$OUT_PWD/../R/library\', repos=NULL, type=\'source\', INSTALL_opts=\'--no-multiarch\')\"
}

win32 {
  InstallJASPgraphsRPackage.depends = RemoveJASPgraphsRPkgLock
  InstallJASPRPackage.depends = RemoveJASPRPkgLock

  QMAKE_EXTRA_TARGETS += RemoveJASPgraphsRPkgLock
  POST_TARGETDEPS     += RemoveJASPgraphsRPkgLock

  QMAKE_EXTRA_TARGETS += RemoveJASPRPkgLock
  POST_TARGETDEPS     += RemoveJASPRPkgLock
}

QMAKE_EXTRA_TARGETS += InstallJASPgraphsRPackage
POST_TARGETDEPS     += InstallJASPgraphsRPackage

QMAKE_EXTRA_TARGETS += InstallJASPRPackage
POST_TARGETDEPS     += InstallJASPRPackage

QMAKE_CLEAN += $$OUT_PWD/../R/library/*

SOURCES += main.cpp \
  engine.cpp \
    rbridge.cpp

HEADERS += \
  engine.h \
    rbridge.h

DISTFILES += \
    JASP/DESCRIPTION \
    JASP/NAMESPACE \
    JASP/R/abtestbayesian.R \
    JASP/R/ancova.R \
    JASP/R/ancovabayesian.R \
    JASP/R/ancovamultivariate.R \
    JASP/R/anova.R \
    JASP/R/anovabayesian.R \
    JASP/R/anovamultivariate.R \
    JASP/R/anovaoneway.R \
    JASP/R/anovarepeatedmeasures.R \
    JASP/R/anovarepeatedmeasuresbayesian.R \
    JASP/R/assignFunctionInPackage.R \
    JASP/R/bainancovabayesian.R \
    JASP/R/bainanovabayesian.R \
    JASP/R/bainregressionlinearbayesian.R \
    JASP/R/bainttestbayesianindependentsamples.R \
    JASP/R/bainttestbayesianonesample.R \
    JASP/R/bainttestbayesianpairedsamples.R \
    JASP/R/base64.R \
    JASP/R/bayesianAudit.R \
    JASP/R/bayesianPlanning.R \
    JASP/R/binomialtest.R \
    JASP/R/binomialtestbayesian.R \
    JASP/R/cfa.R \
    JASP/R/classicalAudit.R \
    JASP/R/classicalmetaanalysis.R \
    JASP/R/classicalPlanning.R \
    JASP/R/common.R \
    JASP/R/commonAnovaBayesian.R \
    JASP/R/commonAudit.R \
    JASP/R/commonAuditSampling.R \
	JASP/R/commonbayesianttest.R \
    JASP/R/commonBayesianAuditMethods.R \
    JASP/R/commonClassicalAuditMethods.R \
    JASP/R/commonerrorcheck.R \
    JASP/R/commonglm.R \
    JASP/R/commonMachineLearningClassification.R \
    JASP/R/commonMachineLearningClustering.R \
    JASP/R/commonMachineLearningRegression.R \
    JASP/R/commonmessages.R \
    JASP/R/commonMPR.R \
    JASP/R/commonsummarystats.R \
    JASP/R/commonsummarystatsttestbayesian.R \
    JASP/R/commonTTest.R \
    JASP/R/contingencytables.R \
    JASP/R/contingencytablesbayesian.R \
    JASP/R/correlation.R \
    JASP/R/correlationbayesian.R \
    JASP/R/correlationbayesianpairs.R \
    JASP/R/correlationpartial.R \
    JASP/R/descriptives.R \
    JASP/R/distributionSamplers.R \
    JASP/R/emmeans.rma.R \
    JASP/R/exploratoryfactoranalysis.R \
    JASP/R/exposeUs.R \
    JASP/R/friendlyConstructorFunctions.R \
    JASP/R/informedbayesianttestfunctions.R \
    JASP/R/linearmixedmodels.R \
    JASP/R/manova.R \
    JASP/R/massStepAIC.R \
    JASP/R/mediationanalysis.R \
    JASP/R/mlClassificationBoosting.R \
    JASP/R/mlClassificationKnn.R \
    JASP/R/mlClassificationLda.R \
    JASP/R/mlClassificationRandomForest.R \
    JASP/R/mlClusteringDensityBased.R \
    JASP/R/mlClusteringFuzzyCMeans.R \
    JASP/R/mlClusteringHierarchical.R \
    JASP/R/mlClusteringKMeans.R \
    JASP/R/mlClusteringRandomForest.R \
    JASP/R/mlRegressionBoosting.R \
    JASP/R/mlRegressionKnn.R \
    JASP/R/mlRegressionRandomForest.R \
    JASP/R/mlRegressionRegularized.R \
    JASP/R/multilevelmetaanalysis.R \
    JASP/R/multinomialtest.R \
    JASP/R/multinomialtestbayesian.R \
    JASP/R/networkanalysis.R \
    JASP/R/packagecheck.R \
    JASP/R/principalcomponentanalysis.R \
    JASP/R/quick.influence.R \
    JASP/R/r11tlearn.R \
    JASP/R/regressionlinear.R \
    JASP/R/regressionlinearbayesian.R \
    JASP/R/regressionlogistic.R \
    JASP/R/regressionloglinear.R \
    JASP/R/regressionloglinearbayesian.R \
    JASP/R/reinforcementlearningr11tlearning.R \
    JASP/R/reliabilityanalysis.R \
    JASP/R/semsimple.R \
    JASP/R/summarystatsbinomialtestbayesian.R \
    JASP/R/summarystatscorrelationbayesianpairs.R \
    JASP/R/summarystatsregressionlinearbayesian.R \
    JASP/R/summarystatsttestbayesianindependentsamples.R \
    JASP/R/summarystatsttestbayesianonesample.R \
    JASP/R/summarystatsttestbayesianpairedsamples.R \
    JASP/R/transformFunctions.R \
    JASP/R/ttestbayesianindependentsamples.R \
    JASP/R/ttestbayesianonesample.R \
    JASP/R/ttestbayesianpairedsamples.R \
    JASP/R/ttestindependentsamples.R \
    JASP/R/ttestonesample.R \
    JASP/R/ttestpairedsamples.R \
    JASP/R/ttestplotfunctions.R \
    JASPgraphs/DESCRIPTION \
    JASPgraphs/NAMESPACE \
    JASPgraphs/R/colorPalettes.R \
    JASPgraphs/R/compatability.R \
    JASPgraphs/R/convenience.R \
    JASPgraphs/R/customGeoms.R \
    JASPgraphs/R/descriptivesPlots.R \
    JASPgraphs/R/functions.R \
    JASPgraphs/R/getPrettyAxisBreaks.R \
    JASPgraphs/R/ggMatrixPlot.R \
    JASPgraphs/R/graphOptions.R \
    JASPgraphs/R/highLevelPlots.R \
    JASPgraphs/R/jaspLabelAxes.R \
    JASPgraphs/R/jaspScales.R \
    JASPgraphs/R/legendToPlotRatio.R \
    JASPgraphs/R/parseThis.R \
    JASPgraphs/R/PlotPieChart.R \
    JASPgraphs/R/PlotPizza.R \
    JASPgraphs/R/PlotPriorAndPosterior.R \
    JASPgraphs/R/plotQQnorm.R \
    JASPgraphs/R/PlotRobustnessSequential.R \
    JASPgraphs/R/printJASPgraphs.R \
    JASPgraphs/R/themeJasp.R \
    JASPgraphs/R/todo.R \
    JASPgraphs/man/colors.Rd \
    JASPgraphs/man/drawBFpizza.Rd \
    JASPgraphs/man/makeGridLines.Rd \
    JASPgraphs/man/parseThis.Rd \
    JASPgraphs/man/plotPieChart.Rd \
    JASPgraphs/man/PlotPriorAndPosterior.Rd \
    JASPgraphs/man/plotQQnorm.Rd \
    JASPgraphs/man/PlotRobustnessSequential.Rd \
    JASPgraphs/inst/examples/ex-colorPalettes.R \
    JASPgraphs/inst/examples/ex-PlotPieChart.R

