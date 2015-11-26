/**
 ********************************************************************************************************
 * @file    main.cpp
 * @brief   Main loop for nodes
 * @details Two main loops are created.  One for WGUI, and the other for the standalone nodes
 ********************************************************************************************************
 */

/*** INCLUDE FILES ***/

#include <QtGui>
#include <QWidget>
#include <QApplication>
#include <ros/ros.h>
#include <ros/network.h>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include "drc_gui/wgui.hpp"

#include <QMenuBar>
#include <QMainWindow>

#include "drc_gui/widgets/pump_control.hpp"
#include "drc_gui/widgets/pump_status.hpp"
#include "drc_gui/widgets/image_viewer.hpp"
#include "drc_gui/widgets/perception_viewer.hpp"
#include "drc_gui/widgets/mode_selector.hpp"
#include "drc_gui/widgets/error_status.hpp"
#include "drc_gui/widgets/robot_motion.hpp"
#include "drc_gui/widgets/steering_slider.hpp"
#include "drc_gui/widgets/drill_motion.hpp"
#include "drc_gui/widgets/plug_motion.hpp"
#include "drc_gui/widgets/joint_sliders.hpp"
#include "drc_gui/widgets/steering_slider.hpp"
#include "drc_gui/widgets/hand_control.hpp"
#include "drc_gui/widgets/ping_status.hpp"
#include "drc_gui/widgets/comm_status.hpp"
#include "drc_gui/widgets/fall_status.hpp"
#include "drc_gui/widgets/multisense_control.hpp"

#ifndef CONTROL_CLASS
#ifndef UNIT_TEST_CLASS

/**
 * @brief   Main loop for wgui node
 * @param   argc	:argument name
 * @param	argv	:argument value
 * @return  int		:0 if failed
 */
int main(int argc, char **argv)
{
	QNode *ros_node;
	ros_node = new QNode(argc, argv, "wgui");


	if (ros_node->isconnected())
	{

		ros_node->start();

		wGUI *wgui = new wGUI(argc, argv);

		wgui->connect(ros_node, SIGNAL(rosShutdown()), wgui, SLOT(quit()));

		int result = wgui->exec();
		delete wgui;
		delete ros_node;
		return result;
	} else
	{
		return 0;
	}

}
#endif
#else
#ifndef UNIT_TEST_CLASS

#ifndef NODE_NAME
#error "You must specify a node name in the CMakeLists.txt."

#else
/**
 * @brief   Main loop for individual nodes
 * @param   argc	:argument name
 * @param	argv	:argument value
 * @return  int		:0 if failed
 */
int main(int argc, char **argv)
{

	ros_node = new QNode(argc, argv, NODE_NAME);

	if (ros_node->isconnected())
	{
		QApplication app(argc, argv);
		QMainWindow window;
		CONTROL_CLASS control_class;
		QWidget *widget = control_class.NewUI();
		window.setWindowIcon(QIcon(":/icons/images/icon.png")); //Change the window icon
		window.setCentralWidget(widget);
		window.resize(widget->size());
		window.setWindowTitle(NODE_NAME);//Sets Window Title
		QMenu *fileMenu = window.menuBar()->addMenu(
				window.menuBar()->tr("File"));
		QAction *sendAct = new QAction(window.menuBar()->tr("Send"),
				window.menuBar());
		QAction *discardAct = new QAction(window.menuBar()->tr("Discard"),
				window.menuBar());
		control_class.connect(sendAct, SIGNAL(triggered()), &control_class,
				SLOT(SendCMD()));
		control_class.connect(discardAct, SIGNAL(triggered()), &control_class,
				SLOT(DiscardCMD()));
		fileMenu->addAction(sendAct);
		fileMenu->addAction(discardAct);
		window.show();
		app.connect(ros_node, SIGNAL(rosShutdown()), &window, SLOT(close()));
		app.connect(&app, SIGNAL(lastWindowClosed()), &app, SLOT(quit()));
		ros_node->start();
		int result = app.exec();
		delete ros_node;

		return result;
	} else
	return 0;

}
#endif
#endif
#endif

#ifdef UNIT_TEST_CLASS
#ifdef CONTROL_CLASS
#ifndef NODE_NAME
#error "You must specify a node name in the CMakeLists.txt."

#else
/**
 * @brief   Main loop for individual nodes
 * @param   argc	:argument name
 * @param	argv	:argument value
 * @return  int		:0 if failed
 */
int main(int argc, char **argv)
{
	ros_node = new QNode(argc, argv, NODE_NAME);

	if (ros_node->isconnected())
	{
		QApplication app(argc, argv);
		QMainWindow window;

		CONTROL_CLASS control_class;
		QWidget *widget = control_class.NewUI();

		UNIT_TEST_CLASS unit_test(&app,widget);

		app.connect(ros_node, SIGNAL(rosShutdown()), &app, SLOT(quit()));
		app.connect(&unit_test, SIGNAL(Shutdown()), &app, SLOT(quit()));

		ros_node->start();
		unit_test.start();
		int result = app.exec();
		delete ros_node;

		return result;
	} else
	return 0;


}
#endif
#endif
#endif

