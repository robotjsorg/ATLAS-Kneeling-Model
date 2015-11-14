/**
 ********************************************************************************************************
 * @file    joint_sliders.hpp
 * @brief   Joint Sliders Class
 * @details Used for joint sliders
 ********************************************************************************************************
 */

#ifndef JOINT_SLIDERS_HPP
#define JOINT_SLIDERS_HPP

/*** INCLUDE FILES ***/

#include <QtGui>
#include <QWidget>
#include <QMutex>
#include <QTimer>

 #include <QMetaType>
#include <string>
#include <ros/ros.h>

#include "ui_single_joint_slider.h"
#include "ui_joint_sliders.h"
#include <ros/publisher.h>
#include <ros/subscriber.h>
#include "drc_gui/qnode.hpp"
#include <wrecs_common/WRECS_Names.h>
#include <sensor_msgs/JointState.h>
#include <wrecs_common/AtlasLimits.h>
#include <wrecs_common/atlas_joint_limits.hpp>
#include <wrecs_msgs/AtlasSelectedJointStates.h>
#include "drc_gui/widgets/widget.hpp"
#include <pthread.h>

#define JOINT_SLIDERS_NAME "Joint Sliders"



/********************* CONTROLLER **********************/
class JointSlidersGUI;
class SingleJointSliderGUI;

/**
 * @brief   The Joint Sliders Control Class
 */
class JointSliders: public wGUIWidgetController
{
		friend class JointSlidersGUI;

	Q_OBJECT

	public:

		/**
		 * @brief   Template Widget class constructor
		 * @param   parent:     Pointer to the parent widget
		 * @return  Template Widget object
		 */

		explicit JointSliders();

		/**
		 * @brief   Template Widget class destructor
		 * @param   None
		 * @return  None
		 */
		~JointSliders();

		static JointSliders * GetInstance();

		wrecs_msgs::AtlasSelectedJointStates jointInfo;
		bool pending_command;
		QMutex msg_mutex;
		bool sliderDone;

		bool autoSend;
		SingleJointSliderGUI* NewJointSliderGUI(sldr_info *sldrinfo,
				bool display_name,
				bool display_position, bool display_force);


	Q_SIGNALS:

		/**
		 * @brief   Update Signal
		 * @param   None
		 * @return  None
		 */
		void SignalUpdate();

	public Q_SLOTS:
		//All of the GUI functions need to be under here

		/**
		 * @brief   Sends message for class
		 * @param   None
		 * @return  None
		 */
		void SendCMD(void);
	//	void SendCallback(const ros::TimerEvent& event);


		/**
		 * @brief   Discards message for class
		 * @param   None
		 * @return  None
		 */
		void DiscardCMD(void);

	private:
		void JointSlidersMSG(const sensor_msgs::JointState& joint_sliders_msg);
		ros::Subscriber jointInfo_sub;
		ros::Publisher jointInfo_pub;
		//ros::Timer AutoUpdateTimer;

};



/************************* GUI *************************/

/**
 * @brief   The Template Widget GUI Class
 */
class JointSlidersGUI: public QWidget
{
	Q_OBJECT

	public:
	JointSliders *parent_class; //stores parent class (control class)
		/**
		 * @brief   Joint Sliders GUI class constructor
		 * @param   parent:     Pointer to the parent widget
		 * @return Joint Sliders object
		 */

	Q_INVOKABLE JointSlidersGUI(QWidget *parent);

		/**
		 * @brief   Joint Sliders GUI class destructor
		 * @param   None
		 * @return  None
		 */
		~JointSlidersGUI();
		Ui::JointSlidersUI *ui; //stores ui for class



	private Q_SLOTS:
		//All of the GUI functions need to be under here

		/**
		 * @brief   GUI Update action
		 * @param   None
		 * @return  None
		 */
		void GUIUpdate();
		void on_sendButton_clicked();
		void on_discardButton_clicked();
		void on_AutoSendSlider_valueChanged(int value);
		void makeNewLine(int height);



	private:
		QFrame *line;
};

/************************* Sub GUI *************************/

/**
 * @brief   The Template Widget GUI Class
 */
class SingleJointSliderGUI: public QWidget

{
	Q_OBJECT

	public:

		/**
		 * @brief   Joint Sliders GUI class constructor
		 * @param   parent:     Pointer to the parent widget
		 * @return  Joint Sliders object
		 */
	void autoSendCheck();
	void colorReset();
	void colorChange();
	void frcLimitCheck();

	Q_INVOKABLE SingleJointSliderGUI(QWidget *parent, sldr_info *sldrinfo, bool display_name,
			bool display_position=true, bool display_force=false);

		/**
		 * @brief   Joint Sliders GUI class destructor
		 * @param   None
		 * @return  None
		 */
		~SingleJointSliderGUI();


		Ui::SingleJointSliderUI *ui; //stores ui for clas

	private Q_SLOTS:
		//All of the GUI functions need to be under here

		/**
		 * @brief   GUI Update action
		 * @param   None
		 * @return  None
		 */
		void GUIUpdate();
		void on_position_slider_sliderMoved(int value);
		//void on_position_slider_sliderPressed();
		void on_position_slider_sliderReleased();
		void on_position_slider_actionTriggered(int action);


	private:
		bool display_posi;
		bool display_for;
		int j_num;
		void SldrUpdate(double newVal);




	QString joint_display_name;
	QString display_l_hint;
	QString display_r_hint;
	public:
	JointSliders *parent_class; //stores parent class (control class)


};

#endif //JOINT_SLIDERS_HPP

