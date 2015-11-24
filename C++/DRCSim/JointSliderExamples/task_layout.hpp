/**
 ********************************************************************************************************
 * @file    task_layout.hpp
 * @brief   task_layout widget class
 * @details Used to control GUI interface for task_layout
 ********************************************************************************************************
 */

#ifndef TASK_LAYOUT_HPP
#define TASK_LAYOUT_HPP

/*** INCLUDE FILES ***/

#include <QtGui>
#include <QWidget>
#include <QTimer>
#include <ros/ros.h>
#include <boost/bind.hpp>
#include <QObject>
#include <QGridLayout>

#include <drc_gui/widgets/battery_status.hpp>
#include <drc_gui/widgets/forearm_status.hpp>
#include <drc_gui/widgets/pump_status.hpp>
#include <drc_gui/widgets/multisense_control.hpp>
#include <drc_gui/widgets/joint_sliders.hpp>
#include <drc_gui/widgets/hand_control.hpp>
#include <drc_gui/widgets/comm_status.hpp>
#include <drc_gui/widgets/error_status.hpp>
#include <drc_gui/widgets/com_cop_widget.hpp>
#include <drc_gui/widgets/mode_selector.hpp>
#include <drc_gui/widgets/ping_status.hpp>
#include <drc_gui/widgets/perception_viewer.hpp>
#include <drc_gui/widgets/pump_control.hpp>
#include <drc_gui/widgets/task_control.hpp>
#include <drc_gui/widgets/simplified_hand_control.hpp>
#include <drc_gui/widgets/steering_slider.hpp>
#include <drc_gui/widgets/com_cop_widget.hpp>
#include "drc_gui/widgets/error_status.hpp"
#include "drc_gui/widgets/nudge_control.hpp"
#include "drc_gui/widgets/trajopt_confirm.hpp"
#include "drc_gui/widgets/knee_camera_viewer.hpp"
#include "drc_gui/widgets/freeze_switch.hpp"
#include "drc_gui/widgets/manip.hpp"


#include "ui_task_layout.h"



/************************* GUI *************************/

/**
 * @brief   The RViz GUI Class
 */
class TaskLayout: public QWidget {
Q_OBJECT

public:

	/**
	 * @brief   RobotMotion GUI class constructor
	 * @param   parent:     Pointer to the parent widget
	 * @return  RobotPreview object
	 */
	Q_INVOKABLE
	TaskLayout(QWidget *parent = 0);

	/**
	 * @brief   RobotMotion GUI class destructor
	 * @param   None
	 * @return  None
	 */
	virtual ~TaskLayout();



	Ui::TaskLayoutUI *ui; //stores ui for class



private Q_SLOTS:

		void MainWindowUpdate(int TaskNumber);
		void clearLayout(QLayout* layout);

private:
//		QWidget *task_control_widget;		//1
//		QWidget *pump_control_widget;		//2
//		QWidget *perception_viewer_widget;	//3
//		QWidget *joint_sliders_widget;		//4
//		QWidget *mode_selector_widget;		//5
//		QWidget *hand_control_widget;		//6
//		QWidget *step_control_widget;		//7
//		QWidget *comm_status_widget;		//8
//		QWidget *steering_slider_widget;	//9
//		QWidget *image_viewer_widget;		//10
//		QWidget *pump_status_widget;		//11
//		QWidget *ping_status_widget;		//12
//		QWidget *ping_status_widget;		//12



};

#endif // TASK_LAYOUT_HPP
