/**
 ********************************************************************************************************
 * @file    joint_sliders.cpp
 * @brief   Joint Sliders Class
 * @details Used to control robot joints
 ********************************************************************************************************
 */

 // By - Aaron Jaeger


/*** INCLUDE FILES ***/
#include <drc_gui/widgets/joint_sliders.hpp>
//#include <wrecs_common/atlas_joint_limits.hpp>
#include "drc_gui/wgui.hpp"
#include <wrecs_msgs/field_command.h>

/*** NAMESPACE ***/
using namespace Qt;

/********************* CONTROLLER **********************/

/**
 * @note   None
 */
JointSliders::JointSliders() :
		wGUIWidgetController(), msg_mutex(),  pending_command(
				false) {
	/****************WGUI Setup****************/
	this->setObjectName(tr(JOINT_SLIDERS_NAME)); //This needs to be set

	/* This needs to be set for the dynamic menu */
	METAOBJS_INSERT(JointSlidersGUI);
	gui_meta = metaObjs["JointSlidersGUI"];

	sub_gui = true;
	/******************************************/

	// ros msg stuff

	this->jointInfo_pub = this->nh->advertise<wrecs_msgs::field_command>(WRECS_NAMES::GUI_JOINT_SLIDERS_CONTROL_TOPIC, 10);

	take the subscribed data, find the difference of it from the next q-state, send the next q-state command.

	this->jointInfo_sub = this->nh->subscribe(WRECS_NAMES::GUI_JOINT_SLIDERS_STATUS_TOPIC, 1,

		&JointSliders::JointSlidersMSG, this);
	/*
	* AutoUpdateTimer = this->nh->createTimer(ros::Duration(.1), &JointSliders::SendCallback, this);
	* AutoUpdateTimer.stop();
	*/

	//resize messages for joint arrays
	jointInfo.joint_active.resize(NUM_JOINTS);
	jointInfo.joint_states.name.resize(NUM_JOINTS);
	jointInfo.joint_states.position.resize(NUM_JOINTS);
	jointInfo.joint_states.velocity.resize(NUM_JOINTS);
	jointInfo.joint_states.effort.resize(NUM_JOINTS);



	//set all initial msgs to be 0 or blank
	for (int i = 0; i < NUM_JOINTS; i++) {
		jointInfo.joint_active[i] = 0;
		jointInfo.joint_states.name[i] = "";
		jointInfo.joint_states.position[i] = 0;
		jointInfo.joint_states.velocity[i]=0;
		jointInfo.joint_states.effort[i]=0;
	}
	this->DiscardCMD(); //zeros message
}

/**
 * @note   None
 */
JointSliders::~JointSliders() {

}

// for slider set up
// display name/position/force are there if someone wants to add a toggle
// in the future that will hide that information
SingleJointSliderGUI* JointSliders::NewJointSliderGUI(sldr_info *sldrinfo,
		bool display_name, bool display_position, bool display_force) {


		if (GUI_Count == 0)
		{
			spinner->start();
		}
		GUI_Count++; //increment number of GUI's


	return new SingleJointSliderGUI(this, sldrinfo, display_name,
			display_position, display_force);

}

/**
 * @note   This function has to exist in every class
 */

void JointSliders::SendCMD() {

        wrecs_msgs::field_command fcm;
	fcm.sendJointCommand = 0;
	for (int i = 0; i < NUM_JOINTS; i++) {
	    if (jointInfo.joint_active[i]) {
	        fcm.setThisJoint[i] = 1;
		fcm.position[i] = jointInfo.joint_states.position[i];
		fcm.sendJointCommand = 1;
	    }
	    else {
	        fcm.setThisJoint[i] = 0;
	    }
	}
	jointInfo_pub.publish(fcm);
	this->DiscardCMD();
}

/**
 * @note   This function has to exist in every class
 */
void JointSliders::DiscardCMD() {
	for (int i = 0; i < NUM_JOINTS; i++) {
		jointInfo.joint_active[i] = 0;
			}


	if(!autoSend){
	Q_EMIT this->SignalUpdate();
	}
}


/*
 * JointSlidersMSG handles incoming messages, matches updated joint values array of joints
 * JointSlidersMSG:sensor_msgs -> void
 */
void JointSliders::JointSlidersMSG(
		const sensor_msgs::JointState& joint_sliders_msg) {
	msg_mutex.lock();
	for (int i = 0; i < jointInfo.joint_states.name.size(); i++) {

		for (int j = 0; j < joint_sliders_msg.name.size(); j++){

			if(jointInfo.joint_states.name[i] == joint_sliders_msg.name[j]){
				jointInfo.joint_states.name[i] = joint_sliders_msg.name[j];
				if(jointInfo.joint_active[i]==false) {
				jointInfo.joint_states.position[i] = joint_sliders_msg.position[j];
				}
		//		jointInfo.joint_states.velocity[i] = joint_sliders_msg.velocity[j];
				jointInfo.joint_states.effort[i] = joint_sliders_msg.effort[j];
			}
		}
	}
	msg_mutex.unlock();
	Q_EMIT this->SignalUpdate();
}

 /*
  * When autosend is on, timer will do sendCMD on set time interval
  * note: timer is not being used for now.
  */
 /*
   void JointSliders::SendCallback(const ros::TimerEvent& event){
  		if(autoSend){
   SendCMD();
	}

	}
 */


JointSliders * JointSliders::GetInstance()
{
	for (int i = 0; i < contoller_list.size(); i++)
	{
		if (JOINT_SLIDERS_NAME == contoller_list[i]->objectName())
		{
			return (JointSliders*) contoller_list[i];
		}
	}
	return new JointSliders;
}
/************************* GUI *************************/

/**
 * @note   Setup for GUI
 */
JointSlidersGUI::JointSlidersGUI(QWidget *parent) :
		QWidget(parent), ui(new Ui::JointSlidersUI) {
	ui->setupUi(this); //display the UI
	parent_class = (JointSliders*) parent; //Set parent class so that we can access all of the custom variables

	// set up positioning of all the sliders
	// name, display name, left right hint, left hint, display position, display force, max_f, max_pos
	// there are 30/NUM_JOINTS joints in the atlas robot
	int spacing = 16;
	int sldr_width;
	SingleJointSliderGUI* slider;
	for (int j = 0; j < NUM_JOINTS; j++) {
		for(int i=0; i<NUM_JOINTS; i++){
			if (j== sldr_array[i].joint_num){
				SingleJointSliderGUI* slider = parent_class->NewJointSliderGUI(
				&sldr_array[i], true, true, true);
				slider->setParent(this);
				slider->move(0, spacing);
				spacing = spacing + (slider->height() + 2);
				sldr_width = slider->width();
				parent_class->jointInfo.joint_active[j] = 0;

				//separate joint categories with line
				if(sldr_array[i].categoryLine){
					makeNewLine(spacing);
					}
				}
			}
		}

	//position of buttons:
	ui->sendButton->move(50, spacing);
	ui->discardButton->move(170, spacing);
	ui->pos_lab->move(330,0);
	ui->frc_lab->move(400, 0);

	ui->AutoSendLabel->move(300,spacing+5);
	ui->AutoSendSlider->move(370,spacing);
	ui->AutoSendSlider->setMaximum(1);


    //	ui->AutoSendSlider->setDisabled(true); // useful if autosend breaks, set to true
    //	ui->AutoSendSlider->setStyleSheet("QSlider::handle:horizontal{background:#201F1F}");
	/*
	//initialize autosend as on;
	parent_class->autoSend = true;
	ui->AutoSendSlider->setSliderPosition(1);
	parent_class->AutoUpdateTimer.start();
    */
	//window sizing:
	setGeometry(0, 0, sldr_width, spacing + ui->discardButton->height());
	setMinimumHeight(spacing + ui->discardButton->height());
	setMinimumWidth(sldr_width);
	setMaximumHeight(spacing + ui->discardButton->height());
	setMaximumWidth(sldr_width);
	/* Create update timer */
	connect(parent_class, SIGNAL(SignalUpdate()), this, SLOT(GUIUpdate()));
	this->GUIUpdate();

}

/**
 * @note   None
 */
JointSlidersGUI::~JointSlidersGUI() {

		delete ui; //clean up
}

/*
 * Create new separator line
 */
void JointSlidersGUI::makeNewLine(int height) {
	line = new QFrame(this);
	line->setObjectName(QString::fromUtf8("line"));
	line->setFrameShape(QFrame::HLine);
	line->setLineWidth(2);
	line->setGeometry(QRect(0,height-2, 500, 2));
}
/*
 *  Turn on/off AutoSend new slider values
 */
void JointSlidersGUI::on_AutoSendSlider_valueChanged(int value)
{
	if(value==1){
	parent_class->autoSend=true;
	ui->AutoSendSlider->setStyleSheet("QSlider::groove:horizontal {background: green}");
	//parent_class->AutoUpdateTimer.start();
	//qDebug()<<"timer started";

	}
	else{
	parent_class->autoSend=false;
	ui->AutoSendSlider->setStyleSheet("");
	//parent_class->AutoUpdateTimer.stop();
	}
}
/**
 * @note   when button pressed, publish msgs for new position
 */

void JointSlidersGUI::on_sendButton_clicked() {
	parent_class->SendCMD();
}

/*
 * when discard button pressed, sets slider positions back to previous position (before slider was moved)
 */

void JointSlidersGUI::on_discardButton_clicked() {
	parent_class->DiscardCMD();

}
void JointSlidersGUI::GUIUpdate(void) {
	if(parent_class->autoSend){
		ui->AutoSendSlider->setSliderPosition(1);  // on
		ui->sendButton->setDisabled(true);
		ui->discardButton->setDisabled(true);
	}
	else {
		ui->AutoSendSlider->setSliderPosition(0);  // off
		ui->sendButton->setDisabled(false);
		ui->discardButton->setDisabled(false);
	}
}
/************************* Sub GUI *************************/

/**
 * @note  Set up for single slider gui
 * SingleJointSliderGUI: QWidget, sldr_info, bool, bool, bool -> void
 */

SingleJointSliderGUI::SingleJointSliderGUI(QWidget *parent, sldr_info *sldrinfo,
		bool display_name, bool display_position, bool display_force) :
		QWidget(parent), ui(new Ui::SingleJointSliderUI),
			j_num(sldrinfo->joint_num), display_posi(display_position),
			display_for(display_force), joint_display_name(sldrinfo->disp_name.c_str()),
			display_l_hint(sldrinfo->r_hint.c_str()), display_r_hint(sldrinfo->l_hint.c_str()) {
	ui->setupUi(this); //display the UI
	parent_class = (JointSliders*) parent; //Set parent class so that we can access all of the custom variables
	parent_class->jointInfo.joint_states.name[j_num] = sldrinfo->name; //set joint

	setStyleSheet("QScrollBar:horizontal {background: transparent}");

	//display left hint and right hint behind slider
	ui->l_hint->setText(display_l_hint);
	ui->l_hint->setStyleSheet("color: #909090; font-size:11px;");
	ui->r_hint->setText(display_r_hint);
	ui->r_hint->setStyleSheet("color: grey;font-size:11px");


	//if display_name is true, display slider name,
	//otherwise, dont show
	this->setObjectName(joint_display_name);
	if (display_name) {
		ui->JointName->setText(joint_display_name);

	} else {
		ui->JointName->setText(tr(""));
	}
	// set slider max and min
	ui->position_slider->setMinimum(sldrinfo->pos_min * 100);
	ui->position_slider->setMaximum(sldrinfo->pos_max * 100);


	/* Create update timer */
	connect(parent_class, SIGNAL(SignalUpdate()), this, SLOT(GUIUpdate()));
	this->GUIUpdate();
}

/*
 *  When slider is moved, updates position value
 *  And updates labels next to sliders
 * on_position_slider_sliderMoved : int -> void
 */
void SingleJointSliderGUI::on_position_slider_sliderMoved(int value) {
	//set joint to active
	//set slider value to joint position msg
	parent_class->jointInfo.joint_active[j_num] = true;
	parent_class->jointInfo.joint_states.position[j_num] =
			((float) value / 100);

	//update slider values label
	QString slidePos;
	//slidePos.append(QString("%1").arg(value));
	slidePos.sprintf("%6.2f",(float)value/100);

	if (display_posi) {
		colorChange();
		ui->display_pos->setText(slidePos);
	} else {
		ui->display_pos->setText(tr(""));
	}

}

/*
 * Updates sliders and labels when joint on robot moves
 * SldrUpdate: Double -> void
 */
void SingleJointSliderGUI::SldrUpdate(double newVal) {
	//change slider position
	ui->position_slider->setSliderPosition(newVal * 100);

	//update position labels
		QString slidePos;
		slidePos.sprintf("%6.2f",newVal);

		if (display_posi) {
			colorChange();
			ui->display_pos->setText(slidePos);

		} else {
			ui->display_pos->setText(tr(""));
		}

	//update force force labels
	QString slideFor;
	slideFor.sprintf("%6.0f",double(parent_class->jointInfo.joint_states.effort[j_num]));

	if (display_for) {
				ui->display_frc->setText(slideFor);
			}
	else {
				ui->display_frc->setText(tr(""));
			}

	//Change color of position value back to white when slider
	// after msg is published or discarded
	if(parent_class->jointInfo.joint_active[j_num]==true) {
		colorChange();
	}
}

/*
 * resets color of position value text
 */
void SingleJointSliderGUI::colorReset(){
	ui->display_pos->setStyleSheet("color: white");
}

/*
 * set alternate color of position value text
 */
void SingleJointSliderGUI::colorChange(){
	ui->display_pos->setStyleSheet("color: orange");
}
/*
 * autosend check, and send
 * will check if autosend is true, and then sendCMD
 */
void SingleJointSliderGUI::autoSendCheck(void) {
	if(parent_class->autoSend){
		parent_class->SendCMD();
	}
	else{}
}

/*
 * checks value of force on joints. If value nears limit, changes color of text as warning
 * 80% yellow
 * 90% red
 */
void SingleJointSliderGUI::frcLimitCheck(){
	float frcPercentHigh;
	float frcPercentLow;
	frcPercentHigh = parent_class->jointInfo.joint_states.effort[j_num] /g_frc_max[j_num];
	frcPercentHigh = parent_class->jointInfo.joint_states.effort[j_num] /g_frc_min[j_num];
	if(frcPercentHigh > .8){
		ui->display_frc->setStyleSheet("color: yellow");
		if(frcPercentHigh > .9){
			ui->display_frc->setStyleSheet("color: red");
		}
	}
	else if (frcPercentLow < -0.8){
		ui->display_frc->setStyleSheet("color: yellow");
		if(frcPercentLow < -0.9){
			ui->display_frc->setStyleSheet("color: red");
		}
	}
	else{
		ui->display_frc->setStyleSheet("");
	}
}
/**
 * This function automatically updates
 * Update sliders when incoming msg updates
 * Tells JointSliders to update
 * checks forces
 * resets color of position value after user has released slider
 */
void SingleJointSliderGUI::GUIUpdate(void) {
	parent_class->msg_mutex.lock();
		SldrUpdate(double(parent_class->jointInfo.joint_states.position[j_num]));
		frcLimitCheck();
		if(parent_class->jointInfo.joint_active[j_num]==false) {
			colorReset();
		}
	parent_class->msg_mutex.unlock();
}

SingleJointSliderGUI::~SingleJointSliderGUI() {
	parent_class->GUI_Count--; //decrement number of GUI's

	if(parent_class->GUI_Count == 0)
	{
		parent_class->spinner->stop();
	}
	delete ui; //clean up

}

/*
 *  triggered when slider is clicked
 */
/*
void SingleJointSliderGUI::on_position_slider_sliderPressed()
{

}
*/
/*
 * triggered when a slider is released
 * Will run SendCMD if autosend is turned on
 */
void SingleJointSliderGUI::on_position_slider_sliderReleased()
{
	if(parent_class->autoSend){
		parent_class->SendCMD();
	}
}


void SingleJointSliderGUI::on_position_slider_actionTriggered(int action)
{

	if (action == QAbstractSlider::SliderSingleStepAdd)
	{
		parent_class->jointInfo.joint_active[j_num] = true;
		parent_class->jointInfo.joint_states.position[j_num] += 0.01f; //increment the value
		int value = 100.0f
				* parent_class->jointInfo.joint_states.position[j_num];
		QString slidePos;
		slidePos.sprintf("%6.2f", (float) value / 100);
		if (display_posi)
		{
			colorChange();
			ui->display_pos->setText(slidePos);
		} else
		{
			ui->display_pos->setText(tr(""));
		}
		if (parent_class->autoSend)
		{
			parent_class->SendCMD();
		}
		//Comment
	} else if (action == QAbstractSlider::SliderSingleStepSub)
	{
		parent_class->jointInfo.joint_active[j_num] = true;
		parent_class->jointInfo.joint_states.position[j_num] -= 0.01f; //decrement the value
		int value = 100.0f
				* parent_class->jointInfo.joint_states.position[j_num];
		QString slidePos;
		slidePos.sprintf("%6.2f", (float) value / 100);
		if (display_posi)
		{
			colorChange();
			ui->display_pos->setText(slidePos);
		} else
		{
			ui->display_pos->setText(tr(""));
		}
		if (parent_class->autoSend)
		{
			parent_class->SendCMD();
		}
	}
}

