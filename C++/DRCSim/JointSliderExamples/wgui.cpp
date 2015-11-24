/**
 ********************************************************************************************************
 * @file    wgui.cpp
 * @brief   WGUI Main Application class
 * @details Creates the main WGUI top level class
 ********************************************************************************************************
 */

/*** INCLUDE FILES ***/
#include <QtGui>
#include <QMessageBox>
#include <iostream>
#include "drc_gui/wgui.hpp"
#include <exception>      // std::exception

#include "drc_gui/wgui_window.hpp"
#include "drc_gui/widgets/pump_control.hpp"
#include "drc_gui/widgets/pump_status.hpp"
#include "drc_gui/widgets/image_viewer.hpp"
#include "drc_gui/widgets/perception_viewer.hpp"
#include "drc_gui/widgets/mode_selector.hpp"
#include "drc_gui/widgets/error_status.hpp"
#include "drc_gui/widgets/drill_motion.hpp"
#include "drc_gui/widgets/joint_sliders.hpp"
#include "drc_gui/widgets/steering_slider.hpp"
#include "drc_gui/widgets/hand_control.hpp"
#include "drc_gui/widgets/simplified_hand_control.hpp"
#include "drc_gui/widgets/ping_status.hpp"
#include "drc_gui/widgets/steering_slider.hpp"
#include "drc_gui/widgets/start_prep.hpp"
#include "drc_gui/widgets/comm_status.hpp"
#include "drc_gui/widgets/fall_status.hpp"
#include "drc_gui/widgets/multisense_control.hpp"
#include "drc_gui/widgets/com_cop_widget.hpp"
#include "drc_gui/widgets/door_motion.hpp"
#include "drc_gui/widgets/debris_motion.hpp"
#include "drc_gui/widgets/task_control.hpp"
#include "drc_gui/widgets/egress_motion.hpp"
#include "drc_gui/task_status_layout.hpp"
#include "drc_gui/widgets/hand_power.hpp"
#include "drc_gui/widgets/finite_state_machine.hpp"
#include "drc_gui/widgets/nudge_control.hpp"
#include "drc_gui/widgets/trajopt_confirm.hpp"
#include "drc_gui/widgets/battery_status.hpp"
#include "drc_gui/widgets/forearm_status.hpp"
#include "drc_gui/widgets/freeze_switch.hpp"
#include "drc_gui/widgets/manip.hpp"

/**
 * @note   None
 */
wGUI::wGUI(int &argc, char *argv[]) :
		QApplication(argc, argv), window_count(0)
{

	contoller_list.clear();
	main_windows.clear();

	/* Setup the nodes */

	new TrajOptConfirm();
	new TaskControl();
	new SimplifiedHandControl();
	new SteeringSlider();
	new PumpStatus();
	new PumpControl();
	new PingStatus();
	new PerceptionViewer();
	new NudgeControl();
	new MultisenseControlController();
	new ModeSelector();
	new ManipWidget();
	new JointSliders();
	new ImageViewer();
	new HandPower();
	new HandControl();
	new FallStatus();
	new ErrorStatus();
	new EgressMotion();
	new DrillMotion();
	new DoorMotion();
	new DebrisMotion();
	new CommStatus();
	new ComCopWidget();
	new BatteryStatus();
	new ForearmStatus();
	new FreezeSwitch();

	defaultFile = "";
	defaultFile.append(QDir::homePath());
	defaultFile.append("/wgui_layouts/default.wgui");
	this->dragged_window = NULL;

	wGUIWindow *window = createMainWindow();

	QDesktopWidget *desktop = this->desktop();

//	window->setGeometry(desktop->screenGeometry(desktop->primaryScreen()));
	connect(this, SIGNAL(lastWindowClosed()), this, SLOT(quit()));

	/*if (QFile(defaultFile).exists())
	{
		LoadDefault();

	}*/
}

/**
 * @note   None
 */
wGUI::~wGUI()
{
	quit();
}

bool wGUI::notify(QObject *receiver_, QEvent *event_)
{
	try
	{
		return QApplication::notify(receiver_, event_);
	} catch (std::exception &ex)
	{
		std::cerr << "std::exception was caught" << std::endl;
	}

	return false;
}

/**
 * @note   None
 */
wGUIWindow* wGUI::createMainWindow(void)
{
	wGUIWindow* window = new wGUIWindow(0, this);
	window_count++;
	window->show();
	return window;
}

wGUIWindow* wGUI::createStatusWindow(void)
{
	wGUIWindow* window = new wGUIWindow(1, this);
	window_count++;
	window->show();
	return window;
}

wGUIWindow* wGUI::createBlankWindow(void)
{
	wGUIWindow* window = new wGUIWindow(2, this);
	window_count++;
	window->show();
	return window;
}

void wGUI::SaveDefault(void)
{
	QString fileName = defaultFile;

	QSettings *settings = new QSettings(fileName, QSettings::IniFormat);
	Save(settings);
	delete settings; //cleanup
}

void wGUI::SaveFile(void)
{
//Open File Dialog
	QString fileName = QFileDialog::getSaveFileName(0, tr("Save layout"),
			QDir::homePath(), tr("WGUI files (*.wgui)"));
	;

	/* Did we get a valid filename? */
	if (fileName.isEmpty())
	{
		return;
	}

	/* Check file extension */
	QFileInfo file(fileName);
	if (!fileName.endsWith(".wgui"))
	//if (file.suffix() != ".wgui")
	{
		fileName.append(".wgui");
	}

	/* Create the settings file */
	QSettings *settings = new QSettings(fileName, QSettings::IniFormat);
	Save(settings);
	delete settings; //cleanup
}

void wGUI::Save(QSettings *settings)
{
	settings->clear();

	settings->beginGroup(WGUI_GROUP); //set group
	settings->setValue(WINDOW_COUNT_VALUE, main_windows.size()); //save number of windows

	/* Loop through and save each window */
	for (int i = 0; i < main_windows.size(); i++)
	{
		settings->beginGroup(
				QString("%1_%2").arg(WINDOW_GROUP, QString::number(i + 1)));

		main_windows[i]->Save(settings);

		settings->endGroup();
	}

	settings->endGroup();

	settings->sync(); //write the file

}

void wGUI::Load(QString fileName)
{
	/* Read the settings file */
	QSettings *settings = new QSettings(fileName, QSettings::IniFormat);

	/* Clear old stuff */
	QMessageBox *mbox = new QMessageBox;
	mbox->setWindowTitle(tr("Loading"));
	mbox->setText("Loading layout...");
	mbox->setStandardButtons(QMessageBox::NoButton);
	mbox->show();

	for (int i = 0; i < main_windows.size(); i++)
	{
		main_windows[i]->close();
	}

	settings->beginGroup(WGUI_GROUP);

	/* Loop through and save each window */
	for (int i = 0; i < settings->value(WINDOW_COUNT_VALUE).toInt(); i++)
	{

		settings->beginGroup(
				QString("%1_%2").arg(WINDOW_GROUP, QString::number(i + 1)));

		wGUIWindow *window = createBlankWindow();
		window->Load(settings);

		settings->endGroup();
	}
	settings->endGroup();

	delete settings; //cleanup
	delete mbox; //cleanup
}

void wGUI::LoadFile()
{
	//Open File Dialog
	QString fileName = QFileDialog::getOpenFileName(0, tr("Load layout"),
			QDir::homePath(), tr("WGUI files (*.wgui)"));

	/* Did we get a valid filename? */
	if (fileName.isEmpty())
	{
		return;
	}
	Load(fileName);
}

void wGUI::LoadDefault()
{
	QString fileName = defaultFile;

	try
	{
		Load(fileName);
	} catch (...)
	{
	}

}

